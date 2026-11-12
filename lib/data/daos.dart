import 'dart:convert';

import 'package:drift/drift.dart';

import '../domain/models.dart';
import '../domain/report_templates.dart';
import '../domain/section_a.dart';
import '../domain/settings_keys.dart';
import 'database.dart';

String _like(String q) => '%${q.trim()}%';

// ===================================================================== consumers

class ConsumersDao {
  ConsumersDao(this.db);
  final AppDatabase db;

  Stream<List<ConsumerRow>> watchAll({String query = ''}) {
    final s = db.select(db.consumers);
    if (query.trim().isNotEmpty) {
      s.where((c) =>
          c.accountNo.like(_like(query)) | c.name.like(_like(query)));
    }
    s.orderBy([(c) => OrderingTerm.asc(c.name)]);
    return s.watch();
  }

  Future<ConsumerRow?> getById(int id) =>
      (db.select(db.consumers)..where((c) => c.id.equals(id)))
          .getSingleOrNull();

  Stream<ConsumerRow?> watchById(int id) =>
      (db.select(db.consumers)..where((c) => c.id.equals(id)))
          .watchSingleOrNull();

  Future<ConsumerRow?> findByAccount(String accountNo) =>
      (db.select(db.consumers)..where((c) => c.accountNo.equals(accountNo.trim())))
          .getSingleOrNull();

  Future<int> insert(ConsumersCompanion c) => db.into(db.consumers).insert(c);

  Future<void> updateFields(int id, ConsumersCompanion c) =>
      (db.update(db.consumers)..where((t) => t.id.equals(id)))
          .write(c.copyWith(updatedAt: Value(DateTime.now())));

  Future<void> delete(int id) =>
      (db.delete(db.consumers)..where((c) => c.id.equals(id))).go();
}

// ===================================================================== meters

class MetersDao {
  MetersDao(this.db);
  final AppDatabase db;

  Stream<List<Meter>> watchForConsumer(int consumerId) =>
      (db.select(db.meters)
            ..where((m) => m.consumerId.equals(consumerId))
            ..orderBy([
              (m) => OrderingTerm.asc(m.status),
              (m) => OrderingTerm.desc(m.id),
            ]))
          .watch();

  Future<List<Meter>> forConsumer(int consumerId) =>
      (db.select(db.meters)
            ..where((m) => m.consumerId.equals(consumerId))
            ..orderBy([(m) => OrderingTerm.asc(m.status)]))
          .get();

  Future<Meter?> getById(int id) =>
      (db.select(db.meters)..where((m) => m.id.equals(id))).getSingleOrNull();

  Future<int> insert(MetersCompanion m) => db.into(db.meters).insert(m);

  Future<void> updateFields(int id, MetersCompanion m) =>
      (db.update(db.meters)..where((t) => t.id.equals(id))).write(m);

  Future<void> delete(int id) =>
      (db.delete(db.meters)..where((m) => m.id.equals(id))).go();
}

// ===================================================================== settings

class SettingsDao {
  SettingsDao(this.db);
  final AppDatabase db;

  Future<Map<String, String>> getAll() async {
    final rows = await db.select(db.settings).get();
    return {
      ...SettingKeys.defaults,
      for (final r in rows) r.key: r.value,
    };
  }

  Stream<Map<String, String>> watchAll() =>
      db.select(db.settings).watch().map((rows) => {
            ...SettingKeys.defaults,
            for (final r in rows) r.key: r.value,
          });

  Future<String> get(String key) async {
    final r = await (db.select(db.settings)..where((s) => s.key.equals(key)))
        .getSingleOrNull();
    return r?.value ?? SettingKeys.defaults[key] ?? '';
  }

  Future<void> set(String key, String value) => db
      .into(db.settings)
      .insertOnConflictUpdate(SettingsCompanion.insert(key: key, value: Value(value)));
}

// ===================================================================== reports

/// A report row with its consumer, for lists.
class ReportListItem {
  ReportListItem(this.report, this.consumer);
  final Report report;
  final ConsumerRow consumer;
}

/// Readings of one meter in an earlier report.
class PreviousReadings {
  PreviousReadings(this.report, this.values);
  final Report report;
  final Map<String, String> values;
}

/// One visit in a meter's history.
class MeterVisit {
  MeterVisit(this.report, this.values);
  final Report report;
  final Map<String, String> values;
}

class ReportsDao {
  ReportsDao(this.db);
  final AppDatabase db;

  // ---------------------------------------------------------------- lists

  Stream<List<ReportListItem>> _watchJoined(
      Expression<bool>? Function() where,
      {int? limit}) {
    final q = db.select(db.reports).join([
      innerJoin(db.consumers, db.consumers.id.equalsExp(db.reports.consumerId)),
    ]);
    final w = where();
    if (w != null) q.where(w);
    q.orderBy([
      OrderingTerm.desc(db.reports.visitDate),
      OrderingTerm.desc(db.reports.id),
    ]);
    if (limit != null) q.limit(limit);
    return q.watch().map((rows) => rows
        .map((r) =>
            ReportListItem(r.readTable(db.reports), r.readTable(db.consumers)))
        .toList());
  }

  Stream<List<ReportListItem>> watchDrafts() =>
      _watchJoined(() => db.reports.status.equals('draft'));

  Stream<List<ReportListItem>> watchForConsumer(int consumerId) =>
      _watchJoined(() => db.reports.consumerId.equals(consumerId));

  /// Memo register: filter by visit date range, sub division and type.
  Stream<List<ReportListItem>> watchFiltered({
    DateTime? from,
    DateTime? to,
    String subDivision = '',
    String? type,
    String query = '',
  }) {
    return _watchJoined(() {
      Expression<bool> w = const Constant(true);
      if (from != null) {
        w = w & db.reports.visitDate.isBiggerOrEqualValue(from);
      }
      if (to != null) {
        w = w &
            db.reports.visitDate
                .isSmallerThanValue(DateTime(to.year, to.month, to.day + 1));
      }
      if (subDivision.trim().isNotEmpty) {
        w = w &
            (db.reports.toSubDivision.like(_like(subDivision)) |
                db.consumers.subDivision.like(_like(subDivision)));
      }
      if (type != null) w = w & db.reports.reportType.equals(type);
      if (query.trim().isNotEmpty) {
        w = w &
            (db.reports.memoNo.like(_like(query)) |
                db.consumers.name.like(_like(query)) |
                db.consumers.accountNo.like(_like(query)));
      }
      return w;
    });
  }

  // ---------------------------------------------------------------- create

  /// Creates an empty draft for a consumer and returns its id.
  Future<int> createDraft({
    required int consumerId,
    required String type,
    String teamText = '',
  }) async {
    final consumer = await ConsumersDao(db).getById(consumerId);
    if (consumer == null) throw StateError('ConsumerRow $consumerId not found');
    return db.transaction(() async {
      final id = await db.into(db.reports).insert(ReportsCompanion.insert(
            consumerId: consumerId,
            reportType: type,
            toSubDivision: Value(consumer.subDivision),
            teamText: Value(teamText),
            visitDate: Value(_today()),
            memoDate: Value(_today()),
            sectionAJson: Value(jsonEncode(sectionAFromConsumer(consumer))),
          ));
      final active = await (db.select(db.meters)
            ..where((m) =>
                m.consumerId.equals(consumerId) & m.status.equals('active')))
          .get();
      final cols = ReportBundle.emptyColumns(type);
      // Put the consumer's active meters into the first free columns.
      var i = 0;
      for (final c in cols) {
        if (c.notApplicable || c.role == ColumnRole.removed) continue;
        if (c.role == ColumnRole.backupRemoved) continue;
        if (i < active.length) c.meter = active[i++];
      }
      for (final c in cols) {
        await db.into(db.reportMeters).insert(ReportMetersCompanion.insert(
              reportId: id,
              columnRole: c.role,
              meterId: Value(c.meter?.id),
              notApplicable: Value(c.notApplicable),
            ));
      }
      return id;
    });
  }

  static DateTime _today() {
    final n = DateTime.now();
    return DateTime(n.year, n.month, n.day);
  }

  // ---------------------------------------------------------------- load/save

  Future<ReportBundle?> loadBundle(int reportId) async {
    final report = await (db.select(db.reports)
          ..where((r) => r.id.equals(reportId)))
        .getSingleOrNull();
    if (report == null) return null;
    final consumer = (await ConsumersDao(db).getById(report.consumerId))!;

    Map<String, String> sectionA;
    try {
      sectionA = (jsonDecode(report.sectionAJson) as Map)
          .map((k, v) => MapEntry(k.toString(), v?.toString() ?? ''));
    } catch (_) {
      sectionA = {};
    }
    if (sectionA.isEmpty) sectionA = sectionAFromConsumer(consumer);

    final rms = await (db.select(db.reportMeters)
          ..where((r) => r.reportId.equals(reportId)))
        .get();
    final readings = await (db.select(db.readings)
          ..where((r) => r.reportId.equals(reportId)))
        .get();

    final columns = <ColumnSlot>[];
    for (final def in templateFor(report.reportType).columns) {
      final rm = rms.where((r) => r.columnRole == def.role).firstOrNull;
      Meter? meter;
      if (rm?.meterId != null) meter = await MetersDao(db).getById(rm!.meterId!);
      columns.add(ColumnSlot(
        role: def.role,
        meter: meter,
        notApplicable: rm?.notApplicable ?? def.defaultNotApplicable,
        readings: {
          for (final r in readings.where((r) => r.reportMeterId == rm?.id))
            r.paramCode: r.valueText,
        },
      ));
    }

    final loads = await (db.select(db.phaseLoads)
          ..where((r) => r.reportId.equals(reportId)))
        .get();
    final seals = await (db.select(db.seals)
          ..where((r) => r.reportId.equals(reportId)))
        .get();

    return ReportBundle(
      report: report,
      consumer: consumer,
      sectionA: sectionA,
      columns: columns,
      phaseLoads: {
        for (final l in loads)
          phaseKey(l.side, l.phase): PhaseLoadValues(
              volts: l.volts, amps: l.amps, pf: l.pf, kwOverride: l.kwOverride),
      },
      seals: {
        for (final s in seals)
          sealKey(s.spot, s.columnRole):
              SealValues(mtSeal: s.mtSeal, postalOrder: s.postalOrder),
      },
    );
  }

  /// Saves the whole bundle (report row and all child rows) in one transaction.
  Future<void> saveBundle(ReportBundle b) async {
    final id = b.report.id;
    await db.transaction(() async {
      final updated = b.report.copyWith(
        sectionAJson: jsonEncode(b.sectionA),
        updatedAt: DateTime.now(),
      );
      await db.update(db.reports).replace(updated);
      b.report = updated;

      await (db.delete(db.readings)..where((r) => r.reportId.equals(id))).go();
      await (db.delete(db.reportMeters)..where((r) => r.reportId.equals(id)))
          .go();
      await (db.delete(db.phaseLoads)..where((r) => r.reportId.equals(id))).go();
      await (db.delete(db.seals)..where((r) => r.reportId.equals(id))).go();

      for (final c in b.columns) {
        final rmId = await db.into(db.reportMeters).insert(
              ReportMetersCompanion.insert(
                reportId: id,
                columnRole: c.role,
                meterId: Value(c.meter?.id),
                notApplicable: Value(c.notApplicable),
              ),
            );
        for (final e in c.readings.entries) {
          if (e.value.trim().isEmpty) continue;
          await db.into(db.readings).insert(ReadingsCompanion.insert(
                reportId: id,
                reportMeterId: rmId,
                paramCode: e.key,
                valueText: Value(e.value.trim()),
              ));
        }
      }
      for (final e in b.phaseLoads.entries) {
        if (e.value.isEmpty) continue;
        final parts = e.key.split('_');
        await db.into(db.phaseLoads).insert(PhaseLoadsCompanion.insert(
              reportId: id,
              side: parts[0],
              phase: parts[1],
              volts: Value(e.value.volts.trim()),
              amps: Value(e.value.amps.trim()),
              pf: Value(e.value.pf.trim()),
              kwOverride: Value(e.value.kwOverride.trim()),
            ));
      }
      for (final e in b.seals.entries) {
        if (e.value.isEmpty) continue;
        final parts = e.key.split('|');
        await db.into(db.seals).insert(SealsCompanion.insert(
              reportId: id,
              spot: parts[0],
              columnRole: parts[1],
              mtSeal: Value(e.value.mtSeal.trim()),
              postalOrder: Value(e.value.postalOrder.trim()),
            ));
      }
    });
  }

  Future<void> setStatus(int reportId, String status) =>
      (db.update(db.reports)..where((r) => r.id.equals(reportId))).write(
          ReportsCompanion(
              status: Value(status), updatedAt: Value(DateTime.now())));

  Future<void> delete(int reportId) =>
      (db.delete(db.reports)..where((r) => r.id.equals(reportId))).go();

  /// Copies a report (header, section A, meters, seals; no readings) as a new draft.
  Future<int> duplicateAsDraft(int reportId) async {
    final b = await loadBundle(reportId);
    if (b == null) throw StateError('Report $reportId not found');
    final newId = await db.into(db.reports).insert(ReportsCompanion.insert(
          consumerId: b.report.consumerId,
          reportType: b.report.reportType,
        ));
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final r = b.report.copyWith(
      id: newId,
      status: 'draft',
      memoNo: '',
      memoDate: Value(today),
      visitDate: Value(today),
      createdAt: now,
      updatedAt: now,
    );
    final copy = ReportBundle(
      report: r,
      consumer: b.consumer,
      sectionA: Map.of(b.sectionA),
      columns: [
        for (final c in b.columns)
          ColumnSlot(role: c.role, meter: c.meter, notApplicable: c.notApplicable),
      ],
      phaseLoads: {},
      seals: {},
    );
    await saveBundle(copy);
    return newId;
  }

  // ---------------------------------------------------------------- history

  /// Readings of [meterId] in the latest other report visited before [before].
  Future<PreviousReadings?> previousReadings(int meterId,
      {required int excludeReportId, DateTime? before}) async {
    final q = db.select(db.reportMeters).join([
      innerJoin(db.reports, db.reports.id.equalsExp(db.reportMeters.reportId)),
    ])
      ..where(db.reportMeters.meterId.equals(meterId) &
          db.reports.id.equals(excludeReportId).not() &
          db.reportMeters.notApplicable.equals(false));
    if (before != null) {
      q.where(db.reports.visitDate.isSmallerOrEqualValue(before));
    }
    q.orderBy([
      OrderingTerm.desc(db.reports.visitDate),
      OrderingTerm.desc(db.reports.id),
    ]);
    final rows = await q.get();
    for (final row in rows) {
      final rm = row.readTable(db.reportMeters);
      final rep = row.readTable(db.reports);
      // Same date: only count reports created earlier than the current one.
      if (before != null &&
          rep.visitDate != null &&
          rep.visitDate!.isAtSameMomentAs(before) &&
          rep.id > excludeReportId) {
        continue;
      }
      final values = await (db.select(db.readings)
            ..where((r) => r.reportMeterId.equals(rm.id)))
          .get();
      if (values.isEmpty) continue;
      return PreviousReadings(
          rep, {for (final v in values) v.paramCode: v.valueText});
    }
    return null;
  }

  /// All visits of a meter, oldest first.
  Future<List<MeterVisit>> meterHistory(int meterId) async {
    final q = db.select(db.reportMeters).join([
      innerJoin(db.reports, db.reports.id.equalsExp(db.reportMeters.reportId)),
    ])
      ..where(db.reportMeters.meterId.equals(meterId) &
          db.reportMeters.notApplicable.equals(false))
      ..orderBy([
        OrderingTerm.asc(db.reports.visitDate),
        OrderingTerm.asc(db.reports.id),
      ]);
    final out = <MeterVisit>[];
    for (final row in await q.get()) {
      final rm = row.readTable(db.reportMeters);
      final values = await (db.select(db.readings)
            ..where((r) => r.reportMeterId.equals(rm.id)))
          .get();
      if (values.isEmpty) continue;
      out.add(MeterVisit(row.readTable(db.reports),
          {for (final v in values) v.paramCode: v.valueText}));
    }
    return out;
  }

  // ---------------------------------------------------------------- search

  Future<SearchResults> search(String query) async {
    final q = query.trim();
    if (q.isEmpty) return SearchResults([], [], []);
    final consumers = await (db.select(db.consumers)
          ..where((c) => c.accountNo.like(_like(q)) | c.name.like(_like(q)))
          ..limit(50))
        .get();
    final meterRows = await (db.select(db.meters).join([
      innerJoin(db.consumers, db.consumers.id.equalsExp(db.meters.consumerId)),
    ])
          ..where(db.meters.mfgNo.like(_like(q)))
          ..limit(50))
        .get();
    final reportRows = await (db.select(db.reports).join([
      innerJoin(db.consumers, db.consumers.id.equalsExp(db.reports.consumerId)),
    ])
          ..where(db.reports.memoNo.like(_like(q)))
          ..orderBy([OrderingTerm.desc(db.reports.visitDate)])
          ..limit(50))
        .get();
    return SearchResults(
      consumers,
      meterRows
          .map((r) => (r.readTable(db.meters), r.readTable(db.consumers)))
          .toList(),
      reportRows
          .map((r) =>
              ReportListItem(r.readTable(db.reports), r.readTable(db.consumers)))
          .toList(),
    );
  }
}

class SearchResults {
  SearchResults(this.consumers, this.meters, this.reports);
  final List<ConsumerRow> consumers;
  final List<(Meter, ConsumerRow)> meters;
  final List<ReportListItem> reports;
  bool get isEmpty => consumers.isEmpty && meters.isEmpty && reports.isEmpty;
}
