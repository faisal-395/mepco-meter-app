import 'calculations.dart';
import 'formatters.dart';
import 'models.dart';
import 'report_templates.dart';
import 'settings_keys.dart';

/// MF used for a column: the meter's own MF, else section A's MF.
double? columnMf(ReportBundle b, ColumnSlot slot) =>
    parseMf(slot.meter?.mf) ?? parseMf(b.mfText);

/// Computed values of section C for one report.
class SectionC {
  SectionC({
    required this.phaseKw,
    required this.importCheckLoad,
    required this.exportCheckLoad,
    required this.instantImport,
    required this.instantExport,
    required this.errorImport,
    required this.errorExport,
    required this.within,
    required this.limitText,
  });

  /// phaseKey(side, phase) -> kW (override or computed).
  final Map<String, double?> phaseKw;
  final double? importCheckLoad;
  final double? exportCheckLoad;

  /// role -> instant kW (raw x MF) of used columns.
  final Map<String, double?> instantImport;
  final Map<String, double?> instantExport;

  /// role -> % error.
  final Map<String, double?> errorImport;
  final Map<String, double?> errorExport;

  /// Within permissible limits: true / false / null (unknown).
  final bool? within;
  final String limitText;

  double? sideTotal(String side) {
    final v = [for (final p in phases) phaseKw[phaseKey(side, p)]]
        .whereType<double>()
        .toList();
    if (v.isEmpty) return null;
    return v.fold<double>(0, (a, b) => a + b);
  }

  bool hasSide(String side) =>
      phases.any((p) => phaseKw[phaseKey(side, p)] != null);
}

SectionC computeSectionC(ReportBundle b, Map<String, String> settings) {
  final method =
      settings[SettingKeys.checkLoadMethod] ?? SettingKeys.methodAverage;
  final limit = settings[SettingKeys.permissibleErrorLimit] ?? '';
  final t = b.template;
  final r = b.report;

  final kw = <String, double?>{};
  for (final side in loadSides) {
    for (final p in phases) {
      final l = b.phaseLoads[phaseKey(side, p)];
      if (l == null) {
        kw[phaseKey(side, p)] = null;
        continue;
      }
      kw[phaseKey(side, p)] =
          parseNum(l.kwOverride) ?? phaseKw(l.volts, l.amps, l.pf);
    }
  }
  double? sideLoad(String side) => checkLoad([
    for (final p in phases) kw[phaseKey(side, p)],
  ], method: method);

  final importLoad = parseNum(r.checkLoadOverride) ?? sideLoad('import');
  final exportLoad = sideLoad('export');

  final instImp = <String, double?>{};
  final instExp = <String, double?>{};
  final errImp = <String, double?>{};
  final errExp = <String, double?>{};
  for (final c in b.columns.where((c) => c.isUsed)) {
    final mf = columnMf(b, c);
    instImp[c.role] = instantKw(c.readings[t.importInstantCode], mf);
    errImp[c.role] = percentError(instImp[c.role], importLoad);
    if (t.exportInstantCode != null) {
      instExp[c.role] = instantKw(c.readings[t.exportInstantCode], mf);
      errExp[c.role] = percentError(instExp[c.role], exportLoad);
    }
  }

  // Within limit: every computed error must be inside the limit.
  bool? within;
  final overrideErr = parseNum(r.percentErrorOverride);
  final errs = overrideErr != null
      ? [overrideErr]
      : [...errImp.values, ...errExp.values].whereType<double>().toList();
  for (final e in errs) {
    final w = withinLimit(e, limit);
    if (w == null) continue;
    within = (within ?? true) && w;
  }
  final wo = r.withinLimitOverride.trim().toLowerCase();
  if (wo == 'yes') within = true;
  if (wo == 'no') within = false;

  return SectionC(
    phaseKw: kw,
    importCheckLoad: importLoad,
    exportCheckLoad: exportLoad,
    instantImport: instImp,
    instantExport: instExp,
    errorImport: errImp,
    errorExport: errExp,
    within: within,
    limitText: limit,
  );
}

/// The main % error to show for a report (first used column), or the override.
String percentErrorText(ReportBundle b, SectionC c) {
  final o = b.report.percentErrorOverride.trim();
  if (o.isNotEmpty) return o;
  final parts = <String>[];
  for (final col in b.columns.where((x) => x.isUsed)) {
    final e = c.errorImport[col.role];
    if (e == null) continue;
    final label = b.template.isNet
        ? (col.role == ColumnRole.billing ? 'Billing' : 'B/UP')
        : b.template.column(col.role).label;
    parts.add('$label ${e.toStringAsFixed(2)} %');
  }
  return parts.join(', ');
}

/// Values for the blanks of the NEW_CONNECTION paragraph.
Map<String, String> newConnectionValues(ReportBundle b) {
  final a = b.sectionA;
  final r = b.report;
  String g(String k) => (a[k] ?? '').trim();
  return {
    'consumer_name': g('name'),
    'visit_date': fmtDate(r.visitDate),
    'op_division': g('op_division'),
    'ref_no': r.refNo,
    'ref_date': fmtDate(r.refDate),
    'application_no': g('application_no'),
    'application_date': g('application_date'),
    'store_challan_no': r.storeChallanNo,
    'store_challan_date': fmtDate(r.storeChallanDate),
    'sco_no': g('sco_mco_rco_no'),
    'sco_date': g('sco_date'),
    'new_meter_count': r.newMeterCount,
    'ct_count': r.ctCount,
    'ct_ratio': g('ct_primary').isEmpty
        ? ''
        : '${g('ct_primary')}/${g('ct_secondary')}',
    'checked_load_kw': r.checkedLoadKw,
  };
}

/// Section E paragraph of a NEW_CONNECTION report, filled from the template.
String newConnectionRemarks(ReportBundle b) =>
    fillTemplate(newConnectionRemarksTemplate, newConnectionValues(b));
