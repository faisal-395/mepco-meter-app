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
String formatSerialRange(Serial start, int count, {bool firstLast = false}) {
  if (count <= 0) return '';
  String tail(int n) {
    final s = n.toString();
    return s.length >= 2 ? s.substring(s.length - 2) : s;
  }

  final first = start.format(start.number);
  if (count == 1) return first;
  // "TA-823625-27": only the first and the last number.
  if (firstLast) return '$first-${tail(start.number + count - 1)}';
  return [
    first,
    for (var i = 1; i < count; i++) tail(start.number + i),
  ].join('-');
}

/// How many serials a range like "TA-823625-27" or "TA-823625-26-27" covers.
int serialCount(String text) {
  final t = text.trim();
  if (t.isEmpty) return 0;
  final m = RegExp(r'^(.*?)(\d+)((?:-\d{1,2})*)$').firstMatch(t);
  if (m == null) return 1;
  final tails = m[3]!.split('-').where((x) => x.isNotEmpty).toList();
  if (tails.isEmpty) return 1;
  if (tails.length == 1) {
    // first-last form
    final firstNum = int.parse(m[2]!);
    final firstTail = firstNum % 100;
    var last = int.parse(tails.first);
    if (last < firstTail) last += 100;
    return last - firstTail + 1;
  }
  return tails.length + 1;
}

/// Splits a run of serials over spots: returns spot -> text, using [counts] per spot.
/// The next spot continues from where the previous one stopped.
Map<String, String> fillSerials(
  String firstSerial,
  Map<String, int> counts, {
  bool firstLast = false,
}) {
  final start = Serial.parse(firstSerial);
  if (start == null) return {};
  final out = <String, String>{};
  var n = start.number;
  counts.forEach((spot, count) {
    if (count <= 0) return;
    out[spot] = formatSerialRange(
      Serial(start.prefix, n, start.width),
      count,
      firstLast: firstLast,
    );
    n += count;
  });
  return out;
}
