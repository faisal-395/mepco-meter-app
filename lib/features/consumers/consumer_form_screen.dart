import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../domain/calculations.dart';
import '../../domain/formatters.dart';
import '../../domain/section_a.dart';

/// Editable list of section A fields. MF is auto-calculated from the CT ratio
/// until the officer types an MF by hand.
class SectionAEditor extends StatefulWidget {
  const SectionAEditor({
    super.key,
    required this.values,
    required this.onChanged,
    this.enabled = true,
  });

  final Map<String, String> values;
  final VoidCallback onChanged;
  final bool enabled;

  @override
  State<SectionAEditor> createState() => _SectionAEditorState();
}

class _SectionAEditorState extends State<SectionAEditor> {
  late bool _mfManual;

  @override
  void initState() {
    super.initState();
    final calc = mfFromCt(
        widget.values['ct_primary'] ?? '', widget.values['ct_secondary'] ?? '');
    final mf = widget.values['mf'] ?? '';
    _mfManual = mf.isNotEmpty && (calc == null || parseNum(mf) != calc);
  }

  void _set(String code, String v) {
    final values = widget.values;
    values[code] = v;
    if ((code == 'ct_primary' || code == 'ct_secondary') && !_mfManual) {
      final calc =
          mfFromCt(values['ct_primary'] ?? '', values['ct_secondary'] ?? '');
      values['mf'] = calc == null ? '' : fmtCompact(calc);
    }
    if (code == 'mf') _mfManual = v.trim().isNotEmpty;
    setState(() {});
    widget.onChanged();
  }

  @override
  Widget build(BuildContext context) {
    final calc = mfFromCt(
        widget.values['ct_primary'] ?? '', widget.values['ct_secondary'] ?? '');
    return ResponsiveFields(children: [
      for (final f in sectionAFields)
        if (f.date)
          TextDateField(
            label: f.label,
            value: widget.values[f.code] ?? '',
            onChanged: (v) => _set(f.code, v),
          )
        else
          AppField(
            label: f.label,
            value: widget.values[f.code] ?? '',
            numeric: f.numeric,
            enabled: widget.enabled,
            helper: f.code == 'mf'
                ? (calc == null
                    ? 'CT primary / CT secondary'
                    : 'From CT ratio: ${fmtCompact(calc)}'
                        '${_mfManual ? ' (edited by hand)' : ''}')
                : null,
            onChanged: (v) => _set(f.code, v),
          ),
    ]);
  }
}

class ConsumerFormScreen extends ConsumerStatefulWidget {
  const ConsumerFormScreen({super.key, this.consumerId});
  final int? consumerId;

  @override
  ConsumerState<ConsumerFormScreen> createState() => _ConsumerFormScreenState();
}

class _ConsumerFormScreenState extends ConsumerState<ConsumerFormScreen> {
  Map<String, String>? _values;
  String _notes = '';
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    if (widget.consumerId == null) {
      setState(() => _values = {});
      return;
    }
    final c = await ref.read(consumersDaoProvider).getById(widget.consumerId!);
    if (!mounted) return;
    setState(() {
      _values = c == null ? {} : sectionAFromConsumer(c);
      _notes = c?.notes ?? '';
    });
  }

  Future<void> _save() async {
    final v = _values!;
    final acc = (v['account_no'] ?? '').trim();
    if (acc.isEmpty) {
      showSnack(context, 'A/C No is required.');
      return;
    }
    setState(() => _saving = true);
    final dao = ref.read(consumersDaoProvider);
    try {
      final existing = await dao.findByAccount(acc);
      if (existing != null && existing.id != widget.consumerId) {
        if (mounted) showSnack(context, 'A/C No $acc already exists.');
        return;
      }
      final comp = consumerCompanionFromSectionA(v)
          .copyWith(accountNo: Value(acc), notes: Value(_notes));
      int id;
      if (widget.consumerId == null) {
        id = await dao.insert(comp);
      } else {
        id = widget.consumerId!;
        await dao.updateFields(id, comp);
      }
      if (!mounted) return;
      if (widget.consumerId == null) {
        context.pop(id);
      } else {
        context.pop();
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.consumerId == null ? 'New consumer' : 'Edit consumer'),
        actions: [
          TextButton.icon(
            onPressed: _values == null || _saving ? null : _save,
            icon: const Icon(Icons.save),
            label: const Text('Save'),
          ),
        ],
      ),
      body: _values == null
          ? loadingOrError(null)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const SectionTitle('Section A — Description of installation'),
                SectionAEditor(values: _values!, onChanged: () {}),
                AppField(
                  label: 'Notes',
                  value: _notes,
                  maxLines: 3,
                  onChanged: (v) => _notes = v,
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _saving ? null : _save,
                  icon: const Icon(Icons.save),
                  label: const Text('Save consumer'),
                ),
              ],
            ),
    );
  }
}
