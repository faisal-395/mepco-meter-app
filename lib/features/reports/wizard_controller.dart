import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../../app/field_focus.dart';

import '../../data/daos.dart';
import '../../data/database.dart';
import '../../domain/models.dart';
import '../../domain/report_calc.dart';
import '../../domain/validators.dart';

/// Holds the report being edited and saves it (autosave).
class WizardController extends ChangeNotifier {
  WizardController({
    required this.reportsDao,
    required this.metersDao,
    required this.consumersDao,
    required this.bundle,
    required this.settings,
  });

  final ReportsDao reportsDao;
  final MetersDao metersDao;
  final ConsumersDao consumersDao;
  ReportBundle bundle;
  Map<String, String> settings;

  /// The consumer's meters, for the column pickers.
  List<Meter> meters = [];

  /// Column role -> readings of the same meter at the previous visit.
  Map<String, PreviousReadings?> previous = {};

  /// The field to show next (a tapped warning).
  final focus = FieldFocus();

  bool _dirty = false;
  bool _deleted = false;
  bool saving = false;
  DateTime? lastSaved;
  Timer? _timer;

  static Future<WizardController?> load({
    required ReportsDao reportsDao,
    required MetersDao metersDao,
    required ConsumersDao consumersDao,
    required SettingsDao settingsDao,
    required int reportId,
  }) async {
    final b = await reportsDao.loadBundle(reportId);
    if (b == null) return null;
    final c = WizardController(
      reportsDao: reportsDao,
      metersDao: metersDao,
      consumersDao: consumersDao,
      bundle: b,
      settings: await settingsDao.getAll(),
    );
    await c.reloadMeters();
    await c.reloadPrevious();
    return c;
  }

  Future<void> reloadMeters() async {
    meters = await metersDao.forConsumer(bundle.report.consumerId);
    // Refresh meter rows held by the columns (e.g. after editing a meter).
    for (final col in bundle.columns) {
      if (col.meter == null) continue;
      col.meter = meters.where((m) => m.id == col.meter!.id).firstOrNull;
    }
    notifyListeners();
  }

  Future<void> reloadPrevious() async {
    final out = <String, PreviousReadings?>{};
    for (final col in bundle.columns) {
      if (col.meter == null) continue;
      out[col.role] = await reportsDao.previousReadings(
        col.meter!.id,
        excludeReportId: bundle.report.id,
        before: bundle.report.visitDate,
      );
    }
    previous = out;
    notifyListeners();
  }

  /// Call after every edit: rebuilds and schedules an autosave.
  void changed() {
    _dirty = true;
    notifyListeners();
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 3), save);
  }

  Future<void> save() async {
    _timer?.cancel();
    if (!_dirty || bundle.isFinal || _deleted) return;
    saving = true;
    notifyListeners();
    try {
      await reportsDao.saveBundle(bundle);
      _dirty = false;
      lastSaved = DateTime.now();
    } finally {
      saving = false;
      notifyListeners();
    }
  }

  bool get dirty => _dirty;

  /// Deletes the draft; nothing is saved afterwards.
  Future<void> deleteReport() async {
    _timer?.cancel();
    _deleted = true;
    await reportsDao.delete(bundle.report.id);
  }

  /// Saves and marks the report final.
  Future<void> markFinal() async {
    await save();
    await reportsDao.setStatus(bundle.report.id, 'final');
    bundle.report = bundle.report.copyWith(status: 'final');
  }

  SectionC get sectionC => computeSectionC(bundle, settings);

  List<ReportWarning> get warnings => validateReport(
    bundle,
    settings,
    previous: {for (final e in previous.entries) e.key: e.value?.values},
  );

  bool _disposed = false;

  @override
  void notifyListeners() {
    if (!_disposed) super.notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    focus.dispose();
    super.dispose();
  }
}
