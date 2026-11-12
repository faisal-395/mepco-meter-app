/// All calculation rules from CLAUDE.md. Pure functions, unit tested.
library;

import 'dart:math' as math;

import 'formatters.dart';
import 'settings_keys.dart';

/// Allowed difference between a total and the sum of its parts.
const totalTolerance = 0.02;

double round2(double v) => (v * 100).roundToDouble() / 100;

/// MF = CT primary / CT secondary (400/5 -> 80). Null if not computable.
double? mfFromCt(String primary, String secondary) {
  final p = parseNum(primary), s = parseNum(secondary);
  if (p == null || s == null || s == 0) return null;
  return p / s;
}

/// Reads an MF value from text like "80", "R x 80" or "80.0". Null if none.
double? parseMf(String? text) {
  if (text == null) return null;
  final ms = RegExp(r'\d+(\.\d+)?').allMatches(text.replaceAll(',', ''));
  if (ms.isEmpty) return null;
  return double.tryParse(ms.last.group(0)!);
}

class TotalCheck {
  const TotalCheck(this.total, this.sum);
  final double total;
  final double sum;
  double get difference => (total - sum).abs();

  /// A tiny epsilon avoids floating point noise (2556.74 vs 2556.73 = 0.01).
  bool get ok => difference <= totalTolerance + 1e-9;
}

/// Total = partA + partB. Null when any value is missing.
TotalCheck? checkTotal(String? total, String? partA, String? partB) {
  final t = parseNum(total), a = parseNum(partA), b = parseNum(partB);
  if (t == null || a == null || b == null) return null;
  return TotalCheck(t, a + b);
}

/// Instant kW = raw x MF, rounded to 2 decimals.
double? instantKw(String? raw, double? mf) {
  final r = parseNum(raw);
  if (r == null || mf == null) return null;
  return round2(r * mf);
}

/// "2.258 x 80 = 180.64 KW". Empty when raw is empty.
String instantKwText(String? raw, double? mf) {
  final r = raw?.trim() ?? '';
  if (r.isEmpty) return '';
  final kw = instantKw(r, mf);
  if (kw == null) return r;
  return '$r x ${fmtCompact(mf)} = ${kw.toStringAsFixed(2)} KW';
}

/// Phase kW = sqrt(3) x V x I x PF / 1000.
double? phaseKw(String? volts, String? amps, String? pf) {
  final v = parseNum(volts), a = parseNum(amps), p = parseNum(pf);
  if (v == null || a == null || p == null) return null;
  return math.sqrt(3) * v * a * p / 1000;
}

/// Check load from the per-phase kW values (nulls are ignored).
/// Method: average_of_phases (default) or sum_per_phase.
double? checkLoad(List<double?> phaseKws, {String method = SettingKeys.methodAverage}) {
  final vals = phaseKws.whereType<double>().toList();
  if (vals.isEmpty) return null;
  final sum = vals.fold<double>(0, (a, b) => a + b);
  return method == SettingKeys.methodSum ? sum : sum / vals.length;
}

/// % error = (meter instant kW - check load kW) / check load kW x 100.
double? percentError(double? meterKw, double? checkLoadKw) {
  if (meterKw == null || checkLoadKw == null || checkLoadKw == 0) return null;
  return (meterKw - checkLoadKw) / checkLoadKw * 100;
}

/// Whether |% error| is within the permissible limit. Null when the limit is not set.
bool? withinLimit(double? errorPercent, String limitSetting) {
  final limit = parseNum(limitSetting);
  if (limit == null || errorPercent == null) return null;
  return errorPercent.abs() <= limit + 1e-9;
}

/// Consumption since the last visit = (new - old) x MF.
double? consumption(String? newValue, String? oldValue, double? mf) {
  final n = parseNum(newValue), o = parseNum(oldValue);
  if (n == null || o == null || mf == null) return null;
  return (n - o) * mf;
}

/// True if a register went down since the last visit.
bool registerWentDown(String? newValue, String? oldValue) {
  final n = parseNum(newValue), o = parseNum(oldValue);
  if (n == null || o == null) return false;
  return n < o;
}
