import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/calculations.dart';
import '../../domain/formatters.dart';
import '../../domain/models.dart';
import '../../domain/report_calc.dart';
import '../../domain/report_templates.dart';
import '../../domain/seal_range.dart';
import 'wizard_controller.dart';

void _setReport(WizardController c, Report Function(Report r) f) {
  c.bundle.report = f(c.bundle.report);
  c.changed();
}

// ======================================================================= C

class SectionCStep extends StatelessWidget {
  const SectionCStep({super.key, required this.c});
  final WizardController c;

  @override
  Widget build(BuildContext context) {
    final b = c.bundle;
    final t = b.template;
    final sc = c.sectionC;
    final r = b.report;
    final method = c.settings['check_load_method'] == 'sum_per_phase'
        ? 'sum'
        : 'average';
    final computedLoad = computeSectionC(
      b.copyForCalc(checkLoadOverride: ''),
      c.settings,
    ).importCheckLoad;
    final within = sc.limitText.isEmpty && r.withinLimitOverride.isEmpty
        ? 'Set a limit in Settings, or choose below'
        : (sc.within == null ? '—' : (sc.within! ? 'YES' : 'NO'));

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final side in loadSides)
          FormSection(
            title: side == 'import' ? 'Import load' : 'Export load',
            child: _LoadTable(c: c, side: side, sc: sc),
          ),
        FormSection(
          title: 'Results',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InfoTable(labelWidth: 150, [
                (
                  'Check load ($method of phases)',
                  computedLoad == null ? '' : '${fmtNum(computedLoad)} KW',
                ),
                if (r.checkLoadOverride.trim().isNotEmpty)
                  ('Check load used', '${r.checkLoadOverride} KW (override)'),
                for (final col in b.columns.where((x) => x.isUsed)) ...[
                  (
                    '${t.column(col.role).label} instant KW',
                    sc.instantImport[col.role] == null
                        ? '—'
                        : '${fmtNum(sc.instantImport[col.role])} KW  •  '
                              'error ${fmtNum(sc.errorImport[col.role])} %',
                  ),
                  if (t.isNet && sc.instantExport[col.role] != null)
                    (
                      '${t.column(col.role).label} export KW',
                      '${fmtNum(sc.instantExport[col.role])} KW  •  '
                          'error ${fmtNum(sc.errorExport[col.role])} %',
                    ),
                ],
                ('Within permissible limits', within),
              ]),
              const SizedBox(height: 14),
              const Text(
                'OVERRIDES (leave empty to use the calculated values)',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                  color: AppColors.muted,
                ),
              ),
              ResponsiveFields(
                children: [
                  AppField(
                    label: 'Check load (KW)',
                    value: r.checkLoadOverride,
                    numeric: true,
                    onChanged: (v) =>
                        _setReport(c, (r) => r.copyWith(checkLoadOverride: v)),
                  ),
                  AppField(
                    label: '% error',
                    value: r.percentErrorOverride,
                    numeric: true,
                    onChanged: (v) => _setReport(
                      c,
                      (r) => r.copyWith(percentErrorOverride: v),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 6, bottom: 6),
                child: Text('Within permissible limits'),
              ),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: '', label: Text('Auto')),
                  ButtonSegment(value: 'yes', label: Text('Yes')),
                  ButtonSegment(value: 'no', label: Text('No')),
                ],
                selected: {r.withinLimitOverride},
                onSelectionChanged: (s) => _setReport(
                  c,
                  (r) => r.copyWith(withinLimitOverride: s.first),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

extension on ReportBundle {
  /// A shallow copy used to compute values without an override.
  ReportBundle copyForCalc({required String checkLoadOverride}) => ReportBundle(
    report: report.copyWith(checkLoadOverride: checkLoadOverride),
    consumer: consumer,
    sectionA: sectionA,
    columns: columns,
    phaseLoads: phaseLoads,
    seals: seals,
  );
}

/// Phase table like the paper form: Phase | Volts | Amps | P.F | K.W.
/// The K.W cell shows the calculated value in grey; typing a value overrides it.
class _LoadTable extends StatelessWidget {
  const _LoadTable({required this.c, required this.side, required this.sc});
  final WizardController c;
  final String side;
  final SectionC sc;

  @override
  Widget build(BuildContext context) {
    Widget head(String t) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        t,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontWeight: FontWeight.w800,
          color: AppColors.navy,
          fontSize: 13,
        ),
      ),
    );
    Widget pad(Widget w) => Padding(padding: const EdgeInsets.all(3), child: w);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Table(
          border: TableBorder.all(color: AppColors.line),
          columnWidths: const {
            0: FixedColumnWidth(40),
            4: FlexColumnWidth(1.35),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              decoration: const BoxDecoration(color: AppColors.navyLight),
              children: [
                head('Ph'),
                head('Volts'),
                head('Amps'),
                head('P.F'),
                head('K.W'),
              ],
            ),
            for (final ph in phases)
              () {
                final l = c.bundle.load(side, ph);
                final kw = phaseKw(l.volts, l.amps, l.pf);
                Widget f(String v, void Function(String) set, {String? hint}) =>
                    pad(
                      CompactField(
                        value: v,
                        hint: hint,
                        onChanged: (x) {
                          set(x);
                          c.changed();
                        },
                      ),
                    );
                return TableRow(
                  children: [
                    Center(
                      child: Text(
                        ph,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 17,
                          color: AppColors.navy,
                        ),
                      ),
                    ),
                    f(l.volts, (x) => l.volts = x),
                    f(l.amps, (x) => l.amps = x),
                    f(l.pf, (x) => l.pf = x),
                    f(
                      l.kwOverride,
                      (x) => l.kwOverride = x,
                      hint: kw == null ? '' : fmtNum(kw),
                    ),
                  ],
                );
              }(),
            TableRow(
              decoration: const BoxDecoration(color: AppColors.paper),
              children: [
                head('Total'),
                const SizedBox(),
                const SizedBox(),
                const SizedBox(),
                head(
                  sc.sideTotal(side) == null ? '' : fmtNum(sc.sideTotal(side)),
                ),
              ],
            ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 6),
          child: Text(
            'K.W = √3 × V × A × P.F ÷ 1000 (grey). Type in K.W to override.',
            style: TextStyle(fontSize: 12, color: AppColors.muted),
          ),
        ),
      ],
    );
  }
}

// ======================================================================= D

class SectionDStep extends StatelessWidget {
  const SectionDStep({super.key, required this.c});
  final WizardController c;

  Future<void> _fillRange(BuildContext context) async {
    final b = c.bundle;
    final cols = b.columns.where((x) => !x.notApplicable).toList();
    if (cols.isEmpty) return;
    var role = cols.first.role;
    var postal = true;
    var first = '';
    final counts = {
      'TOU_MC': 1,
      'TOU_TC': 1,
      'MSB': 2,
      'MSB_2': 2,
      'MSB_GLASS': 2,
      'TFORMER': 4,
    };
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setD) => AlertDialog(
          title: const Text('Fill a range of serials'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppField(
                  label: 'First serial (e.g. TA-900001)',
                  value: first,
                  onChanged: (v) => setD(() => first = v),
                ),
                DropdownButtonFormField<String>(
                  initialValue: role,
                  decoration: const InputDecoration(labelText: 'Column'),
                  items: [
                    for (final col in cols)
                      DropdownMenuItem(
                        value: col.role,
                        child: Text(b.template.column(col.role).label),
                      ),
                  ],
                  onChanged: (v) => setD(() => role = v!),
                ),
                SwitchListTile(
                  title: Text(postal ? 'Postal orders' : 'M&T seals'),
                  value: postal,
                  onChanged: (v) => setD(() => postal = v),
                ),
                const Text('How many serials for each spot (0 = skip):'),
                for (final s in sealSpots)
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          s.label.isEmpty ? 'MSB (2nd row)' : s.label,
                        ),
                      ),
                      IconButton(
                        onPressed: () => setD(
                          () => counts[s.code] = (counts[s.code]! - 1).clamp(
                            0,
                            20,
                          ),
                        ),
                        icon: const Icon(Icons.remove),
                      ),
                      Text('${counts[s.code]}'),
                      IconButton(
                        onPressed: () => setD(
                          () => counts[s.code] = (counts[s.code]! + 1).clamp(
                            0,
                            20,
                          ),
                        ),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                const SizedBox(height: 8),
                Text(
                  fillSerials(
                    first,
                    counts,
                  ).entries.map((e) => '${e.key}: ${e.value}').join('\n'),
                  style: const TextStyle(color: Colors.black54),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Fill'),
            ),
          ],
        ),
      ),
    );
    if (ok != true) return;
    final filled = fillSerials(first, counts);
    if (filled.isEmpty) {
      if (context.mounted) {
        showSnack(context, 'The serial must end with digits.');
      }
      return;
    }
    filled.forEach((spot, text) {
      final s = b.seal(spot, role);
      if (postal) {
        s.postalOrder = text;
      } else {
        s.mtSeal = text;
      }
    });
    c.changed();
  }

  @override
  Widget build(BuildContext context) {
    final b = c.bundle;
    final cols = b.columns.where((x) => !x.notApplicable).toList();
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Leave empty if no seals. An empty block is struck through on the printout.',
                style: TextStyle(color: AppColors.muted),
              ),
            ),
            const SizedBox(width: 8),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(minimumSize: const Size(0, 44)),
              onPressed: () => _fillRange(context),
              icon: const Icon(Icons.auto_fix_high, size: 18),
              label: const Text('Fill a range'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final col in cols)
          FormSection(
            title: b.template.column(col.role).label,
            child: Table(
              border: TableBorder.all(color: AppColors.line),
              columnWidths: const {0: FixedColumnWidth(92)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(
                  decoration: const BoxDecoration(color: AppColors.navyLight),
                  children: [
                    for (final h in ['Seal at', 'M&T Seal', 'Postal Order'])
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 6,
                        ),
                        child: Text(
                          h,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            color: AppColors.navy,
                            fontSize: 13,
                          ),
                        ),
                      ),
                  ],
                ),
                for (final spot in sealSpots)
                  TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          spot.label.isEmpty ? 'MSB (2)' : spot.label,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: CompactField(
                          value: b.seal(spot.code, col.role).mtSeal,
                          numeric: false,
                          textAlign: TextAlign.start,
                          onChanged: (v) {
                            b.seal(spot.code, col.role).mtSeal = v;
                            c.changed();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(3),
                        child: CompactField(
                          value: b.seal(spot.code, col.role).postalOrder,
                          numeric: false,
                          textAlign: TextAlign.start,
                          onChanged: (v) {
                            b.seal(spot.code, col.role).postalOrder = v;
                            c.changed();
                          },
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

// ======================================================================= E

class SectionEStep extends StatefulWidget {
  const SectionEStep({super.key, required this.c});
  final WizardController c;

  @override
  State<SectionEStep> createState() => _SectionEStepState();
}

class _SectionEStepState extends State<SectionEStep> {
  @override
  void initState() {
    super.initState();
    final c = widget.c;
    final r = c.bundle.report;
    var changed = false;
    if (r.checkedLoadKw.trim().isEmpty && c.sectionC.importCheckLoad != null) {
      c.bundle.report = c.bundle.report.copyWith(
        checkedLoadKw: fmtNum(c.sectionC.importCheckLoad),
      );
      changed = true;
    }
    if (c.bundle.template.isNewConnection &&
        c.bundle.report.remarks.trim().isEmpty) {
      c.bundle.report = c.bundle.report.copyWith(
        remarks: newConnectionRemarks(c.bundle),
      );
      changed = true;
    }
    if (changed) {
      WidgetsBinding.instance.addPostFrameCallback((_) => c.changed());
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    final r = c.bundle.report;
    final computed = c.sectionC.importCheckLoad;
    final isNew = c.bundle.template.isNewConnection;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ResponsiveFields(
          children: [
            AppField(
              label: 'MSB status',
              value: r.msbStatus,
              hint: 'e.g. Welded',
              onChanged: (v) => _setReport(c, (r) => r.copyWith(msbStatus: v)),
            ),
            AppField(
              label: 'Postal orders',
              value: r.postalOrdersText,
              onChanged: (v) =>
                  _setReport(c, (r) => r.copyWith(postalOrdersText: v)),
            ),
            AppField(
              key: ValueKey('checked-${r.checkedLoadKw}'),
              label: 'Checked load (KW)',
              value: r.checkedLoadKw,
              numeric: true,
              helper: computed == null
                  ? null
                  : 'From section C: ${fmtNum(computed)}',
              onChanged: (v) =>
                  _setReport(c, (r) => r.copyWith(checkedLoadKw: v)),
            ),
            AppField(
              label: 'Export load',
              value: r.exportLoadText,
              onChanged: (v) =>
                  _setReport(c, (r) => r.copyWith(exportLoadText: v)),
            ),
            AppField(
              label: 'Accuracy',
              value: r.accuracyText,
              hint: 'e.g. OK',
              onChanged: (v) =>
                  _setReport(c, (r) => r.copyWith(accuracyText: v)),
            ),
            AppField(
              label: 'Transformer LT bushes',
              value: r.transformerLtBushes,
              hint: 'e.g. Sealed',
              onChanged: (v) =>
                  _setReport(c, (r) => r.copyWith(transformerLtBushes: v)),
            ),
          ],
        ),
        if (computed != null)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(
                () => _setReport(
                  c,
                  (r) => r.copyWith(checkedLoadKw: fmtNum(computed)),
                ),
              ),
              child: Text('Use computed check load ${fmtNum(computed)} KW'),
            ),
          ),
        SectionTitle(
          isNew
              ? 'Remarks paragraph'
              : 'Discrepancy / remarks / recommendations',
        ),
        AppField(
          key: ValueKey('remarks-${r.remarks.hashCode}-${r.checkedLoadKw}'),
          label: 'Remarks',
          value: r.remarks,
          maxLines: 12,
          onChanged: (v) {
            c.bundle.report = c.bundle.report.copyWith(remarks: v);
            c.changed();
          },
        ),
        if (isNew)
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: () async {
                final ok = await confirm(
                  context,
                  'Refill paragraph?',
                  'Replace the paragraph with the template filled from this report?',
                );
                if (!ok) return;
                setState(
                  () => _setReport(
                    c,
                    (r) => r.copyWith(remarks: newConnectionRemarks(c.bundle)),
                  ),
                );
              },
              icon: const Icon(Icons.refresh),
              label: const Text('Fill from template'),
            ),
          ),
      ],
    );
  }
}

// ======================================================================= F

class SectionFStep extends StatelessWidget {
  const SectionFStep({super.key, required this.c});
  final WizardController c;

  @override
  Widget build(BuildContext context) {
    final r = c.bundle.report;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FormSection(
          title: 'Postal orders signed by',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppField(
                label: '1. EXEN (OP)',
                value: r.signerExenOp,
                hint: 'e.g. Engr. Name (EXEN OP CTN)',
                onChanged: (v) =>
                    _setReport(c, (r) => r.copyWith(signerExenOp: v)),
              ),
              AppField(
                label: '2. SDO (OP)',
                value: r.signerSdoOp,
                hint: 'e.g. Engr. Name (SDO OP S/Town)',
                onChanged: (v) =>
                    _setReport(c, (r) => r.copyWith(signerSdoOp: v)),
              ),
              AppField(
                label: '3.',
                value: r.signer3,
                onChanged: (v) => _setReport(c, (r) => r.copyWith(signer3: v)),
              ),
              AppField(
                label: '4.',
                value: r.signer4,
                onChanged: (v) => _setReport(c, (r) => r.copyWith(signer4: v)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ======================================================================= review

class ReviewStep extends StatelessWidget {
  const ReviewStep({super.key, required this.c, required this.onGoTo});
  final WizardController c;
  final Future<void> Function(int step) onGoTo;

  static const _sectionStep = {
    'Header': 0,
    'Section A': 1,
    'Section B': 2,
    'Readings': 3,
    'Section C': 4,
  };

  @override
  Widget build(BuildContext context) {
    final warnings = c.warnings;
    final b = c.bundle;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FormSection(
          title: 'Report summary',
          child: InfoTable([
            ('Report', b.template.shortName),
            ('M/S', b.sectionA['name'] ?? ''),
            ('A/C No', b.sectionA['account_no'] ?? ''),
            ('Memo No', b.report.memoNo.isEmpty ? '—' : b.report.memoNo),
            ('Visit date', fmtDate(b.report.visitDate)),
            ('Status', 'DRAFT'),
          ]),
        ),
        FormSection(
          title: warnings.isEmpty
              ? 'Checks'
              : 'Checks — ${warnings.length} warning(s)',
          child: warnings.isEmpty
              ? const Row(
                  children: [
                    Icon(Icons.check_circle, color: okColor),
                    SizedBox(width: 10),
                    Text(
                      'All checks passed.',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 8),
                      child: Text(
                        'Warnings never block saving. You can still mark the report final.',
                        style: TextStyle(color: AppColors.muted),
                      ),
                    ),
                    for (final w in warnings)
                      Container(
                        margin: const EdgeInsets.only(bottom: 6),
                        decoration: BoxDecoration(
                          color: warningColor,
                          borderRadius: BorderRadius.circular(4),
                          border: const Border(
                            left: BorderSide(color: warningBorder, width: 4),
                          ),
                        ),
                        child: ListTile(
                          dense: true,
                          leading: const Icon(
                            Icons.warning_amber,
                            color: Color(0xFF7A5C00),
                          ),
                          title: Text(
                            w.message,
                            style: const TextStyle(fontSize: 14),
                          ),
                          subtitle: Text(w.section.toUpperCase()),
                          trailing: _sectionStep.containsKey(w.section)
                              ? const Icon(Icons.chevron_right)
                              : null,
                          onTap: _sectionStep.containsKey(w.section)
                              ? () => onGoTo(_sectionStep[w.section]!)
                              : null,
                        ),
                      ),
                  ],
                ),
        ),
        const SizedBox(height: 16),
        FilledButton.icon(
          onPressed: () async {
            await c.save();
            if (context.mounted) context.push('/reports/${b.report.id}/pdf');
          },
          icon: const Icon(Icons.print),
          label: const Text('Print / PDF'),
        ),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: () async {
            final ok = await confirm(
              context,
              'Mark final?',
              'A final report cannot be edited. You can still duplicate it as a new draft.',
              ok: 'Mark final',
              cancel: 'Cancel',
            );
            if (!ok) return;
            await c.markFinal();
            if (context.mounted) {
              context.pushReplacement('/reports/${b.report.id}');
            }
          },
          icon: const Icon(Icons.verified),
          label: const Text('Mark final'),
        ),
        const SizedBox(height: 32),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () async {
              final ok = await confirm(
                context,
                'Delete draft?',
                'This draft will be deleted.',
                ok: 'Delete',
                cancel: 'Cancel',
              );
              if (!ok) return;
              await c.deleteReport();
              if (context.mounted) context.pop();
            },
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete draft'),
          ),
        ),
      ],
    );
  }
}
