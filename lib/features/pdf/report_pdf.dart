import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../domain/calculations.dart';
import '../../domain/formatters.dart';
import '../../domain/models.dart';
import '../../domain/report_calc.dart';
import '../../domain/report_templates.dart';
import '../../domain/section_a.dart';
import '../../domain/settings_keys.dart';
import 'pdf_widgets.dart';

const _margin = 26.0;
const _contentWidth = 595.28 - 2 * _margin;

/// File name of a report PDF: `account_visitdate_TYPE.pdf`.
String reportPdfFileName(ReportBundle b) {
  String clean(String s) => s.replaceAll(RegExp(r'[^A-Za-z0-9\-]+'), '-');
  final acc = clean(b.sectionA['account_no'] ?? 'report');
  final date = clean(fmtDate(b.report.visitDate));
  return '${acc}_${date}_${b.report.reportType}.pdf';
}

/// Builds the 2-page A4 report PDF for any report type.
Future<Uint8List> buildReportPdf(
  ReportBundle b,
  Map<String, String> settings, {
  Uint8List? logo,
}) async {
  final doc = pw.Document(
    title: '${b.template.shortName} ${b.sectionA['account_no'] ?? ''}',
    author: 'MEPCO M&T',
    theme: pw.ThemeData.withFont(
      base: pw.Font.helvetica(),
      bold: pw.Font.helveticaBold(),
    ),
  );
  final r = _ReportPdf(b, {...SettingKeys.defaults, ...settings}, logo);
  final pageTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    margin: const pw.EdgeInsets.all(_margin),
  );
  doc.addPage(pw.Page(pageTheme: pageTheme, build: (_) => r.page1()));
  doc.addPage(pw.Page(pageTheme: pageTheme, build: (_) => r.page2()));
  return doc.save();
}

class _ReportPdf {
  _ReportPdf(this.b, this.settings, this.logo)
    : sc = computeSectionC(b, settings);

  final ReportBundle b;
  final Map<String, String> settings;
  final Uint8List? logo;
  final SectionC sc;

  ReportTemplate get t => b.template;
  String a(String k) => b.sectionA[k] ?? '';
  String get division => a('op_division');

  bool _strikeColumn(ColumnSlot c) => !c.isUsed;

  // ================================================================ page 1

  pw.Widget page1() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        _header(),
        pw.SizedBox(height: 4),
        _addressBlock(),
        sectionHeading('A)  DESCRIPTION OF INSTALLATION'),
        _sectionA(),
        if (t.isNewConnection) _newConnectionDetails(),
        sectionHeading('B)  ENERGY METER PARTICULARS'),
        _sectionB(),
        sectionHeading(
          t.isNet ? 'METER READINGS (BI-DIRECTIONAL)' : 'METER READINGS',
        ),
        _readings(),
        pw.Spacer(),
        _pageFooter(1),
      ],
    );
  }

  pw.Widget _header() {
    final logoBox = pw.Container(
      width: 56,
      height: 56,
      child: logo == null
          ? null
          : pw.Image(pw.MemoryImage(logo!), fit: pw.BoxFit.contain),
    );
    final amr = t.isNewConnection ? b.column(ColumnRole.amr).meter : null;
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        logoBox,
        pw.SizedBox(width: 8),
        pw.Expanded(
          child: pw.Column(
            children: [
              pw.Text(
                'MULTAN ELECTRIC POWER COMPANY',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              pw.SizedBox(height: 2),
              pw.Text(
                'Office of the Executive Engineer M&T MEPCO Circle ${settings[SettingKeys.circle]}',
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9,
                ),
              ),
              pw.Text(
                'Phone: ${settings[SettingKeys.officePhone]}',
                style: const pw.TextStyle(fontSize: 8),
              ),
              pw.SizedBox(height: 3),
              pw.Text(
                t.title.toUpperCase(),
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 9.5,
                  decoration: pw.TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 8),
        pw.SizedBox(
          width: 120,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              labelValue('Memo No: ', b.report.memoNo),
              pw.SizedBox(height: 2),
              labelValue('Dated: ', fmtDate(b.report.memoDate)),
              if (amr != null && amr.simNo.isNotEmpty) ...[
                pw.SizedBox(height: 2),
                labelValue('SIM No: ', amr.simNo),
              ],
              if (amr != null && amr.commId.isNotEmpty) ...[
                pw.SizedBox(height: 2),
                labelValue('Comm ID: ', amr.commId),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _refText() {
    final r = b.report;
    final no = r.refNo.trim(), date = fmtDate(r.refDate);
    String withNoDate(String base) {
      var s = base;
      if (no.isNotEmpty) s += ' No. $no';
      if (date.isNotEmpty) s += ' Dated $date';
      return s;
    }

    return switch (r.refType) {
      'telephonic' => withNoDate('Telephonic message'),
      'seasonal' => withNoDate('Seasonal check'),
      'routine' => withNoDate('Routine check'),
      _ => withNoDate('XEN (OP) $division Memo'),
    };
  }

  pw.Widget _addressBlock() {
    final r = b.report;
    final name = a('name'), address = a('address');
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('To:', style: bold),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 24),
          child: pw.Text(
            'The Sub Divisional Officer (OP), MEPCO Sub Division ${r.toSubDivision}',
            style: normal,
          ),
        ),
        pw.SizedBox(height: 3),
        labelValue(
          'Sub: ',
          'M/S: $name${address.isEmpty ? '' : ', $address'}   A/C No: ${a('account_no')}',
        ),
        pw.SizedBox(height: 2),
        labelValue('Ref: ', _refText()),
        pw.SizedBox(height: 3),
        pw.Text(
          clean(
            'In compliance with the above referred, the site was visited on '
            '${fmtDate(r.visitDate)} by the M&T team comprising '
            '${r.teamText.trim().isEmpty ? '________' : r.teamText.trim()} '
            'and the metering equipment was checked. The detail is as under:-',
          ),
          style: normal,
          textAlign: pw.TextAlign.justify,
        ),
      ],
    );
  }

  pw.Widget _sectionA() {
    const perRow = 3;
    final rows = <pw.TableRow>[];
    for (var i = 0; i < sectionACells.length; i += perRow) {
      rows.add(
        pw.TableRow(
          children: [
            for (final c in sectionACells.skip(i).take(perRow))
              pw.Container(
                height: 20,
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 3,
                  vertical: 2,
                ),
                alignment: pw.Alignment.centerLeft,
                child: pw.RichText(
                  maxLines: 2,
                  text: pw.TextSpan(
                    children: [
                      pw.TextSpan(
                        text: '${c.no}. ${c.label}: ',
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: fs,
                        ),
                      ),
                      pw.TextSpan(
                        text: clean(c.value(b.sectionA)),
                        style: normal,
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      );
    }
    return pw.Table(
      border: pw.TableBorder.all(width: lineW),
      columnWidths: const {
        0: pw.FlexColumnWidth(),
        1: pw.FlexColumnWidth(),
        2: pw.FlexColumnWidth(),
      },
      children: rows,
    );
  }

  pw.Widget _newConnectionDetails() {
    final r = b.report;
    String nd(String no, String date) => [
      no,
      if (date.isNotEmpty) 'dt $date',
    ].where((s) => s.isNotEmpty).join(' ');
    final items = {
      'App No: ': nd(a('application_no'), a('application_date')),
      'SCO No: ': nd(a('sco_mco_rco_no'), a('sco_date')),
      'Store Challan No: ': nd(r.storeChallanNo, fmtDate(r.storeChallanDate)),
      'New Meters: ': r.newMeterCount,
      'CTs: ': r.ctCount.isEmpty
          ? ''
          : '${r.ctCount} No. ${ctRatioText(b.sectionA)} A',
    };
    return pw.Container(
      padding: const pw.EdgeInsets.all(3),
      decoration: const pw.BoxDecoration(
        border: pw.Border(
          left: pw.BorderSide(width: lineW),
          right: pw.BorderSide(width: lineW),
          bottom: pw.BorderSide(width: lineW),
        ),
      ),
      child: pw.Wrap(
        spacing: 14,
        runSpacing: 2,
        children: [for (final e in items.entries) labelValue(e.key, e.value)],
      ),
    );
  }

  double get _labelWidth => t.isNet ? 150 : 130;
  double get _colWidth => (_contentWidth - _labelWidth) / b.columns.length;

  pw.Widget _sectionB() {
    final labels = ['MFG No', 'Make', 'Amps', 'Volts', 'Meter Constant', 'M.F'];
    const rowH = 13.0, headH = 16.0;
    return gridFrame([
      gridColumn(
        header: 'Particulars',
        values: labels,
        width: _labelWidth,
        rowHeight: rowH,
        headerHeight: headH,
        boldValues: true,
        centerValues: false,
      ),
      for (final c in b.columns)
        gridColumn(
          header: t.column(c.role).label,
          width: _colWidth,
          rowHeight: rowH,
          headerHeight: headH,
          strike: _strikeColumn(c),
          values: () {
            final m = c.meter;
            if (m == null) return List.filled(labels.length, '');
            final mf = m.mf.isNotEmpty ? m.mf : b.mfText;
            return [
              m.mfgNo,
              [m.make, m.meterKind].where((s) => s.isNotEmpty).join(' '),
              m.amps,
              m.volts,
              m.meterConstant.isEmpty ? '' : '${m.meterConstant} imp/kWh/kVARh',
              mf.isEmpty ? '' : 'R x $mf',
            ];
          }(),
        ),
    ]);
  }

  String _readingText(ColumnSlot c, ParamDef p) {
    if (p.kind == ParamKind.meterNo) return c.meter?.mfgNo ?? '';
    final v = c.readings[p.code]?.trim() ?? '';
    if (p.kind == ParamKind.instantKw && v.isNotEmpty) {
      return instantKwText(v, columnMf(b, c));
    }
    return v;
  }

  pw.Widget _readings() {
    final rowH = t.isNet ? 11.6 : 15.0;
    return gridFrame([
      gridColumn(
        header: 'Parameters',
        values: [
          for (final p in t.params)
            p.number == null ? p.label : '${p.number}. ${p.label}',
        ],
        width: _labelWidth,
        rowHeight: rowH,
        headerHeight: 16,
        boldValues: true,
        centerValues: false,
      ),
      for (final c in b.columns)
        gridColumn(
          header: t.column(c.role).label,
          width: _colWidth,
          rowHeight: rowH,
          headerHeight: 16,
          strike: _strikeColumn(c),
          values: [for (final p in t.params) _readingText(c, p)],
        ),
    ]);
  }

  pw.Widget _pageFooter(int page) => pw.Align(
    alignment: pw.Alignment.centerRight,
    child: pw.Text(
      'Page $page of 2',
      style: const pw.TextStyle(fontSize: fsSmall),
    ),
  );

  // ================================================================ page 2

  pw.Widget page2() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        pw.Text(
          'M/S: ${a('name')}   A/C No: ${a('account_no')}   Memo No: ${b.report.memoNo}   Dated: ${fmtDate(b.report.memoDate)}',
          style: const pw.TextStyle(fontSize: fsSmall),
        ),
        sectionHeading('C)  METER CHECKING RESULTS'),
        _sectionC(),
        sectionHeading('D)  SEALING STATUS / RECORD'),
        _sectionD(),
        sectionHeading('E)  DISCREPANCY, REMARKS AND RECOMMENDATIONS'),
        _sectionE(),
        sectionHeading('F)  POSTAL ORDERS SIGNED BY'),
        _sectionF(),
        pw.SizedBox(height: 6),
        _signatures(),
        pw.SizedBox(height: 8),
        _signOff(),
        _ccList(),
        pw.Spacer(),
        _pageFooter(2),
      ],
    );
  }

  pw.Widget _loadTable(String side) {
    const w = (_contentWidth - 10) / 2;
    final colW = [w * 0.16, w * 0.21, w * 0.21, w * 0.21, w * 0.21];
    const rowH = 13.0;
    final has = sc.hasSide(side);
    String num(String s) => s.trim();
    final rows = <List<String>>[];
    for (final p in phases) {
      final l = b.phaseLoads[phaseKey(side, p)];
      rows.add([
        p,
        num(l?.volts ?? ''),
        num(l?.amps ?? ''),
        fmtNum(sc.phaseKw[phaseKey(side, p)]),
        num(l?.pf ?? ''),
      ]);
    }
    rows.add(['Total', '', '', fmtNum(sc.sideTotal(side)), '']);
    final headers = ['Phase', 'Volts', 'Amps', 'K.W', 'P.F'];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          width: w,
          height: 14,
          alignment: pw.Alignment.center,
          decoration: pw.BoxDecoration(border: pw.Border.all(width: lineW)),
          child: pw.Text(
            side == 'import' ? 'IMPORT LOAD' : 'EXPORT LOAD',
            style: bold,
          ),
        ),
        struck(
          gridFrame([
            for (var i = 0; i < 5; i++)
              gridColumn(
                header: headers[i],
                values: [
                  for (final r in rows) has ? r[i] : (i == 0 ? r[0] : ''),
                ],
                width: colW[i],
                rowHeight: rowH,
                headerHeight: rowH,
                boldValues: i == 0,
              ),
          ]),
          !has,
        ),
      ],
    );
  }

  pw.Widget _sectionC() {
    final within = sc.within;
    final method =
        settings[SettingKeys.checkLoadMethod] == SettingKeys.methodSum
        ? 'sum of phases'
        : 'average of phases';
    final errText = percentErrorText(b, sc);
    final checkLoad = b.report.checkLoadOverride.trim().isNotEmpty
        ? b.report.checkLoadOverride.trim()
        : fmtNum(sc.importCheckLoad);
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            _loadTable('import'),
            pw.SizedBox(width: 10),
            _loadTable('export'),
          ],
        ),
        pw.SizedBox(height: 4),
        labelValue(
          'Check load: ',
          checkLoad.isEmpty ? '' : '$checkLoad KW ($method)',
        ),
        pw.SizedBox(height: 2),
        labelValue(
          t.isNet
              ? '% age Billing / B/UP meter recorded instantaneous KW: '
              : '% age error of meter recorded instantaneous KW: ',
          errText,
        ),
        pw.SizedBox(height: 2),
        labelValue(
          'Within permissible limits of error: ',
          within == null ? '' : (within ? 'Yes' : 'No'),
        ),
      ],
    );
  }

  pw.Widget _sectionD() {
    final cols = b.columns;
    final anySeal = b.seals.values.any((s) => !s.isEmpty);
    const rowH = 13.0;
    const labelW = 70.0;
    final colW = (_contentWidth - labelW) / cols.length;
    final grid = gridFrame([
      gridColumn(
        header: 'Seal at',
        values: [for (final s in sealSpots) s.label],
        width: labelW,
        rowHeight: rowH,
        headerHeight: rowH * 2,
        boldValues: true,
        centerValues: false,
      ),
      for (final c in cols)
        () {
          final hasSeals = sealSpots.any(
            (s) => !(b.seals[sealKey(s.code, c.role)]?.isEmpty ?? true),
          );
          final strike = anySeal && !hasSeals;
          return struck(
            pw.Column(
              children: [
                cell(
                  t.column(c.role).label,
                  width: colW,
                  height: rowH,
                  isBold: true,
                  center: true,
                ),
                pw.Row(
                  children: [
                    gridColumn(
                      header: 'M&T Seals',
                      values: [
                        for (final s in sealSpots)
                          b.seals[sealKey(s.code, c.role)]?.mtSeal ?? '',
                      ],
                      width: colW / 2,
                      rowHeight: rowH,
                      headerHeight: rowH,
                    ),
                    gridColumn(
                      header: 'Postal Orders',
                      values: [
                        for (final s in sealSpots)
                          b.seals[sealKey(s.code, c.role)]?.postalOrder ?? '',
                      ],
                      width: colW / 2,
                      rowHeight: rowH,
                      headerHeight: rowH,
                    ),
                  ],
                ),
              ],
            ),
            strike,
          );
        }(),
    ]);
    return struck(grid, !anySeal);
  }

  pw.Widget _sectionE() {
    final r = b.report;
    pw.Widget box(pw.Widget child, {bool strike = false}) => struck(
      pw.Container(
        width: _contentWidth,
        padding: const pw.EdgeInsets.all(4),
        decoration: pw.BoxDecoration(border: pw.Border.all(width: lineW)),
        child: child,
      ),
      strike,
    );

    if (t.isNewConnection) {
      return box(
        pw.Text(
          clean(r.remarks),
          style: normal,
          textAlign: pw.TextAlign.justify,
        ),
        strike: r.remarks.trim().isEmpty,
      );
    }
    final checked = r.checkedLoadKw.trim();
    final lines = <(String, String)>[
      ('MSB Status', r.msbStatus),
      ('Postal Orders', r.postalOrdersText),
      ('Checked Load', checked.isEmpty ? '' : '$checked KW'),
      ('Export Load', r.exportLoadText),
      ('Accuracy', r.accuracyText),
      ('Transformer LT Bushes', r.transformerLtBushes),
    ];
    final allEmpty =
        lines.every((l) => l.$2.trim().isEmpty) && r.remarks.trim().isEmpty;
    return box(
      pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          for (var i = 0; i < lines.length; i++)
            pw.Padding(
              padding: const pw.EdgeInsets.only(bottom: 1.5),
              child: labelValue('${i + 1}. ${lines[i].$1}: ', lines[i].$2),
            ),
          if (r.remarks.trim().isNotEmpty) ...[
            pw.SizedBox(height: 2),
            labelValue('${lines.length + 1}. Remarks: ', r.remarks.trim()),
          ],
        ],
      ),
      strike: allEmpty,
    );
  }

  pw.Widget _sectionF() {
    final r = b.report;
    final names = [r.signerExenOp, r.signerSdoOp, r.signer3, r.signer4];
    return pw.Table(
      border: pw.TableBorder.all(width: lineW),
      columnWidths: const {0: pw.FixedColumnWidth(18), 1: pw.FlexColumnWidth()},
      children: [
        for (var i = 0; i < 4; i++)
          pw.TableRow(
            children: [
              pw.Container(
                height: 13,
                alignment: pw.Alignment.center,
                child: pw.Text('${i + 1}', style: bold),
              ),
              pw.Container(
                height: 13,
                padding: const pw.EdgeInsets.symmetric(horizontal: 3),
                alignment: pw.Alignment.centerLeft,
                child: pw.Text(clean(names[i]), style: normal),
              ),
            ],
          ),
      ],
    );
  }

  pw.Widget _signatures() {
    final labels = [
      'Consumer',
      'Supervisor M&T\nCircle B/Nagar',
      'SDO (OP)\nSub Division ${b.report.toSubDivision}',
      'Executive Engineer M&T\nCircle B/Nagar',
      'Executive Engineer (OP)\n$division',
    ];
    return pw.Table(
      border: pw.TableBorder.all(width: lineW),
      children: [
        pw.TableRow(
          children: [for (final _ in labels) pw.SizedBox(height: 34)],
        ),
        pw.TableRow(
          children: [
            for (final l in labels)
              pw.Container(
                height: 22,
                alignment: pw.Alignment.center,
                padding: const pw.EdgeInsets.symmetric(horizontal: 2),
                child: pw.Text(
                  l,
                  textAlign: pw.TextAlign.center,
                  style: pw.TextStyle(
                    fontSize: fsSmall,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }

  pw.Widget _signOff() => pw.Align(
    alignment: pw.Alignment.centerRight,
    child: pw.SizedBox(
      width: 190,
      child: pw.Column(
        children: [
          pw.SizedBox(height: 18),
          pw.Text(settings[SettingKeys.xenMt] ?? '', style: bold),
          pw.Text('Executive Engineer M&T', style: bold),
          pw.Text('MEPCO Circle B/Nagar', style: bold),
        ],
      ),
    ),
  );

  pw.Widget _ccList() {
    final lines = (settings[SettingKeys.ccList] ?? '')
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    if (lines.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('C.C:', style: bold),
        for (var i = 0; i < lines.length; i++)
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 12, top: 1),
            child: pw.Text(
              '${i + 1}. ${fillTemplate(lines[i], {'division': division})}',
              style: const pw.TextStyle(fontSize: fsSmall + 0.4),
            ),
          ),
      ],
    );
  }
}
