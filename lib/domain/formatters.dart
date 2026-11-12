import 'package:intl/intl.dart';

final _dmy = DateFormat('dd-MM-yy');

/// Formats a date as on the forms: dd-MM-yy. Null gives ''.
String fmtDate(DateTime? d) => d == null ? '' : _dmy.format(d);

/// Parses dd-MM-yy (also accepts dd-MM-yyyy and dd/MM/yy). Returns null if invalid.
DateTime? parseDate(String? s) {
  if (s == null) return null;
  final t = s.trim().replaceAll('/', '-').replaceAll('.', '-');
  final m = RegExp(r'^(\d{1,2})-(\d{1,2})-(\d{2}|\d{4})$').firstMatch(t);
  if (m == null) return null;
  final d = int.parse(m[1]!);
  final mo = int.parse(m[2]!);
  var y = int.parse(m[3]!);
  if (y < 100) y += 2000;
  if (mo < 1 || mo > 12 || d < 1 || d > 31) return null;
  final dt = DateTime(y, mo, d);
  if (dt.month != mo) return null;
  return dt;
}

/// Parses a typed number ("0.8100", "035165", "2,556.74"). Returns null if empty/invalid.
double? parseNum(String? s) {
  if (s == null) return null;
  final t = s.trim().replaceAll(',', '');
  if (t.isEmpty) return null;
  return double.tryParse(t);
}

/// Formats a number with fixed decimals.
String fmtNum(double? v, [int decimals = 2]) =>
    v == null ? '' : v.toStringAsFixed(decimals);

/// Formats a number without useless trailing zeros (80.0 -> "80", 0.5 -> "0.5").
String fmtCompact(double? v) {
  if (v == null) return '';
  if (v == v.roundToDouble()) return v.toStringAsFixed(0);
  var s = v.toStringAsFixed(4);
  s = s.replaceAll(RegExp(r'0+$'), '');
  return s.endsWith('.') ? s.substring(0, s.length - 1) : s;
}

/// Replaces {placeholders} in a template.
String fillTemplate(String template, Map<String, String> values) => template
    .replaceAllMapped(RegExp(r'\{(\w+)\}'), (m) => values[m[1]!] ?? m[0]!);
