import 'package:drift/drift.dart' hide isNull, isNotNull;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mepco_meter_app/data/daos.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/domain/report_templates.dart';
import 'package:mepco_meter_app/domain/settings_keys.dart';

void main() {
  late AppDatabase db;
  late ConsumersDao consumers;
  late MetersDao meters;
  late ReportsDao reports;
  late SettingsDao settings;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
    consumers = ConsumersDao(db);
    meters = MetersDao(db);
    reports = ReportsDao(db);
    settings = SettingsDao(db);
  });
  tearDown(() => db.close());

  Future<int> addConsumer([String acc = '99-00001-0000001']) =>
      consumers.insert(ConsumersCompanion.insert(
        accountNo: acc,
        name: const Value('Test Cotton Factory'),
        subDivision: const Value('F/Abbas'),
        ctPrimary: const Value('400'),
        ctSecondary: const Value('5'),
        mf: const Value('80'),
      ));

  test('settings are seeded and editable', () async {
    final all = await settings.getAll();
    expect(all[SettingKeys.officePhone], '063-9240037');
    expect(all[SettingKeys.circle], 'Bahawalnagar');
    expect(all[SettingKeys.checkLoadMethod], 'average_of_phases');
    expect(all[SettingKeys.permissibleErrorLimit], '');
    expect(all[SettingKeys.ccList]!.split('\n'), hasLength(6));
    await settings.set(SettingKeys.circle, 'X');
    expect(await settings.get(SettingKeys.circle), 'X');
  });

  test('consumer insert, search, unique account no', () async {
    final id = await addConsumer();
    expect((await consumers.getById(id))!.name, 'Test Cotton Factory');
    expect(await consumers.watchAll(query: 'cotton').first, hasLength(1));
    expect(await consumers.watchAll(query: '00001').first, hasLength(1));
    expect(await consumers.watchAll(query: 'zzz').first, isEmpty);
    expect(() => addConsumer(), throwsA(anything));
    await consumers.updateFields(
        id, const ConsumersCompanion(tariff: Value('B2')));
    expect((await consumers.findByAccount('99-00001-0000001'))!.tariff, 'B2');
  });

  test('meters per consumer', () async {
    final cid = await addConsumer();
    await meters.insert(MetersCompanion.insert(consumerId: cid, mfgNo: '000001'));
    await meters.insert(MetersCompanion.insert(
        consumerId: cid, mfgNo: '000002', status: const Value('removed')));
    final list = await meters.forConsumer(cid);
    expect(list.map((m) => m.mfgNo), ['000001', '000002']);
  });

  test('draft create, save and load bundle', () async {
    final cid = await addConsumer();
    final mid = await meters
        .insert(MetersCompanion.insert(consumerId: cid, mfgNo: '000001'));
    final rid = await reports.createDraft(
        consumerId: cid, type: ReportType.amrTestCheck);
    var b = (await reports.loadBundle(rid))!;
    expect(b.columns.map((c) => c.role), ['removed', 'amr', 'existing']);
    expect(b.column('amr').meter!.id, mid);
    expect(b.sectionA['account_no'], '99-00001-0000001');

    b.column('amr').readings['kwh_total'] = '035165';
    b.load('import', 'R').volts = '425';
    b.seal('MSB', 'amr').mtSeal = 'TA-1';
    b.sectionA['tariff'] = 'B2';
    b.report = b.report.copyWith(memoNo: '101-11');
    await reports.saveBundle(b);

    b = (await reports.loadBundle(rid))!;
    expect(b.column('amr').readings['kwh_total'], '035165');
    expect(b.load('import', 'R').volts, '425');
    expect(b.seal('MSB', 'amr').mtSeal, 'TA-1');
    expect(b.sectionA['tariff'], 'B2');
    expect(b.report.memoNo, '101-11');
    expect(await reports.watchDrafts().first, hasLength(1));
  });

  test('previous readings and history of a meter', () async {
    final cid = await addConsumer();
    final mid = await meters
        .insert(MetersCompanion.insert(consumerId: cid, mfgNo: '000001'));
    final r1 = await reports.createDraft(
        consumerId: cid, type: ReportType.amrTestCheck);
    var b1 = (await reports.loadBundle(r1))!;
    b1.report = b1.report.copyWith(visitDate: Value(DateTime(2026, 9, 1)));
    b1.column('amr').readings['kwh_total'] = '100';
    await reports.saveBundle(b1);

    final r2 = await reports.createDraft(
        consumerId: cid, type: ReportType.amrTestCheck);
    var b2 = (await reports.loadBundle(r2))!;
    b2.report = b2.report.copyWith(visitDate: Value(DateTime(2026, 10, 6)));
    b2.column('amr').readings['kwh_total'] = '150';
    await reports.saveBundle(b2);

    final prev = await reports.previousReadings(mid,
        excludeReportId: r2, before: DateTime(2026, 10, 6));
    expect(prev!.values['kwh_total'], '100');
    expect(prev.report.id, r1);
    expect(
        await reports.previousReadings(mid,
            excludeReportId: r1, before: DateTime(2026, 9, 1)),
        isNull);

    final hist = await reports.meterHistory(mid);
    expect(hist.map((v) => v.values['kwh_total']), ['100', '150']);
  });

  test('duplicate, final, filters, search, delete', () async {
    final cid = await addConsumer();
    await meters.insert(MetersCompanion.insert(consumerId: cid, mfgNo: '777123'));
    final rid = await reports.createDraft(
        consumerId: cid, type: ReportType.netMeter);
    var b = (await reports.loadBundle(rid))!;
    b.report = b.report.copyWith(memoNo: 'M-55');
    await reports.saveBundle(b);
    await reports.setStatus(rid, 'final');
    expect(await reports.watchDrafts().first, isEmpty);

    final copy = await reports.duplicateAsDraft(rid);
    final cb = (await reports.loadBundle(copy))!;
    expect(cb.report.status, 'draft');
    expect(cb.report.memoNo, '');
    expect(cb.columns, hasLength(4));

    expect(
        await reports.watchFiltered(type: ReportType.netMeter).first, hasLength(2));
    expect(await reports.watchFiltered(type: ReportType.amrTestCheck).first,
        isEmpty);
    expect(await reports.watchFiltered(subDivision: 'abbas').first, hasLength(2));

    final s = await reports.search('777');
    expect(s.meters, hasLength(1));
    expect((await reports.search('M-55')).reports, hasLength(1));
    expect((await reports.search('cotton')).consumers, hasLength(1));

    await reports.delete(copy);
    expect(await reports.loadBundle(copy), isNull);
  });
}
