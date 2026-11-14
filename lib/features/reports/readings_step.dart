import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/field_focus.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../domain/calculations.dart';
import '../../domain/formatters.dart';
import '../../domain/models.dart';
import '../../domain/report_calc.dart';
import '../../domain/report_templates.dart';
import '../../domain/validators.dart';
import 'wizard_controller.dart';

/// Readings grid. Phone: one meter per tab. Tablet: all columns side by side.
class ReadingsStep extends StatefulWidget {
  const ReadingsStep({super.key, required this.c});
  final WizardController c;

  @override
  State<ReadingsStep> createState() => _ReadingsStepState();
}

class _ReadingsStepState extends State<ReadingsStep> {
  @override
  void initState() {
    super.initState();
    // Prefill the reading date with the visit date.
    final b = widget.c.bundle;
    final hasDate = b.template.params.any((p) => p.code == 'date');
    var filled = false;
    if (hasDate && b.report.visitDate != null) {
      for (final col in _columns) {
        if ((col.readings['date'] ?? '').isEmpty) {
          col.readings['date'] = fmtDate(b.report.visitDate);
          filled = true;
        }
      }
    }
    if (filled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => widget.c.changed());
    }
  }

  /// Opens the tab of the meter a tapped warning points at.
  int _tabFor(List<ColumnSlot> cols) {
    final t = widget.c.focus.target;
    if (t == null || !t.startsWith('r:')) return 0;
    final role = t.split(':')[1];
    final i = cols.indexWhere((c) => c.role == role);
    return i < 0 ? 0 : i;
  }

  List<ColumnSlot> get _columns =>
      widget.c.bundle.columns.where((c) => !c.notApplicable).toList();

  @override
  Widget build(BuildContext context) {
    final c = widget.c;
    final t = c.bundle.template;
    final cols = _columns;
    if (cols.isEmpty) {
      return const Center(
        child: Text('All columns are "Not applicable". Change this in step B.'),
      );
    }
    final warnings = <String>[
      for (final col in cols) ...[
        ...totalWarnings(t, col).map((w) => w.message),
        ...regressionWarnings(
          t,
          col,
          c.previous[col.role]?.values,
        ).map((w) => w.message),
        ...formatWarnings(t, col).map((w) => w.message),
      ],
    ];

    if (isWide(context)) {
      return ListView(
        padding: const EdgeInsets.all(16),
        scrollCacheExtent: const ScrollCacheExtent.pixels(100000),
        children: [
          WarningBanner(warnings),
          _WideGrid(c: c, columns: cols),
        ],
      );
    }
    return DefaultTabController(
      length: cols.length,
      initialIndex: _tabFor(cols),
      child: Column(
        children: [
          TabBar(
            isScrollable: cols.length > 2,
            tabs: [
              for (final col in cols)
                Tab(
                  text:
                      '${t.column(col.role).label}${col.meter == null ? '' : '\n${col.meter!.mfgNo}'}',
                ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                for (final col in cols)
                  ListView(
                    padding: const EdgeInsets.all(16),
                    scrollCacheExtent: const ScrollCacheExtent.pixels(100000),
                    children: [
                      WarningBanner([
                        ...totalWarnings(t, col).map((w) => w.message),
                        ...regressionWarnings(
                          t,
                          col,
                          c.previous[col.role]?.values,
                        ).map((w) => w.message),
                      ]),
                      if (c.previous[col.role] != null)
                        Text(
                          'Grey values: last visit ${fmtDate(c.previous[col.role]!.report.visitDate)}',
                          style: const TextStyle(
                            color: AppColors.muted,
                            fontSize: 13,
                          ),
                        ),
                      _MeterCaption(slot: col, template: t),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: AppColors.line),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            for (final p in t.params)
                              ReadingCell(
                                c: c,
                                slot: col,
                                param: p,
                                showLabel: true,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WideGrid extends StatelessWidget {
  const _WideGrid({required this.c, required this.columns});
  final WizardController c;
  final List<ColumnSlot> columns;

  @override
  Widget build(BuildContext context) {
    final t = c.bundle.template;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppColors.line),
      ),
      clipBehavior: Clip.antiAlias,
      child: Table(
        border: const TableBorder(
          horizontalInside: BorderSide(color: AppColors.line),
          verticalInside: BorderSide(color: AppColors.line),
        ),
        columnWidths: {
          0: const FixedColumnWidth(240),
          for (var i = 0; i < columns.length; i++)
            i + 1: const FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: const BoxDecoration(color: AppColors.navyLight),
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'PARAMETERS',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
              for (final col in columns)
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.column(col.role).label.toUpperCase(),
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          color: AppColors.navy,
                          letterSpacing: 0.6,
                        ),
                      ),
                      Text(
                        'Meter ${col.meter?.mfgNo ?? '(none)'}'
                        '${c.previous[col.role] != null ? '  •  last visit ${fmtDate(c.previous[col.role]!.report.visitDate)}' : ''}',
                        style: const TextStyle(
                          color: AppColors.muted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
          for (final p in t.params)
            TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: (p.label == 'Peak' || p.label == 'Off Peak')
                        ? 28
                        : 12,
                    right: 8,
                  ),
                  child: Text(
                    _label(p),
                    style: TextStyle(
                      fontWeight: (p.label == 'Peak' || p.label == 'Off Peak')
                          ? FontWeight.w500
                          : FontWeight.w700,
                      color: (p.label == 'Peak' || p.label == 'Off Peak')
                          ? AppColors.muted
                          : AppColors.text,
                    ),
                  ),
                ),
                for (final col in columns)
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                    child: ReadingCell(
                      c: c,
                      slot: col,
                      param: p,
                      showLabel: false,
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

String _label(ParamDef p) =>
    p.number == null ? p.label : '${p.number}. ${p.label}';

/// One reading input with previous value, total check and instant kW result.
class ReadingCell extends StatelessWidget {
  const ReadingCell({
    super.key,
    required this.c,
    required this.slot,
    required this.param,
    required this.showLabel,
  });
  final WizardController c;
  final ColumnSlot slot;
  final ParamDef param;
  final bool showLabel;

  @override
  Widget build(BuildContext context) => FieldAnchor(
    id: FieldIds.reading(slot.role, param.code),
    child: _cell(context),
  );

  Widget _cell(BuildContext context) {
    final t = c.bundle.template;
    final p = param;
    if (p.kind == ParamKind.meterNo) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 12),
        decoration: BoxDecoration(
          border: showLabel
              ? const Border(bottom: BorderSide(color: AppColors.line))
              : null,
        ),
        child: Text(
          '${showLabel ? '${_label(p)}: ' : ''}${slot.meter?.mfgNo ?? '(pick a meter in step B)'}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      );
    }
    final value = slot.readings[p.code] ?? '';
    final prev = c.previous[slot.role]?.values[p.code];
    final notes = <Widget>[];

    if (prev != null && prev.isNotEmpty) {
      notes.add(
        Text(
          'Last: $prev',
          style: const TextStyle(color: Colors.grey, fontSize: 13),
        ),
      );
    }

    final rule = t.totals.where((r) => r.total == p.code).firstOrNull;
    if (rule != null) {
      final chk = totalCheckFor(slot, rule);
      if (chk != null) {
        notes.add(
          chk.ok
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: okColor, size: 16),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        '= ${t.isNet ? 'T-1 + T-2' : 'Peak + Off Peak'} (auto)',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: okColor, fontSize: 13),
                      ),
                    ),
                  ],
                )
              : Container(
                  color: warningColor,
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.warning_amber,
                        color: Colors.brown,
                        size: 16,
                      ),
                      const SizedBox(width: 4),
                      Flexible(
                        child: Text(
                          'Sum ${fmtNum(chk.sum)} (diff ${fmtNum(chk.difference)})',
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      }
    }

    if (p.kind == ParamKind.instantKw && value.isNotEmpty) {
      final mf = columnMf(c.bundle, slot);
      notes.add(
        Text(
          mf == null ? 'Set M.F to compute KW' : instantKwText(value, mf),
          style: const TextStyle(
            color: Color(0xFF0D47A1),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      );
    }

    if (t.consumptionCodes.contains(p.code) && prev != null) {
      final cons = consumption(value, prev, columnMf(c.bundle, slot));
      if (cons != null) {
        notes.add(
          Text(
            'Since last visit: ${fmtNum(cons)} (x MF)',
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
        );
      }
    }

    final hint = switch (p.kind) {
      ParamKind.date => 'dd-mm-yy',
      ParamKind.time => 'hh:mm',
      ParamKind.instantKw => 'raw value on display',
      _ => null,
    };

    final field = _ReadingField(
      key: ValueKey('${slot.role}-${p.code}'),
      label: null,
      hint: hint,
      value: value,
      kind: p.kind,
      onChanged: (v) {
        slot.readings[p.code] = v;
        // Peak + Off Peak (or T-1 + T-2) fill their total automatically.
        applyAutoTotals(t, slot.readings, p.code);
        c.changed();
      },
    );
    if (!showLabel) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [field, ...notes, const SizedBox(height: 4)],
      );
    }
    // Phone: one form row per parameter (label left, value right).
    final sub = p.label == 'Peak' || p.label == 'Off Peak';
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: AppColors.line)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                flex: 5,
                child: Padding(
                  padding: EdgeInsets.only(left: sub ? 16 : 0),
                  child: Text(
                    _label(p),
                    style: TextStyle(
                      fontSize: sub ? 14.5 : 15,
                      fontWeight: sub ? FontWeight.w500 : FontWeight.w700,
                      color: sub ? AppColors.muted : AppColors.text,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(flex: 4, child: field),
            ],
          ),
          if (notes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Wrap(
                alignment: WrapAlignment.end,
                spacing: 10,
                children: notes,
              ),
            ),
        ],
      ),
    );
  }
}

class _ReadingField extends StatefulWidget {
  const _ReadingField({
    super.key,
    required this.label,
    required this.hint,
    required this.value,
    required this.kind,
    required this.onChanged,
  });
  final String? label;
  final String? hint;
  final String value;
  final ParamKind kind;
  final ValueChanged<String> onChanged;

  @override
  State<_ReadingField> createState() => _ReadingFieldState();
}

class _ReadingFieldState extends State<_ReadingField> {
  late final _ctl = TextEditingController(text: widget.value);

  @override
  void didUpdateWidget(covariant _ReadingField old) {
    super.didUpdateWidget(old);
    if (widget.value != _ctl.text) _ctl.text = widget.value;
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final numeric =
        widget.kind != ParamKind.date && widget.kind != ParamKind.time;
    return Padding(
      padding: const EdgeInsets.only(top: 2),
      child: TextField(
        controller: _ctl,
        style: const TextStyle(fontSize: 17),
        textInputAction: TextInputAction.next,
        keyboardType: numeric
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.datetime,
        inputFormatters: [
          FilteringTextInputFormatter.allow(
            numeric ? RegExp(r'[0-9.\-]') : RegExp(r'[0-9:\-/.]'),
          ),
        ],
        textAlign: widget.label == null ? TextAlign.right : TextAlign.start,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 11,
          ),
        ),
        onChanged: widget.onChanged,
      ),
    );
  }
}

/// "Meter 000001 • MTL AMR • MF 80" caption above a meter's readings.
class _MeterCaption extends StatelessWidget {
  const _MeterCaption({required this.slot, required this.template});
  final ColumnSlot slot;
  final ReportTemplate template;

  @override
  Widget build(BuildContext context) {
    final m = slot.meter;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 4),
      child: Row(
        children: [
          const Icon(Icons.electric_meter, color: AppColors.navy, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              m == null
                  ? 'No meter selected (step B)'
                  : 'Meter ${m.mfgNo}  •  ${m.make} ${m.meterKind}'
                        '${m.mf.isEmpty ? '' : '  •  MF ${m.mf}'}',
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
