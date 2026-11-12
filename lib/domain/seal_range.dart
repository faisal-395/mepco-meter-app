/// Helpers for seal / postal order serials written like "TA-823623-24".
library;

class Serial {
  Serial(this.prefix, this.number, this.width);
  final String prefix;
  final int number;
  final int width;

  /// Parses "TA-900003" -> prefix "TA-", number 900003. Null if no digits at the end.
  static Serial? parse(String s) {
    final m = RegExp(r'^(.*?)(\d+)$').firstMatch(s.trim());
    if (m == null) return null;
    return Serial(m[1]!, int.parse(m[2]!), m[2]!.length);
  }

  String format(int n) => '$prefix${n.toString().padLeft(width, '0')}';
}

/// Formats [count] consecutive serials from [start] the way they are written
/// on the forms: "TA-900009-10-11-12" (later ones as their last two digits).
String formatSerialRange(Serial start, int count) {
  if (count <= 0) return '';
  final parts = <String>[start.format(start.number)];
  for (var i = 1; i < count; i++) {
    final n = start.number + i;
    final s = n.toString();
    parts.add(s.length >= 2 ? s.substring(s.length - 2) : s);
  }
  return parts.join('-');
}

/// Splits a run of serials over spots: returns spot -> text, using [counts] per spot.
/// The next spot continues from where the previous one stopped.
Map<String, String> fillSerials(String firstSerial, Map<String, int> counts) {
  final start = Serial.parse(firstSerial);
  if (start == null) return {};
  final out = <String, String>{};
  var n = start.number;
  counts.forEach((spot, count) {
    if (count <= 0) return;
    out[spot] = formatSerialRange(Serial(start.prefix, n, start.width), count);
    n += count;
  });
  return out;
}
