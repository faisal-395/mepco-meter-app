import 'calculations.dart';
import 'formatters.dart';
import 'models.dart';
import 'report_calc.dart';
import 'report_templates.dart';

/// A warning shown in the yellow banner. Warnings never block saving.
class ReportWarning {
  const ReportWarning(this.section, this.message);
  final String section;
  final String message;
  @override
  String toString() => '$section: $message';
}

/// Total check of one rule in one column (null if values are missing).
TotalCheck? totalCheckFor(ColumnSlot c, TotalRule rule) => checkTotal(
    c.readings[rule.total], c.readings[rule.partA], c.readings[rule.partB]);

/// Warnings for the totals of one column.
List<ReportWarning> totalWarnings(ReportTemplate t, ColumnSlot c) {
  final out = <ReportWarning>[];
  final colLabel = t.column(c.role).label;
  for (final rule in t.totals) {
    final chk = totalCheckFor(c, rule);
    if (chk == null || chk.ok) continue;
    final a = t.param(rule.partA).label, b = t.param(rule.partB).label;
    out.add(ReportWarning(
      'Readings',
      '$colLabel: ${t.param(rule.total).label} ${c.readings[rule.total]} '
          'is not $a + $b (${fmtNum(chk.sum)}), difference ${fmtNum(chk.difference)}',
    ));
  }
  return out;
}

/// Warnings when a register is lower than in the previous report of the same meter.
List<ReportWarning> regressionWarnings(
    ReportTemplate t, ColumnSlot c, Map<String, String>? previous) {
  if (previous == null) return [];
  final out = <ReportWarning>[];
  final colLabel = t.column(c.role).label;
  for (final code in t.registerCodes) {
    if (registerWentDown(c.readings[code], previous[code])) {
      out.add(ReportWarning(
        'Readings',
        '$colLabel: ${_rowLabel(t, code)} ${c.readings[code]} is lower than last visit (${previous[code]})',
      ));
    }
  }
  return out;
}

String _rowLabel(ReportTemplate t, String code) {
  final p = t.param(code);
  // "Peak"/"Off Peak" alone are ambiguous; add the group name.
  if (!t.isNet && (p.label == 'Peak' || p.label == 'Off Peak')) {
    final group = code.split('_').take(code.startsWith('cum') ? 2 : 1).join(' ');
    return '${group.toUpperCase()} ${p.label}';
  }
  return p.label;
}

/// Values typed in numeric rows that are not numbers.
List<ReportWarning> formatWarnings(ReportTemplate t, ColumnSlot c) {
  final out = <ReportWarning>[];
  for (final p in t.params.where((p) => p.isNumeric)) {
    final v = c.readings[p.code]?.trim() ?? '';
    if (v.isNotEmpty && parseNum(v) == null) {
      out.add(ReportWarning('Readings',
          '${t.column(c.role).label}: ${_rowLabel(t, p.code)} "$v" is not a number'));
    }
  }
  final d = c.readings['date']?.trim() ?? '';
  if (d.isNotEmpty && parseDate(d) == null) {
    out.add(ReportWarning('Readings',
        '${t.column(c.role).label}: date "$d" is not dd-mm-yy'));
  }
  return out;
}

/// All warnings of a report, for the review step.
/// [previous] maps column role -> readings of the same meter at the last visit.
List<ReportWarning> validateReport(
  ReportBundle b,
  Map<String, String> settings, {
  Map<String, Map<String, String>?> previous = const {},
}) {
  final t = b.template;
  final r = b.report;
  final out = <ReportWarning>[];

  if (r.memoNo.trim().isEmpty) out.add(const ReportWarning('Header', 'Memo No is empty'));
  if (r.visitDate == null) out.add(const ReportWarning('Header', 'Visit date is empty'));
  if ((b.sectionA['account_no'] ?? '').trim().isEmpty) {
    out.add(const ReportWarning('Section A', 'A/C No is empty'));
  }
  if (parseMf(b.mfText) == null) {
    out.add(const ReportWarning('Section A', 'M.F is empty'));
  }

  final used = b.columns.where((c) => c.isUsed).toList();
  if (used.isEmpty) {
    out.add(const ReportWarning('Section B', 'No meter column is filled'));
  }
  for (final c in used) {
    if (c.meter == null) {
      out.add(ReportWarning('Section B', '${t.column(c.role).label}: no meter selected'));
    }
    out.addAll(formatWarnings(t, c));
    out.addAll(totalWarnings(t, c));
    out.addAll(regressionWarnings(t, c, previous[c.role]));
  }

  final sc = computeSectionC(b, settings);
  if (sc.within == false) {
    out.add(ReportWarning('Section C',
        '% error is outside the permissible limit (${sc.limitText} %)'));
  }
  if (t.isNet) {
    final bill = sc.instantImport[ColumnRole.billing];
    final bup = sc.instantImport[ColumnRole.backup];
    if (bill != null && bup != null && (bill - bup).abs() > totalTolerance) {
      out.add(ReportWarning('Readings',
          'Billing and backup instant KW differ (${fmtNum(bill)} vs ${fmtNum(bup)})'));
    }
  }
  return out;
}
