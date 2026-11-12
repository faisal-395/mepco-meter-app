import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

/// Shared building blocks for the report PDFs.

const lineW = 0.6;
const fs = 7.6; // body font size
const fsSmall = 6.6;

pw.TextStyle get bold =>
    pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: fs);
pw.TextStyle get normal => const pw.TextStyle(fontSize: fs);

/// Draws ONE diagonal line over [child] (used for unused columns / empty blocks).
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

/// A cell with right and bottom borders (the grid gets left/top from its frame).
pw.Widget cell(
  String text, {
  required double width,
  required double height,
  bool isBold = false,
  bool center = false,
  double fontSize = fs,
  int maxLines = 2,
}) {
  return pw.Container(
    width: width,
    height: height,
    padding: const pw.EdgeInsets.symmetric(horizontal: 2),
    alignment: center ? pw.Alignment.center : pw.Alignment.centerLeft,
    decoration: const pw.BoxDecoration(
      border: pw.Border(
        right: pw.BorderSide(width: lineW),
        bottom: pw.BorderSide(width: lineW),
      ),
    ),
    child: pw.Text(
      clean(text),
      maxLines: maxLines,
      textAlign: center ? pw.TextAlign.center : pw.TextAlign.left,
      style: pw.TextStyle(
        fontSize: fontSize,
        fontWeight: isBold ? pw.FontWeight.bold : pw.FontWeight.normal,
      ),
    ),
  );
}

/// A grid column: a header cell and value cells; struck through as a whole if [strike].
pw.Widget gridColumn({
  required String header,
  required List<String> values,
  required double width,
  required double rowHeight,
  required double headerHeight,
  bool strike = false,
  bool boldValues = false,
  bool centerValues = true,
}) {
  return struck(
    pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        cell(
          header,
          width: width,
          height: headerHeight,
          isBold: true,
          center: true,
        ),
        for (final v in values)
          cell(
            strike ? '' : v,
            width: width,
            height: rowHeight,
            isBold: boldValues,
            center: centerValues,
            maxLines: 1,
          ),
      ],
    ),
    strike,
  );
}

/// Frame giving a grid its left and top border.
pw.Widget gridFrame(List<pw.Widget> columns) => pw.Container(
  decoration: const pw.BoxDecoration(
    border: pw.Border(
      left: pw.BorderSide(width: lineW),
      top: pw.BorderSide(width: lineW),
    ),
  ),
  child: pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: columns,
  ),
);

pw.Widget sectionHeading(String text) => pw.Padding(
  padding: const pw.EdgeInsets.only(top: 6, bottom: 3),
  child: pw.Text(
    text,
    style: pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: 8.6,
      decoration: pw.TextDecoration.underline,
    ),
  ),
);

pw.Widget labelValue(String label, String value, {double fontSize = fs}) =>
    pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(
            text: label,
            style: pw.TextStyle(
              fontWeight: pw.FontWeight.bold,
              fontSize: fontSize,
            ),
          ),
          pw.TextSpan(
            text: clean(value),
            style: pw.TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );

/// Maps characters the built-in PDF font cannot draw (phone keyboards often
/// type them) to plain ones.
String clean(String s) => s
    .replaceAll(RegExp('[–—−]'), '-')
    .replaceAll(RegExp('[‘’]'), "'")
    .replaceAll(RegExp('[“”]'), '"')
    .replaceAll('…', '...')
    .replaceAll(' ', ' ');
