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
const _w = 595.28 - 2 * _margin; // content width

/// File name of a report PDF: `account_visitdate_TYPE.pdf`.
String reportPdfFileName(ReportBundle b) {
  String c(String s) => s.replaceAll(RegExp(r'[^A-Za-z0-9\-]+'), '-');
  final acc = c(b.sectionA['account_no'] ?? 'report');
  final date = c(fmtDate(b.report.visitDate));
  return '${acc}_${date}_${b.report.reportType}.pdf';
}

/// Builds the 2-page A4 report exactly in the layout of the MEPCO paper forms
/// (docs/forms/): AMR test check, net meter and new connection.
Future<Uint8List> buildReportPdf(
  ReportBundle b,
  Map<String, String> settings, {
  Uint8List? logo,
}) async {
  final doc = pw.Document(
    title: '${b.template.shortName} ${b.sectionA['account_no'] ?? ''}',
    author: 'MEPCO M&T',
    theme: pw.ThemeData.withFont(base: serif, bold: serifBold),
  );
  final f = _Form(b, {...SettingKeys.defaults, ...settings}, logo);
  final theme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    margin: const pw.EdgeInsets.fromLTRB(_margin, 20, _margin, 22),
  );
  doc.addPage(pw.Page(pageTheme: theme, build: (_) => f.page1()));
  doc.addPage(pw.Page(pageTheme: theme, build: (_) => f.page2()));
  return doc.save();
}

class _Form {
  _Form(this.b, this.s, this.logo) : sc = computeSectionC(b, s);

  final ReportBundle b;
  final Map<String, String> s;
  final Uint8List? logo;
  final SectionC sc;

  ReportTemplate get t => b.template;
  bool get isNet => t.isNet;
  bool get isNew => t.isNewConnection;
  String a(String k) => (b.sectionA[k] ?? '').trim();
  String get division => a('op_division');
  String get subDivision => b.report.toSubDivision.trim().isEmpty
      ? a('sub_division')
      : b.report.toSubDivision.trim();
  String get circle => s[SettingKeys.circle] ?? '';
  String dash(String v) => v.trim().isEmpty ? '-' : v.trim();

  /// Columns used by the seals grid and the "% age" lines (2nd and 3rd meter).
  String get col2 => isNet ? ColumnRole.billing : ColumnRole.amr;
  String get col3 => isNet ? ColumnRole.backup : ColumnRole.existing;

  // ==================================================================== page 1

  pw.Widget page1() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      isNet ? _headerNet() : _headerAmr(),
      pw.SizedBox(height: 5),
      _toBlock(),
      pw.SizedBox(height: 4),
      _subject(),
      pw.SizedBox(height: 4),
      _ref(),
      pw.SizedBox(height: 5),
      _intro(),
      pw.SizedBox(height: 4),
      _sectionA(),
      pw.SizedBox(height: 3),
      _sectionB(),
      pw.SizedBox(height: 3),
      _readings(),
      pw.Spacer(),
      _signatureBox(),
    ],
  );

  pw.Widget _logo(double size) {
    if (logo == null) return pw.SizedBox(height: size);
    return pw.Center(
      child: pw.Image(
        pw.MemoryImage(logo!),
        width: size,
        height: size,
        fit: pw.BoxFit.contain,
      ),
    );
  }

  pw.Widget _headerAmr() {
    final amr = isNew ? b.column(ColumnRole.amr).meter : null;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        _logo(logo == null ? 8 : 40),
        pw.Center(
          child: pw.Text(
            'MULTAN ELECTRIC POWER COMPANY LIMITED',
            style: pw.TextStyle(
              font: serifBold,
              fontSize: 15.5,
              letterSpacing: 0.6,
              decoration: pw.TextDecoration.underline,
              decorationThickness: 2,
            ),
          ),
        ),
        pw.SizedBox(height: 3),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(
              width: 150,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Phone No. ${s[SettingKeys.officePhone]}',
                    style: ts(7.5, b: true),
                  ),
                  pw.SizedBox(height: 16),
                  pw.Row(
                    children: [
                      pw.Text('Memo No.', style: ts(8)),
                      pw.SizedBox(width: 4),
                      blank(b.report.memoNo, width: 95),
                    ],
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: isNew
                  ? pw.Column(
                      children: [
                        pw.Text('New Connection', style: ts(11, b: true)),
                        if (amr != null && amr.simNo.isNotEmpty)
                          pw.Text('SIM No: ${amr.simNo}', style: ts(9.5)),
                        if (amr != null && amr.commId.isNotEmpty)
                          pw.Text('ID: ${amr.commId}', style: ts(9.5)),
                      ],
                    )
                  : pw.SizedBox(),
            ),
            pw.SizedBox(
              width: 140,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text('Office of the', style: ts(7.5, b: true)),
                  pw.Text('Executive Engineer M&T', style: ts(7.5, b: true)),
                  pw.Text('MEPCO Circle $circle', style: ts(7.5, b: true)),
                  pw.Row(
                    children: [
                      pw.Text('Dated', style: ts(7.5)),
                      pw.SizedBox(width: 3),
                      blank(fmtDate(b.report.memoDate), width: 95),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _headerNet() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      _logo(logo == null ? 4 : 36),
      pw.Center(
        child: pw.Text(
          'MULTAN ELECTRIC POWER COMPANY',
          style: pw.TextStyle(
            font: serifBold,
            fontSize: 16,
            letterSpacing: 0.6,
            decoration: pw.TextDecoration.underline,
            decorationThickness: 2,
          ),
        ),
      ),
      pw.Center(
        child: pw.Text(
          'Office of the Executive Engineer M&T MEPCO Circle $circle',
          style: ts(9.5, b: true, u: true),
        ),
      ),
      pw.SizedBox(height: 4),
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Phone No. ${s[SettingKeys.officePhone]}',
                style: ts(7.5, b: true),
              ),
              pw.Row(
                children: [
                  pw.Text('Memo No', style: ts(8)),
                  pw.SizedBox(width: 4),
                  blank(b.report.memoNo, width: 110),
                ],
              ),
            ],
          ),
          pw.Spacer(),
          pw.Text('Dated', style: ts(8)),
          pw.SizedBox(width: 4),
          blank(fmtDate(b.report.memoDate), width: 110),
        ],
      ),
    ],
  );

  pw.Widget _toBlock() => pw.Padding(
    padding: const pw.EdgeInsets.only(left: 62),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('The Sub Divisional Officer (OP),', style: ts(8.5)),
        pw.RichText(
          text: pw.TextSpan(
            children: [
              pw.TextSpan(text: 'MEPCO Sub Division ', style: ts(8.5)),
              pw.TextSpan(
                text: clean(subDivision),
                style: ts(9, b: true, u: true),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  pw.Widget _subject() {
    final name = a('name'), address = a('address');
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(width: 30, child: pw.Text('Sub:', style: ts(8.5))),
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Text(
                'INSTALLATION CUM TEST CHECK REPORT OF THE METERING EQUIPMENTS IN RESPECT OF',
                style: ts(8.6, b: true, u: true),
              ),
              pw.SizedBox(height: 2),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(width: thick),
                ),
                child: pw.Text(
                  clean('M/S: $name${address.isEmpty ? '' : ' $address'}'),
                  maxLines: 1,
                  style: ts(10.5, b: true),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _ref() => pw.Row(
    crossAxisAlignment: pw.CrossAxisAlignment.end,
    children: [
      pw.SizedBox(width: 30, child: pw.Text('Ref:', style: ts(8.5))),
      pw.Text(
        'Your memo No. / Telephonic message / Seasonal / Routine check',
        style: ts(8),
      ),
      pw.SizedBox(width: 4),
      blank(b.report.refNo),
      pw.SizedBox(width: 4),
      pw.Text('Dated', style: ts(8)),
      pw.SizedBox(width: 4),
      blank(fmtDate(b.report.refDate), width: 80),
    ],
  );

  pw.Widget _intro() {
    final team = b.report.teamText.trim();
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 30),
      child: pw.RichText(
        textAlign: pw.TextAlign.justify,
        text: pw.TextSpan(
          style: ts(8.6),
          children: [
            pw.TextSpan(
              text: clean(
                '          The undersigned along with ${team.isEmpty ? '____________' : team} '
                '& yourself visited the above noted premises on dated ',
              ),
            ),
            pw.TextSpan(
              text: fmtDate(b.report.visitDate),
              style: ts(9.5, u: true),
            ),
            const pw.TextSpan(
              text:
                  ' to check / install AMR L.T MDI metering equipment at site. '
                  'The related particulars of metering equipment\'s and other '
                  'necessary description are as under:-',
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------------ A

  pw.Widget _title(String letter, String text) => pw.Padding(
    padding: const pw.EdgeInsets.only(left: 6, bottom: 1),
    child: pw.Row(
      children: [
        pw.SizedBox(
          width: 40,
          child: pw.Text('$letter).', style: ts(9, b: true)),
        ),
        pw.Text(text, style: ts(9, b: true)),
      ],
    ),
  );

  pw.Widget _sectionA() {
    String nd(String no, String date) =>
        [no, date].where((x) => x.trim().isNotEmpty).join(' ');
    final tfMake = a('transformer_make');
    final kva = a('transformer_kva');
    final cells = <(String, String)>[
      ('Application No & Date', nd(a('application_no'), a('application_date'))),
      (
        'A/C No & Tariff',
        [a('account_no'), a('tariff')].where((x) => x.isNotEmpty).join(' / '),
      ),
      ('Sanctioned by SE/XEN No & Date', a('sanction_ref')),
      (
        'Sanction Load',
        a('sanctioned_load_kw').isEmpty ? '' : '${a('sanctioned_load_kw')} Kw',
      ),
      ('SCO / MCO / RCO No & Date', nd(a('sco_mco_rco_no'), a('sco_date'))),
      ('Kind of Industry', a('industry_kind')),
      (
        'Capacity of Transformer & Make',
        kva.isEmpty ? tfMake : '$kva/KVA${tfMake.isEmpty ? '' : ' ($tfMake)'}',
      ),
      ('Size of Cable', a('cable_size')),
      ('CT Ratio & VA Burden', ctRatioText(b.sectionA)),
      ('Type of MSB', a('msb_type')),
      (
        isNew ? 'Connected Load  T/F No.' : 'Connected Load',
        isNew
            ? [
                a('connected_load'),
                [
                  a('transformer_no'),
                  if (tfMake.isNotEmpty) '/$tfMake',
                ].join(' '),
              ].where((x) => x.trim().isNotEmpty).join('  ')
            : a('connected_load'),
      ),
      ('Feeder Name', a('feeder_name')),
    ];
    final widths = fit([14, 132, 120, 14, 100, 140], _w - 2 * thick);
    GCell no(int n) => GCell('$n', align: Al.center, size: 7);
    GCell label(String l) => GCell(l, size: 7.6);
    GCell value(String v) =>
        GCell(dash(v), bold: true, align: Al.center, size: 8.6);
    final rows = [
      for (var i = 0; i < 12; i += 2)
        GRow([
          no(i + 1),
          label(cells[i].$1),
          value(cells[i].$2),
          no(i + 2),
          label(cells[i + 1].$1),
          value(cells[i + 1].$2),
        ], height: 12),
    ];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _title(
          'A',
          isNet
              ? 'DESCRIPTION OF INSTALLATION OF BI-DIRECTION METER (NET METER)'
              : 'DESCRIPTION OF INSTALLATION / MCO / EOL / BACKUP ADDED',
        ),
        formGrid(widths: widths, rows: rows),
      ],
    );
  }

  // ------------------------------------------------------------------ B

  /// Meter columns of section B, in form order.
  List<(String, ColumnSlot)> get _bColumns => isNet
      ? [
          ('Billing NET Meter', b.column(ColumnRole.billing)),
          ('B/up NET Meter 2', b.column(ColumnRole.backup)),
          ('Removed Meter', b.column(ColumnRole.removed)),
        ]
      : [
          ('Removed Meter', b.column(ColumnRole.removed)),
          (isNew ? 'AMR Meter' : 'AMR Meter', b.column(ColumnRole.amr)),
          ('Installed / Existing Meter', b.column(ColumnRole.existing)),
        ];

  String _make(ColumnSlot c) {
    final m = c.meter;
    if (m == null) return '';
    final make = m.make.trim(), kind = m.meterKind.trim();
    if (kind == 'NET' || make.toUpperCase().contains(kind.toUpperCase())) {
      return make;
    }
    if (kind == 'AMI') return '$make $kind'.trim();
    return '$kind $make'.trim();
  }

  pw.Widget _sectionB() {
    final cols = _bColumns;
    final widths = fit([150, 125, 125, 125], _w - 2 * thick);
    final labels = ['MFG No', 'Make', 'Amps', 'Volts', 'Meter Constant', 'M.F'];
    String val(ColumnSlot c, int i) {
      final m = c.meter;
      if (m == null || !c.isUsed) return '';
      final mf = m.mf.isNotEmpty ? m.mf : b.mfText;
      return switch (i) {
        0 => m.mfgNo,
        1 => _make(c),
        2 => m.amps,
        3 => m.volts,
        4 =>
          m.meterConstant.isEmpty
              ? ''
              : (isNet
                    ? '${m.meterConstant}/imp'
                    : '${m.meterConstant} Imp/KWH /KVARH'),
        _ => mf.isEmpty ? '' : 'R x $mf',
      };
    }

    final rows = [
      GRow([
        const GCell('Description', bold: true, align: Al.center, size: 9),
        for (final c in cols)
          GCell(c.$1, bold: true, align: Al.center, size: 8.6),
      ], height: 13),
      for (var i = 0; i < labels.length; i++)
        GRow([
          GCell(labels[i], bold: true, size: 8.6),
          for (final c in cols) GCell(val(c.$2, i), bold: true, size: 8),
        ], height: 11.5),
    ];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _title(
          'B',
          isNet ? 'NET METER PARTICULARS:' : 'ENERGY METER PARTICULARS:',
        ),
        formGrid(
          widths: widths,
          rows: rows,
          strikes: [
            for (var i = 0; i < cols.length; i++)
              if (!cols[i].$2.isUsed) Strike(i + 1, i + 1, 0, rows.length - 1),
          ],
        ),
      ],
    );
  }

  // ------------------------------------------------------------------ readings

  String _reading(ColumnSlot c, ParamDef p) {
    if (!c.isUsed) return '';
    if (p.kind == ParamKind.meterNo) return c.meter?.mfgNo ?? '';
    final v = c.readings[p.code]?.trim() ?? '';
    if (p.kind == ParamKind.instantKw && v.isNotEmpty) {
      return instantKwText(v, columnMf(b, c)).replaceAll(' KW', ' Kw');
    }
    return v;
  }

  pw.Widget _readings() => isNet ? _readingsNet() : _readingsAmr();

  pw.Widget _readingsAmr() {
    final cols = [
      ('Removed Meter', b.column(ColumnRole.removed)),
      ('AMR Meter', b.column(ColumnRole.amr)),
      ('Installed / Existing Meter', b.column(ColumnRole.existing)),
    ];
    final widths = fit([150, 125, 125, 125], _w - 2 * thick);
    // Last row of each group gets a thick line, like the form.
    const groupEnds = {
      'time',
      'kwh_off',
      'kvarh_off',
      'mdi_off',
      'cum_mdi_off',
    };
    const groupHeads = {
      'kwh_total',
      'kvarh_total',
      'mdi_total',
      'cum_mdi_total',
    };
    const rowH = 17.6;
    final rows = <GRow>[
      GRow(
        [
          const GCell(
            'Meter Parameter',
            bold: true,
            align: Al.center,
            size: 9.5,
          ),
          for (final c in cols)
            GCell(c.$1, bold: true, align: Al.center, size: 9),
        ],
        height: 22,
        bottom: thick,
      ),
      for (final p in t.params)
        GRow(
          [
            GCell(
              p.label,
              bold: groupHeads.contains(p.code),
              size: 9,
              indent: groupHeads.contains(p.code) ? 0 : 2,
            ),
            for (final c in cols)
              GCell(_reading(c.$2, p), align: Al.center, size: 10),
          ],
          height: rowH,
          bottom: groupEnds.contains(p.code) ? thick : thin,
        ),
    ];
    return formGrid(
      widths: widths,
      rows: rows,
      strikes: [
        for (var i = 0; i < cols.length; i++)
          if (!cols[i].$2.isUsed) Strike(i + 1, i + 1, 1, rows.length - 1),
      ],
    );
  }

  pw.Widget _readingsNet() {
    final cols = [
      ('Billing Net Meter', b.column(ColumnRole.billing)),
      ('B/up Net Meter', b.column(ColumnRole.backup)),
      ('Meter', b.column(ColumnRole.removed)),
      ('B/up Meter', b.column(ColumnRole.backupRemoved)),
    ];
    final widths = fit([28, 140, 100, 100, 80, 80], _w - 2 * thick);
    const rowH = 12.3;
    final rows = <GRow>[
      GRow(
        [
          const GCell('Sr.No', bold: true, align: Al.center, size: 8.5),
          const GCell('Parameters', bold: true, size: 9),
          for (final c in cols)
            GCell(c.$1, bold: true, align: Al.center, size: 8.5),
        ],
        height: 15,
        bottom: thick,
      ),
      for (final p in t.params)
        GRow([
          GCell('${p.number}.', align: Al.center, size: 8.5),
          GCell(p.label, bold: true, size: 8.4),
          for (final c in cols)
            GCell(_reading(c.$2, p), align: Al.center, size: 9),
        ], height: rowH),
    ];
    return formGrid(
      widths: widths,
      rows: rows,
      strikes: [
        for (var i = 0; i < cols.length; i++)
          if (!cols[i].$2.isUsed) Strike(i + 2, i + 2, 1, rows.length - 1),
      ],
    );
  }

  // ------------------------------------------------------------------ signatures

  pw.Widget _signatureBox() {
    final widths = fit([75, 105, 105, 125, 115], _w - 2 * thick);
    GCell top(String s) => GCell(
      '',
      widget: pw.Center(child: smallCaps(s, size: 9)),
      align: Al.center,
    );
    GCell bottom(String s, {bool hand = false}) => GCell(
      '',
      widget: pw.Center(
        child: hand
            ? pw.Text(clean(s), style: ts(10, u: true))
            : smallCaps(s, size: 9),
      ),
    );
    return pw.Column(
      children: [
        pw.SizedBox(height: 26),
        formGrid(
          widths: widths,
          rows: [
            GRow([
              GCell(
                '',
                noBottom: true,
                widget: pw.Align(
                  alignment: pw.Alignment.bottomCenter,
                  child: smallCaps('Consumer', size: 9.5),
                ),
              ),
              top('Supervisor'),
              top('SDO (OP)\nSub Division'),
              top('Executive Engineer'),
              top('Executive Engineer\n(OP)'),
            ], height: 21),
            GRow([
              const GCell(''),
              bottom('M&T Circle\nB/Nagar'),
              bottom(subDivision, hand: true),
              bottom('M&T Circle B/Nagar'),
              bottom(division, hand: true),
            ], height: 21),
          ],
        ),
      ],
    );
  }

  // ==================================================================== page 2

  pw.Widget page2() => pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.stretch,
    children: [
      _sectionC(),
      pw.SizedBox(height: 4),
      _percentLines(),
      pw.SizedBox(height: 6),
      _sectionD(),
      pw.SizedBox(height: 6),
      _sectionE(),
      pw.SizedBox(height: 6),
      _sectionF(),
      _signatureBox(),
      pw.SizedBox(height: 14),
      pw.Align(
        alignment: pw.Alignment.centerRight,
        child: pw.Column(
          children: [
            pw.Text('Executive Engineer', style: ts(10, b: true)),
            pw.Text('M&T MEPCO Circle B/Nagar', style: ts(10, b: true)),
          ],
        ),
      ),
      _ccList(),
      pw.Spacer(),
    ],
  );

  pw.Widget _sectionTitle(String letter, String text) => pw.Padding(
    padding: const pw.EdgeInsets.only(left: 24, bottom: 2),
    child: pw.Row(
      children: [
        pw.SizedBox(
          width: 30,
          child: pw.Text('$letter).', style: ts(8.5, b: true)),
        ),
        pw.Text(text, style: ts(8.5, b: true, u: true)),
      ],
    ),
  );

  String _kw(double? v) => v == null ? '' : v.toStringAsFixed(2);

  /// Phase table: Phase | Volts | Amps | KW | P.F, rows Red/Yellow/Blue/Total.
  pw.Widget _loadTable(String side, double width) {
    final widths = fit([46, 46, 46, 46, 40], width - 2 * thin);
    final has = sc.hasSide(side);
    const names = {'R': 'Red', 'Y': 'Yellow', 'B': 'Blue'};
    final load = side == 'import' ? sc.importCheckLoad : sc.exportCheckLoad;
    final rows = <GRow>[
      GRow([
        for (final h in ['Phase', 'Volts', 'Amps', 'KW', 'P.F'])
          GCell(h, bold: true, align: Al.center, size: 7.6),
      ], height: 11),
      for (final p in phases)
        () {
          final l = b.phaseLoads[phaseKey(side, p)];
          return GRow([
            GCell(names[p]!, size: 8),
            GCell(has ? (l?.volts ?? '') : '', align: Al.center, size: 9.5),
            GCell(has ? (l?.amps ?? '') : '', align: Al.center, size: 9.5),
            GCell(
              has ? _kw(sc.phaseKw[phaseKey(side, p)]) : '',
              align: Al.center,
              size: 9.5,
            ),
            GCell(has ? (l?.pf ?? '') : '', align: Al.center, size: 9.5),
          ], height: 15);
        }(),
      GRow([
        const GCell('Total', bold: true, size: 8),
        GCell(
          has ? b.report.loadType : '',
          span: 2,
          align: Al.center,
          size: 9.5,
        ),
        GCell(
          has
              ? (side == 'import' &&
                        b.report.checkLoadOverride.trim().isNotEmpty
                    ? '${b.report.checkLoadOverride.trim()} Kw'
                    : (load == null ? '' : '${_kw(load)} Kw'))
              : '',
          span: 2,
          align: Al.center,
          size: 9.5,
        ),
      ], height: 15),
    ];
    return formGrid(
      widths: widths,
      rows: rows,
      frame: thin,
      strikes: [if (!has) const Strike(1, 4, 1, 4)],
    );
  }

  pw.Widget _sectionC() {
    if (isNew) {
      const leftW = 300.0;
      final boxW = _w - leftW - 12;
      final bw = fit([46, 32, 22, 32, 22, 32], boxW - 2 * thin);
      GCell l(String s) => GCell(s, size: 6.8);
      final box = formGrid(
        widths: bw,
        frame: thin,
        rows: [
          GRow([
            const GCell('Existing Meter', span: 6, size: 6.8, bold: true),
          ], height: 10),
          GRow([
            l('Avg. Kw'),
            l(''),
            l('T.C'),
            l(''),
            l('T.O'),
            l(''),
          ], height: 11),
          GRow([l('%Error'), const GCell('', span: 5)], height: 10),
          GRow([
            const GCell('AMR Meter', span: 6, size: 6.8, bold: true),
          ], height: 10),
          GRow([
            l('Avg. Kw'),
            l(''),
            l('T.C'),
            l(''),
            l('T.O'),
            l(''),
          ], height: 11),
          GRow([l('%Error'), const GCell('', span: 5)], height: 10),
        ],
        strikes: const [Strike(1, 5, 0, 5)],
      );
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          _sectionTitle('C', 'METER CHECKING RESULTS OF EXISTING AMR METERS'),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              _loadTable('import', leftW),
              pw.SizedBox(width: 12),
              box,
            ],
          ),
        ],
      );
    }
    const gap = 40.0;
    final tw = (_w - gap - 40) / 2;
    pw.Widget side(String label, String key) => pw.Column(
      children: [
        pw.Text(label, style: ts(8, b: true)),
        _loadTable(key, tw),
      ],
    );
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('C', 'METER CHECKING RESULTS OF EXISTING METERS'),
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 20),
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              side('(Import Load)', 'import'),
              pw.SizedBox(width: gap),
              side('(Export Load)', 'export'),
            ],
          ),
        ),
      ],
    );
  }

  /// "% age  Billing / B/UP Meter Recorded Instantaneous K.W" with values.
  pw.Widget _percentLines() {
    String line(String role) {
      final kw = sc.instantImport[role];
      if (kw == null) return '';
      final err = sc.errorImport[role];
      return '${kw.toStringAsFixed(2)} Kw${err == null ? '' : '   (${err.toStringAsFixed(2)} %)'}';
    }

    final override = b.report.percentErrorOverride.trim();
    final within = sc.within == null
        ? ''
        : (sc.within! ? '' : '  NOT within limits');
    final l1 = isNew
        ? 'AMR Meter Recorded Instantaneous K.W'
        : 'Billing  Meter Recorded Instantaneous K.W';
    final l2 = isNew
        ? 'TOU Meter Recorded Instantaneous K.W'
        : 'B/UP   Meter Recorded Instantaneous K.W';
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 24),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('% age', style: ts(7.5, b: true)),
              pw.Text(l1, style: ts(7.8, b: true)),
              pw.Text(l2, style: ts(7.8, b: true)),
            ],
          ),
          pw.SizedBox(width: 12),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.stretch,
              children: [
                pw.Text(
                  'Within Permissible Limits of Error',
                  style: ts(7.8, b: true, u: true),
                ),
                pw.Row(
                  children: [
                    blank(
                      override.isNotEmpty ? '$override %' : line(col2) + within,
                      align: pw.Alignment.bottomLeft,
                    ),
                  ],
                ),
                pw.Row(
                  children: [blank(line(col3), align: pw.Alignment.bottomLeft)],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------ D

  pw.Widget _sectionD() {
    final removed = b.column(ColumnRole.removed);
    final groups = [
      ('Removed Meter', removed.role),
      (isNet || !isNew ? 'Billing  Meter' : 'AMR Meter', col2),
      (isNet || !isNew ? 'Backup  Meter' : 'Existing Meter', col3),
    ];
    SealValues? seal(String spot, String role) => b.seals[sealKey(spot, role)];
    bool hasSeals(String role) =>
        sealSpots.any((sp) => !(seal(sp.code, role)?.isEmpty ?? true));
    final widths = fit([56, 40, 62, 52, 40, 76, 40, 76], _w - 2 * thick);
    GCell h(String s, {int span = 1}) =>
        GCell(s, span: span, bold: true, align: Al.center, size: 7.6);
    GCell v(String s) => GCell(s, align: Al.center, size: 9);
    final rows = <GRow>[
      GRow([
        GCell('', noBottom: true, widget: pw.SizedBox()),
        h(groups[0].$1, span: 3),
        h(groups[1].$1, span: 2),
        h(groups[2].$1, span: 2),
      ], height: 12),
      GRow([
        h('SPOT'),
        h('M&T\nSeals'),
        h('Postal Orders'),
        h('AMR Meter'),
        h('M&T\nSeals'),
        h('Postal Orders'),
        h('M&T\nSeals'),
        h('Postal Orders'),
      ], height: 19),
      for (final sp in sealSpots)
        GRow([
          GCell(
            sp.label
                .toUpperCase()
                .replaceAll('GLASS', 'Glass')
                .replaceAll('T/FORMER', 'T/Former'),
            bold: true,
            size: 7.2,
          ),
          v(seal(sp.code, groups[0].$2)?.mtSeal ?? ''),
          v(seal(sp.code, groups[0].$2)?.postalOrder ?? ''),
          v(''),
          v(seal(sp.code, groups[1].$2)?.mtSeal ?? ''),
          v(seal(sp.code, groups[1].$2)?.postalOrder ?? ''),
          v(seal(sp.code, groups[2].$2)?.mtSeal ?? ''),
          v(seal(sp.code, groups[2].$2)?.postalOrder ?? ''),
        ], height: 16),
    ];
    final last = rows.length - 1;
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _sectionTitle('D', 'SEALING STATUS / RECORD'),
        formGrid(
          widths: widths,
          rows: rows,
          strikes: [
            if (!hasSeals(groups[0].$2)) Strike(1, 3, 2, last),
            if (!hasSeals(groups[1].$2)) Strike(4, 5, 2, last),
            if (!hasSeals(groups[2].$2)) Strike(6, 7, 2, last),
          ],
        ),
      ],
    );
  }

  // ------------------------------------------------------------------ E

  pw.Widget _line(List<pw.Widget> children) => pw.Padding(
    padding: const pw.EdgeInsets.only(top: 4),
    child: pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: children,
    ),
  );

  pw.Widget _label(String s) => pw.Text(s, style: ts(8.6, b: true, u: true));

  /// Ruled lines with [text] written on them; struck through when empty.
  pw.Widget _ruled(String text, int count, {int maxChars = 118}) {
    final lines = wrapText(clean(text), maxChars);
    final n = lines.length > count ? lines.length : count;
    final block = pw.Column(
      children: [
        for (var i = 0; i < n; i++)
          pw.Container(
            height: 15,
            alignment: pw.Alignment.bottomLeft,
            padding: const pw.EdgeInsets.only(left: 4, bottom: 1),
            decoration: const pw.BoxDecoration(
              border: pw.Border(bottom: pw.BorderSide(width: 0.5)),
            ),
            child: pw.Text(i < lines.length ? lines[i] : '', style: ts(9.5)),
          ),
      ],
    );
    return struck(block, text.trim().isEmpty);
  }

  pw.Widget _sectionE() {
    final r = b.report;
    final title = _sectionTitle(
      'E',
      'ANY DISCREPANCY IF OBSERVED WITH REMARKS AND RECOMMENDATIONS',
    );
    if (isNew) {
      return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.stretch,
        children: [
          title,
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 30),
            child: _newConnectionParagraph(),
          ),
          pw.SizedBox(height: 2),
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 30),
            child: _ruled('', 3),
          ),
        ],
      );
    }
    final checked = r.checkedLoadKw.trim();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.stretch,
      children: [
        title,
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 30),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              _line([
                _label('A/C No.'),
                blank(
                  '${a('account_no')}${a('tariff').isEmpty ? '' : '/${a('tariff')}'}',
                  width: 170,
                ),
                pw.SizedBox(width: 10),
                _label('Name :'),
                blank('${a('name')} $subDivision'.trim()),
              ]),
              _line([
                _label('Site Visited on Dated:'),
                blank(fmtDate(r.visitDate), width: 80),
                pw.SizedBox(width: 6),
                _label('MSB Status:'),
                blank(r.msbStatus, width: 110),
                pw.SizedBox(width: 6),
                _label('Postal orders:'),
                blank(r.postalOrdersText),
              ]),
              _line([
                _label('Checked on H/ load/R/load (Import Load) ='),
                blank(checked.isEmpty ? '' : '$checked Kw', width: 120),
                _label(',(Export Load)='),
                blank(r.exportLoadText),
              ]),
              _line([
                _label('Accuracy :'),
                blank(r.accuracyText, align: pw.Alignment.bottomLeft),
              ]),
              _line([
                _label('TransformerLTBushes :'),
                blank(r.transformerLtBushes, align: pw.Alignment.bottomLeft),
              ]),
              pw.SizedBox(height: 2),
              _ruled(r.remarks, 9),
            ],
          ),
        ),
      ],
    );
  }

  /// NEW_CONNECTION paragraph with the filled-in values underlined. If the
  /// officer edited the paragraph by hand, that text is printed as typed.
  pw.Widget _newConnectionParagraph() {
    final r = b.report;
    final auto = newConnectionRemarks(b);
    final edited =
        r.remarks.trim().isNotEmpty && r.remarks.trim() != auto.trim();
    if (edited) {
      return pw.Text(
        clean(r.remarks),
        textAlign: pw.TextAlign.justify,
        style: ts(9).copyWith(lineSpacing: 4),
      );
    }
    final values = newConnectionValues(b);
    final spans = <pw.TextSpan>[];
    final re = RegExp(r'\{(\w+)\}');
    var pos = 0;
    for (final m in re.allMatches(newConnectionRemarksTemplate)) {
      spans.add(
        pw.TextSpan(
          text: newConnectionRemarksTemplate.substring(pos, m.start),
          style: ts(8.8, b: true),
        ),
      );
      final v = (values[m[1]!] ?? '').trim();
      spans.add(
        pw.TextSpan(
          text: clean(v.isEmpty ? '________' : ' $v '),
          style: ts(9.6, u: true),
        ),
      );
      pos = m.end;
    }
    spans.add(
      pw.TextSpan(
        text: newConnectionRemarksTemplate.substring(pos),
        style: ts(8.8, b: true),
      ),
    );
    return pw.RichText(
      textAlign: pw.TextAlign.justify,
      text: pw.TextSpan(
        children: spans,
        style: ts(8.8).copyWith(lineSpacing: 5),
      ),
    );
  }

  // ------------------------------------------------------------------ F

  String _engr(String name) {
    final n = name.trim().replaceFirst(
      RegExp(r'^engr\.?\s*', caseSensitive: false),
      '',
    );
    return 'Engr. $n';
  }

  pw.Widget _sectionF() {
    final r = b.report;
    final widths = fit([18, 230, 290], _w - 2 * thick);
    final xen = s[SettingKeys.xenMt] ?? '';
    final ti = s[SettingKeys.testInspector] ?? '';
    final none = r.signerExenOp.trim().isEmpty && r.signerSdoOp.trim().isEmpty;
    pw.Widget right(String fixed, String value) => pw.RichText(
      text: pw.TextSpan(
        children: [
          pw.TextSpan(text: fixed, style: ts(8.8, b: true)),
          pw.TextSpan(
            text: clean(value.isEmpty ? '______________' : ' $value '),
            style: ts(9.5, u: true),
          ),
        ],
      ),
    );
    final rows = [
      GRow([
        const GCell('1', bold: true, align: Al.center, size: 8.5),
        GCell(_engr(xen), size: 9),
        GCell(
          'Executive Engineer M&T MEPCO Circle $circle',
          bold: true,
          size: 8.8,
        ),
      ], height: 15),
      GRow([
        const GCell('2', bold: true, align: Al.center, size: 8.5),
        GCell(none ? 'Engr.' : _engr(r.signerExenOp), size: 9),
        GCell(
          '',
          widget: right(
            'Executive Engineer (OP) MEPCO Div.',
            none ? '' : division,
          ),
        ),
      ], height: 15),
      GRow([
        const GCell('3', bold: true, align: Al.center, size: 8.5),
        GCell(none ? 'Engr.' : _engr(r.signerSdoOp), size: 9),
        GCell(
          '',
          widget: right(
            'Sub Divisional Officer (OP) S/Div.',
            none ? '' : subDivision,
          ),
        ),
      ], height: 15),
      GRow([
        const GCell('4', bold: true, align: Al.center, size: 8.5),
        GCell(
          'Work of installation is supervised by $ti Test Inspector  M&T Circle $circle.',
          span: 2,
          size: 8.8,
        ),
      ], height: 15),
    ];
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.only(left: 8, bottom: 2),
          child: pw.Row(
            children: [
              pw.SizedBox(
                width: 28,
                child: pw.Text('F).', style: ts(9, b: true)),
              ),
              pw.Text(
                'Postal Orders Signed by (in case of MCO / New Installation)',
                style: ts(9, b: true),
              ),
            ],
          ),
        ),
        formGrid(
          widths: widths,
          rows: rows,
          strikes: [if (none) const Strike(1, 2, 0, 2)],
        ),
      ],
    );
  }

  pw.Widget _ccList() {
    final lines = (s[SettingKeys.ccList] ?? '')
        .split('\n')
        .map((l) => l.trim())
        .where((l) => l.isNotEmpty)
        .toList();
    if (lines.isEmpty) return pw.SizedBox();
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('C.C To', style: ts(9.5, b: true)),
        for (var i = 0; i < lines.length; i++)
          pw.Padding(
            padding: const pw.EdgeInsets.only(left: 22, top: 1),
            child: pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.SizedBox(
                  width: 16,
                  child: pw.Text('${i + 1}.', style: ts(9.2)),
                ),
                pw.Expanded(
                  child: pw.Text(
                    clean(fillTemplate(lines[i], {'division': division})),
                    style: ts(9.2),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
