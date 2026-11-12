import 'package:drift/drift.dart' show Value;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/report_templates.dart';

/// Add or edit a meter. Pops with the meter id after saving.
class MeterFormScreen extends ConsumerStatefulWidget {
  const MeterFormScreen({super.key, this.consumerId, this.meterId, this.defaultKind});
  final int? consumerId;
  final int? meterId;
  final String? defaultKind;

  @override
  ConsumerState<MeterFormScreen> createState() => _MeterFormScreenState();
}

class _MeterFormScreenState extends ConsumerState<MeterFormScreen> {
  bool _loaded = false;
  int? _consumerId;
  String mfgNo = '', make = '', kind = 'AMR', amps = '', volts = '';
  String constant = '', mf = '', simNo = '', commId = '', status = 'active';
  DateTime? installedOn, removedOn;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    _consumerId = widget.consumerId;
    kind = widget.defaultKind ?? 'AMR';
    if (widget.meterId != null) {
      final m = await ref.read(metersDaoProvider).getById(widget.meterId!);
      if (m != null) {
        _consumerId = m.consumerId;
        mfgNo = m.mfgNo;
        make = m.make;
        kind = m.meterKind;
        amps = m.amps;
        volts = m.volts;
        constant = m.meterConstant;
        mf = m.mf;
        simNo = m.simNo;
        commId = m.commId;
        status = m.status;
        installedOn = m.installedOn;
        removedOn = m.removedOn;
      }
    } else if (_consumerId != null) {
      // New meter: default MF from the consumer's CT ratio.
      final c = await ref.read(consumersDaoProvider).getById(_consumerId!);
      mf = c?.mf ?? '';
      volts = '3x230/400V';
      amps = '5(10)A';
      constant = '10000';
      installedOn = DateTime.now();
    }
    if (mounted) setState(() => _loaded = true);
  }

  Future<void> _save() async {
    if (mfgNo.trim().isEmpty) {
      showSnack(context, 'MFG No is required.');
      return;
    }
    final comp = MetersCompanion(
      consumerId: Value(_consumerId!),
      mfgNo: Value(mfgNo.trim()),
      make: Value(make.trim()),
      meterKind: Value(kind),
      amps: Value(amps.trim()),
      volts: Value(volts.trim()),
      meterConstant: Value(constant.trim()),
      mf: Value(mf.trim()),
      simNo: Value(simNo.trim()),
      commId: Value(commId.trim()),
      status: Value(status),
      installedOn: Value(installedOn),
      removedOn: Value(status == 'removed' ? (removedOn ?? DateTime.now()) : null),
    );
    final dao = ref.read(metersDaoProvider);
    int id;
    if (widget.meterId == null) {
      id = await dao.insert(comp);
    } else {
      id = widget.meterId!;
      await dao.updateFields(id, comp);
    }
    if (mounted) context.pop(id);
  }

  Future<void> _delete() async {
    final ok = await confirm(context, 'Delete meter?',
        'Reports that used this meter keep their readings but lose the meter link.',
        ok: 'Delete');
    if (!ok) return;
    await ref.read(metersDaoProvider).delete(widget.meterId!);
    if (mounted) context.pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meterId == null ? 'New meter' : 'Edit meter'),
        actions: [
          TextButton.icon(
              onPressed: _loaded ? _save : null,
              icon: const Icon(Icons.save),
              label: const Text('Save')),
        ],
      ),
      body: !_loaded
          ? loadingOrError(null)
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ResponsiveFields(children: [
                  AppField(label: 'MFG No', value: mfgNo, onChanged: (v) => mfgNo = v),
                  AppField(label: 'Make', value: make, onChanged: (v) => make = v),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: DropdownButtonFormField<String>(
                      initialValue: meterKinds.contains(kind) ? kind : 'AMR',
                      decoration: const InputDecoration(labelText: 'Meter kind'),
                      items: [
                        for (final k in meterKinds)
                          DropdownMenuItem(value: k, child: Text(k)),
                      ],
                      onChanged: (v) => setState(() => kind = v ?? 'AMR'),
                    ),
                  ),
                  AppField(label: 'Amps', value: amps, onChanged: (v) => amps = v),
                  AppField(label: 'Volts', value: volts, onChanged: (v) => volts = v),
                  AppField(
                      label: 'Meter constant (imp/kWh/kVARh)',
                      value: constant,
                      onChanged: (v) => constant = v),
                  AppField(
                      label: 'M.F',
                      value: mf,
                      numeric: true,
                      helper: 'Printed as "R x MF"',
                      onChanged: (v) => mf = v),
                  AppField(label: 'SIM No', value: simNo, onChanged: (v) => simNo = v),
                  AppField(label: 'Comm ID', value: commId, onChanged: (v) => commId = v),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: DropdownButtonFormField<String>(
                      initialValue: status,
                      decoration: const InputDecoration(labelText: 'Status'),
                      items: const [
                        DropdownMenuItem(value: 'active', child: Text('Active')),
                        DropdownMenuItem(value: 'removed', child: Text('Removed')),
                      ],
                      onChanged: (v) => setState(() => status = v ?? 'active'),
                    ),
                  ),
                  DateField(
                      label: 'Installed on',
                      value: installedOn,
                      onChanged: (d) => setState(() => installedOn = d)),
                  if (status == 'removed')
                    DateField(
                        label: 'Removed on',
                        value: removedOn,
                        onChanged: (d) => setState(() => removedOn = d)),
                ]),
                const SizedBox(height: 16),
                FilledButton.icon(
                    onPressed: _save,
                    icon: const Icon(Icons.save),
                    label: const Text('Save meter')),
                if (widget.meterId != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton.icon(
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      onPressed: _delete,
                      icon: const Icon(Icons.delete_outline),
                      label: const Text('Delete meter'),
                    ),
                  ),
              ],
            ),
    );
  }
}
