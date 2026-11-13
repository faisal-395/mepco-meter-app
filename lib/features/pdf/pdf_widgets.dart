import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Building blocks that reproduce the MEPCO paper forms (see docs/forms/).

const thin = 0.6;
const thick = 1.3;

/// Times is the closest built-in font to the printed forms.
final serif = pw.Font.times();
final serifBold = pw.Font.timesBold();
final sans = pw.Font.helvetica();
final sansBold = pw.Font.helveticaBold();

pw.TextStyle ts(double size, {bool b = false, bool u = false, pw.Font? font}) =>
    pw.TextStyle(
      font: font ?? (b ? serifBold : serif),
      fontSize: size,
      decoration: u ? pw.TextDecoration.underline : null,
    );

/// Maps characters the built-in PDF fonts cannot draw (phone keyboards often
/// type them) to plain ones.
String clean(String s) => s
    .replaceAll(RegExp('[–—−]'), '-')
    .replaceAll(RegExp('[‘’]'), "'")
    .replaceAll(RegExp('[“”]'), '"')
    .replaceAll('…', '...')
    .replaceAll(' ', ' ');

/// One diagonal line ("/") filling [w] x [h].
pw.Widget diagonal(double w, double h) => pw.CustomPaint(
  size: PdfPoint(w, h),
  painter: (PdfGraphics canvas, PdfPoint size) {
    canvas
      ..setStrokeColor(PdfColors.black)
      ..setLineWidth(0.8)
      ..moveTo(0, 0)
      ..lineTo(size.x, size.y)
      ..strokePath();
  },
);

/// Draws ONE diagonal line over [child] (used for empty blocks).
pw.Widget struck(pw.Widget child, bool strike) {
  if (!strike) return child;
  return pw.Stack(
    children: [
      child,
      pw.Positioned.fill(
        child: pw.CustomPaint(
          painter: (PdfGraphics canvas, PdfPoint size) {
            canvas
              ..setStrokeColor(PdfColors.black)
              ..setLineWidth(0.8)
              ..moveTo(0, 0)
              ..lineTo(size.x, size.y)
              ..strokePath();
          },
        ),
      ),
    ],
  );
}

enum Al { left, center, right }

/// A cell of a [FormGrid] row.
class GCell {
  const GCell(
    this.text, {
    this.span = 1,
    this.bold = false,
    this.size = 8,
    this.align = Al.left,
    this.noBottom = false,
    this.widget,
    this.font,
    this.indent = 0,
  });
  final String text;
  final int span;
  final bool bold;
  final double size;
  final Al align;

  /// Hide the bottom line (to look like a cell spanning two rows).
  final bool noBottom;
  final pw.Widget? widget;
  final pw.Font? font;
  final double indent;
}

class GRow {
  const GRow(this.cells, {this.height = 13, this.bottom = thin});
  final List<GCell> cells;
  final double height;

  /// Thickness of the line under this row.
  final double bottom;
}

/// Area to strike through with one diagonal: columns [c0..c1], rows [r0..r1].
class Strike {
  const Strike(this.c0, this.c1, this.r0, this.r1);
  final int c0, c1, r0, r1;
}

/// A ruled table like the paper forms: fixed column widths, cells that can
/// span columns, thicker lines between groups, and diagonal strike-outs.
pw.Widget formGrid({
  required List<double> widths,
  required List<GRow> rows,
  List<Strike> strikes = const [],
  double frame = thick,
}) {
  double colX(int c) => widths.take(c).fold(0, (a, b) => a + b);
  double rowY(int r) => rows.take(r).fold(0, (a, b) => a + b.height);
  final total = colX(widths.length);

  pw.Widget cellWidget(GCell c, double w, GRow row, bool last) {
    final align = switch (c.align) {
      Al.center => pw.Alignment.center,
      Al.right => pw.Alignment.centerRight,
      Al.left => pw.Alignment.centerLeft,
    };
    return pw.Container(
      width: w,
      height: row.height,
      padding: pw.EdgeInsets.only(left: 2.5 + c.indent, right: 2.5),
      alignment: align,
      decoration: pw.BoxDecoration(
        border: pw.Border(
          right: last ? pw.BorderSide.none : const pw.BorderSide(width: thin),
          bottom: c.noBottom
              ? pw.BorderSide.none
              : pw.BorderSide(width: row.bottom),
        ),
      ),
      child:
          c.widget ??
          pw.Text(
            clean(c.text),
            maxLines: row.height > 18 ? 2 : 1,
            textAlign: switch (c.align) {
              Al.center => pw.TextAlign.center,
              Al.right => pw.TextAlign.right,
              Al.left => pw.TextAlign.left,
            },
            style: ts(c.size, b: c.bold, font: c.font),
          ),
    );
  }

  final rowWidgets = <pw.Widget>[];
  for (var r = 0; r < rows.length; r++) {
    final row = rows[r];
    var col = 0;
    final cells = <pw.Widget>[];
    for (final c in row.cells) {
      final w = colX(col + c.span) - colX(col);
      col += c.span;
      cells.add(cellWidget(c, w, row, col >= widths.length));
    }
    rowWidgets.add(pw.Row(children: cells));
  }

  return pw.Container(
    width: total + frame * 2,
    padding: pw.EdgeInsets.all(frame),
    decoration: pw.BoxDecoration(border: pw.Border.all(width: frame)),
    child: pw.Stack(
      children: [
        pw.Column(children: rowWidgets),
        for (final s in strikes)
          pw.Positioned(
            left: colX(s.c0),
            top: rowY(s.r0),
            child: diagonal(
              colX(s.c1 + 1) - colX(s.c0),
              rowY(s.r1 + 1) - rowY(s.r0),
            ),
          ),
      ],
    ),
  );
}

/// Scales proportional column widths to fill [width].
List<double> fit(List<double> parts, double width) {
  final sum = parts.fold<double>(0, (a, b) => a + b);
  return [for (final p in parts) p / sum * width];
}

/// A value written on a line (like the blanks of the printed form).
pw.Widget blank(
  String value, {
  double? width,
  double size = 9.5,
  bool bold = false,
  pw.Alignment align = pw.Alignment.bottomCenter,
}) {
  final w = pw.Container(
    width: width,
    padding: const pw.EdgeInsets.only(bottom: 0.5, left: 2, right: 2),
    alignment: align,
    decoration: const pw.BoxDecoration(
      border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
    ),
    child: pw.Text(clean(value), maxLines: 1, style: ts(size, b: bold)),
  );
  return width == null ? pw.Expanded(child: w) : w;
}

/// "Executive Engineer" set in small capitals, like the signature boxes.
pw.Widget smallCaps(String text, {double size = 8.5}) {
  final spans = <pw.TextSpan>[];
  final words = text.split(' ');
  for (var i = 0; i < words.length; i++) {
    final w = words[i];
    if (w.isEmpty) continue;
    final first = w.substring(0, 1);
    final rest = w.substring(1).toUpperCase();
    final startsCap = first.toUpperCase() == first;
    spans.add(
      pw.TextSpan(
        text: first.toUpperCase(),
        style: pw.TextStyle(
          font: sans,
          fontSize: startsCap ? size : size * 0.8,
        ),
      ),
    );
    if (rest.isNotEmpty) {
      spans.add(
        pw.TextSpan(
          text: rest,
          style: pw.TextStyle(font: sans, fontSize: size * 0.8),
        ),
      );
    }
    if (i < words.length - 1) {
      spans.add(
        pw.TextSpan(
          text: ' ',
          style: pw.TextStyle(fontSize: size),
        ),
      );
    }
  }
  return pw.RichText(
    textAlign: pw.TextAlign.center,
    text: pw.TextSpan(children: spans),
  );
}

/// Splits [text] into lines of about [maxChars] characters at word boundaries.
List<String> wrapText(String text, int maxChars) {
  final out = <String>[];
  for (final para in text.split('\n')) {
    var line = '';
    for (final word in para.split(RegExp(r'\s+'))) {
      if (word.isEmpty) continue;
      if (line.isEmpty) {
        line = word;
      } else if (line.length + 1 + word.length <= maxChars) {
        line = '$line $word';
      } else {
        out.add(line);
        line = word;
      }
    }
    out.add(line);
  }
  while (out.isNotEmpty && out.last.isEmpty) {
    out.removeLast();
  }
  return out;
}
