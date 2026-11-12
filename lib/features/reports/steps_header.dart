import 'package:drift/drift.dart' show Value;
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/models.dart';
import '../../domain/report_templates.dart';
import '../consumers/consumer_form_screen.dart';
import 'wizard_controller.dart';

// ======================================================================= header

class HeaderStep extends StatelessWidget {
  const HeaderStep({super.key, required this.c});
  final WizardController c;

  void _set(Report Function(Report r) f) {
    c.bundle.report = f(c.bundle.report);
    c.changed();
  }

  Future<void> _changeType(BuildContext context, String type) async {
    final b = c.bundle;
    if (type == b.report.reportType) return;
    final ok = await confirm(
      context,
      'Change report type?',
      'Meter columns and readings will be reset for the new type.',
    );
    if (!ok) return;
    final old = b.columns
        .where((x) => x.meter != null && !x.notApplicable)
        .toList();
    final cols = ReportBundle.emptyColumns(type);
    var i = 0;
    for (final col in cols) {
      if (col.notApplicable) continue;
      if (i < old.length) col.meter = old[i++].meter;
    }
    b.columns = cols;
    b.report = b.report.copyWith(reportType: type);
    c.changed();
  }

  @override
  Widget build(BuildContext context) {
    final r = c.bundle.report;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const Icon(Icons.person),
            title: Text(c.bundle.sectionA['name'] ?? ''),
            subtitle: Text(c.bundle.sectionA['account_no'] ?? ''),
            trailing: TextButton(
              onPressed: () => context.push('/consumers/${r.consumerId}'),
              child: const Text('Open'),
            ),
          ),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          key: ValueKey(r.reportType),
          initialValue: r.reportType,
          decoration: const InputDecoration(labelText: 'Report type'),
          items: [
            for (final t in ReportType.all)
              DropdownMenuItem(value: t, child: Text(templateFor(t).shortName)),
          ],
          onChanged: (v) {
            if (v != null) _changeType(context, v);
          },
        ),
        const SizedBox(height: 8),
        ResponsiveFields(
          children: [
            AppField(
              label: 'Memo No',
              value: r.memoNo,
              onChanged: (v) => _set((r) => r.copyWith(memoNo: v)),
            ),
            DateField(
              label: 'Memo dated',
              value: r.memoDate,
              onChanged: (d) => _set((r) => r.copyWith(memoDate: Value(d))),
            ),
            AppField(
              label: 'To: Sub Division',
              value: r.toSubDivision,
              onChanged: (v) => _set((r) => r.copyWith(toSubDivision: v)),
            ),
            DateField(
              label: 'Visit date',
              value: r.visitDate,
              onChanged: (d) => _set((r) => r.copyWith(visitDate: Value(d))),
            ),
            DropdownButtonFormField<String>(
              initialValue: refTypes.containsKey(r.refType)
                  ? r.refType
                  : 'memo',
              decoration: const InputDecoration(labelText: 'Reference'),
              items: [
                for (final e in refTypes.entries)
                  DropdownMenuItem(value: e.key, child: Text(e.value)),
              ],
              onChanged: (v) => _set((r) => r.copyWith(refType: v ?? 'memo')),
            ),
            AppField(
              label: 'Ref No',
              value: r.refNo,
              onChanged: (v) => _set((r) => r.copyWith(refNo: v)),
            ),
            DateField(
              label: 'Ref dated',
              value: r.refDate,
              onChanged: (d) => _set((r) => r.copyWith(refDate: Value(d))),
            ),
          ],
        ),
        AppField(
          label: 'Team (names in the intro paragraph)',
          value: r.teamText,
          maxLines: 3,
          onChanged: (v) => _set((r) => r.copyWith(teamText: v)),
        ),
      ],
    );
  }
}

// ======================================================================= A

class SectionAStep extends StatelessWidget {
  const SectionAStep({super.key, required this.c});
  final WizardController c;

  void _set(Report Function(Report r) f) {
    c.bundle.report = f(c.bundle.report);
    c.changed();
  }

  @override
  Widget build(BuildContext context) {
    final r = c.bundle.report;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Filled from the consumer record. Changes stay in this report; '
          'you will be asked whether to update the consumer record too.',
          style: TextStyle(color: Colors.black54),
        ),
        SectionAEditor(
          key: ValueKey(c.bundle.report.id),
          values: c.bundle.sectionA,
          onChanged: c.changed,
        ),
        if (c.bundle.template.isNewConnection) ...[
          const SectionTitle('New connection details'),
          ResponsiveFields(
            children: [
              AppField(
                label: 'Store challan No',
                value: r.storeChallanNo,
                onChanged: (v) => _set((r) => r.copyWith(storeChallanNo: v)),
              ),
              DateField(
                label: 'Store challan dated',
                value: r.storeChallanDate,
                onChanged: (d) =>
                    _set((r) => r.copyWith(storeChallanDate: Value(d))),
              ),
              AppField(
                label: 'No. of new meters',
                value: r.newMeterCount,
                numeric: true,
                onChanged: (v) => _set((r) => r.copyWith(newMeterCount: v)),
              ),
              AppField(
                label: 'No. of CTs',
                value: r.ctCount,
                numeric: true,
                onChanged: (v) => _set((r) => r.copyWith(ctCount: v)),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ======================================================================= B

class SectionBStep extends StatelessWidget {
  const SectionBStep({super.key, required this.c});
  final WizardController c;

  Future<void> _addMeter(BuildContext context, ColumnSlot slot) async {
    final kind = switch (c.bundle.report.reportType) {
      ReportType.netMeter => 'NET',
      ReportType.newConnection => 'AMI',
      _ => slot.role == ColumnRole.existing ? 'TOU' : 'AMR',
    };
    final id = await context.push<int>(
      '/consumers/${c.bundle.report.consumerId}/meters/new?kind=$kind',
    );
    if (id == null) return;
    await c.reloadMeters();
    slot.meter = c.meters.where((m) => m.id == id).firstOrNull;
    slot.notApplicable = false;
    c.changed();
    await c.reloadPrevious();
  }

  Future<void> _editMeter(BuildContext context, Meter m) async {
    await context.push('/meters/${m.id}/edit');
    await c.reloadMeters();
    c.changed();
  }

  @override
  Widget build(BuildContext context) {
    final t = c.bundle.template;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text(
          'Pick the meter for each column. Mark unused columns "Not applicable": '
          'they are struck through on the printout.',
          style: TextStyle(color: Colors.black54),
        ),
        for (final slot in c.bundle.columns)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          t.column(slot.role).label,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Text('Not applicable'),
                      Switch(
                        value: slot.notApplicable,
                        onChanged: (v) {
                          slot.notApplicable = v;
                          c.changed();
                        },
                      ),
                    ],
                  ),
                  if (!slot.notApplicable) ...[
                    DropdownButtonFormField<int?>(
                      key: ValueKey(
                        '${slot.role}-${slot.meter?.id}-${c.meters.length}',
                      ),
                      initialValue: c.meters.any((m) => m.id == slot.meter?.id)
                          ? slot.meter?.id
                          : null,
                      isExpanded: true,
                      decoration: const InputDecoration(labelText: 'Meter'),
                      items: [
                        const DropdownMenuItem<int?>(
                          value: null,
                          child: Text('— none —'),
                        ),
                        for (final m in c.meters)
                          DropdownMenuItem<int?>(
                            value: m.id,
                            child: Text(
                              '${m.mfgNo}  ${m.make} ${m.meterKind}${m.status == 'removed' ? '  (removed)' : ''}',
                            ),
                          ),
                      ],
                      onChanged: (id) async {
                        slot.meter = c.meters
                            .where((m) => m.id == id)
                            .firstOrNull;
                        c.changed();
                        await c.reloadPrevious();
                      },
                    ),
                    if (slot.meter != null) _MeterParticulars(slot.meter!),
                    Wrap(
                      spacing: 8,
                      children: [
                        TextButton.icon(
                          onPressed: () => _addMeter(context, slot),
                          icon: const Icon(Icons.add),
                          label: const Text('Add new meter'),
                        ),
                        if (slot.meter != null)
                          TextButton.icon(
                            onPressed: () => _editMeter(context, slot.meter!),
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit meter'),
                          ),
                        if (slot.meter != null &&
                            (slot.role == ColumnRole.removed ||
                                slot.role == ColumnRole.backupRemoved) &&
                            slot.meter!.status != 'removed')
                          TextButton.icon(
                            onPressed: () async {
                              await c.metersDao.updateFields(
                                slot.meter!.id,
                                MetersCompanion(
                                  status: const Value('removed'),
                                  removedOn: Value(
                                    c.bundle.report.visitDate ?? DateTime.now(),
                                  ),
                                ),
                              );
                              await c.reloadMeters();
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                            label: const Text('Mark meter as removed'),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _MeterParticulars extends StatelessWidget {
  const _MeterParticulars(this.m);
  final Meter m;

  @override
  Widget build(BuildContext context) {
    final items = {
      'MFG No': m.mfgNo,
      'Make': '${m.make} ${m.meterKind}',
      'Amps': m.amps,
      'Volts': m.volts,
      'Constant': m.meterConstant,
      'M.F': m.mf.isEmpty ? '' : 'R x ${m.mf}',
      if (m.simNo.isNotEmpty) 'SIM': m.simNo,
      if (m.commId.isNotEmpty) 'Comm ID': m.commId,
    };
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Wrap(
        spacing: 16,
        runSpacing: 4,
        children: [
          for (final e in items.entries)
            Text(
              '${e.key}: ${e.value}',
              style: const TextStyle(color: Colors.black87),
            ),
        ],
      ),
    );
  }
}
