import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
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
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        for (final side in loadSides) ...[
          SectionTitle(side == 'import' ? 'Import load' : 'Export load'),
          for (final ph in phases)
            _PhaseRow(c: c, side: side, phase: ph, sc: sc),
          Text(
            'Total: ${fmtNum(sc.sideTotal(side))} KW',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        const SectionTitle('Results'),
        _ResultLine(
          'Check load (${c.settings['check_load_method'] == 'sum_per_phase' ? 'sum' : 'average'} of phases)',
          '${fmtNum(computeSectionC(b.copyForCalc(checkLoadOverride: ''), c.settings).importCheckLoad)} KW',
        ),
        AppField(
          label: 'Check load override (KW) — empty = computed',
          value: r.checkLoadOverride,
          numeric: true,
          onChanged: (v) =>
              _setReport(c, (r) => r.copyWith(checkLoadOverride: v)),
        ),
        for (final col in b.columns.where((x) => x.isUsed)) ...[
          _ResultLine(
            '${t.column(col.role).label} instant KW',
            sc.instantImport[col.role] == null
                ? '—'
                : '${fmtNum(sc.instantImport[col.role])} KW, error ${fmtNum(sc.errorImport[col.role])} %',
          ),
          if (t.isNet && sc.instantExport[col.role] != null)
            _ResultLine(
              '${t.column(col.role).label} export instant KW',
              '${fmtNum(sc.instantExport[col.role])} KW, error ${fmtNum(sc.errorExport[col.role])} %',
            ),
        ],
        AppField(
          label: '% error override — empty = computed',
          value: r.percentErrorOverride,
          numeric: true,
          onChanged: (v) =>
              _setReport(c, (r) => r.copyWith(percentErrorOverride: v)),
        ),
        _ResultLine(
          'Within permissible limits',
          sc.limitText.isEmpty && r.withinLimitOverride.isEmpty
              ? 'No limit set in Settings — choose below'
              : (sc.within == null ? '—' : (sc.within! ? 'Yes' : 'No')),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: '', label: Text('Auto')),
              ButtonSegment(value: 'yes', label: Text('Yes')),
              ButtonSegment(value: 'no', label: Text('No')),
            ],
            selected: {r.withinLimitOverride},
            onSelectionChanged: (s) =>
                _setReport(c, (r) => r.copyWith(withinLimitOverride: s.first)),
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

class _ResultLine extends StatelessWidget {
  const _ResultLine(this.label, this.value);
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Text(label)),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    ),
  );
}

class _PhaseRow extends StatelessWidget {
  const _PhaseRow({
    required this.c,
    required this.side,
    required this.phase,
    required this.sc,
  });
  final WizardController c;
  final String side;
  final String phase;
  final SectionC sc;

  @override
  Widget build(BuildContext context) {
    final l = c.bundle.load(side, phase);
    final kw = sc.phaseKw[phaseKey(side, phase)];
    Widget f(String label, String v, void Function(String) set) => SizedBox(
      width: 110,
      child: AppField(
        label: label,
        value: v,
        numeric: true,
        onChanged: (x) {
          set(x);
          c.changed();
        },
      ),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Wrap(
        spacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          SizedBox(
            width: 24,
            child: Text(
              phase,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          f('Volts', l.volts, (x) => l.volts = x),
          f('Amps', l.amps, (x) => l.amps = x),
          f('P.F', l.pf, (x) => l.pf = x),
          f('KW (override)', l.kwOverride, (x) => l.kwOverride = x),
          Text(
            '= ${fmtNum(kw)} KW',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
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
                'Leave empty if no seals. An empty block is struck through.',
                style: TextStyle(color: Colors.black54),
              ),
            ),
            TextButton.icon(
              onPressed: () => _fillRange(context),
              icon: const Icon(Icons.auto_fix_high),
              label: const Text('Fill a range'),
            ),
          ],
        ),
        for (final spot in sealSpots) ...[
          SectionTitle(spot.label.isEmpty ? 'MSB (2nd row)' : spot.label),
          for (final col in cols)
            Row(
              children: [
                if (cols.length > 1)
                  SizedBox(
                    width: 90,
                    child: Text(
                      b.template.column(col.role).label,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                Expanded(
                  child: AppField(
                    key: ValueKey(
                      '${spot.code}-${col.role}-m-${b.seal(spot.code, col.role).mtSeal}',
                    ),
                    label: 'M&T Seal',
                    value: b.seal(spot.code, col.role).mtSeal,
                    onChanged: (v) {
                      b.seal(spot.code, col.role).mtSeal = v;
                      c.changed();
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: AppField(
                    key: ValueKey(
                      '${spot.code}-${col.role}-p-${b.seal(spot.code, col.role).postalOrder}',
                    ),
                    label: 'Postal Order',
                    value: b.seal(spot.code, col.role).postalOrder,
                    onChanged: (v) {
                      b.seal(spot.code, col.role).postalOrder = v;
                      c.changed();
                    },
                  ),
                ),
              ],
            ),
        ],
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
        const Text(
          'Postal orders signed by (printed in section F):',
          style: TextStyle(color: Colors.black54),
        ),
        AppField(
          label: '1. EXEN (OP)',
          value: r.signerExenOp,
          hint: 'e.g. Engr. Name (EXEN OP CTN)',
          onChanged: (v) => _setReport(c, (r) => r.copyWith(signerExenOp: v)),
        ),
        AppField(
          label: '2. SDO (OP)',
          value: r.signerSdoOp,
          hint: 'e.g. Engr. Name (SDO OP S/Town)',
          onChanged: (v) => _setReport(c, (r) => r.copyWith(signerSdoOp: v)),
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
        Text(
          '${b.template.shortName} — ${b.sectionA['name'] ?? ''}',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          'A/C ${b.sectionA['account_no'] ?? ''}  •  Visit ${fmtDate(b.report.visitDate)}  •  Memo ${b.report.memoNo}',
        ),
        const SizedBox(height: 12),
        if (warnings.isEmpty)
          const Card(
            child: ListTile(
              leading: Icon(Icons.check_circle, color: okColor),
              title: Text('No warnings'),
            ),
          )
        else ...[
          Text(
            '${warnings.length} warning(s) — you can still mark the report final:',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          for (final w in warnings)
            Card(
              color: warningColor,
              child: ListTile(
                leading: const Icon(Icons.warning_amber, color: Colors.brown),
                title: Text(w.message),
                subtitle: Text(w.section),
                trailing: _sectionStep.containsKey(w.section)
                    ? const Icon(Icons.chevron_right)
                    : null,
                onTap: _sectionStep.containsKey(w.section)
                    ? () => onGoTo(_sectionStep[w.section]!)
                    : null,
              ),
            ),
        ],
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
