import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/formatters.dart';
import '../../domain/report_templates.dart';
import '../reports/new_report.dart';

class ConsumerDetailScreen extends ConsumerWidget {
  const ConsumerDetailScreen({super.key, required this.consumerId});
  final int consumerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final c = ref.watch(consumerProvider(consumerId)).value;
    return Scaffold(
      appBar: AppBar(title: Text(c?.name ?? 'Consumer')),
      body: ConsumerDetailBody(consumerId: consumerId),
    );
  }
}

/// Consumer info, meters (active and removed) and past reports.
class ConsumerDetailBody extends ConsumerWidget {
  const ConsumerDetailBody({super.key, required this.consumerId});
  final int consumerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final consumer = ref.watch(consumerProvider(consumerId));
    final meters = ref.watch(consumerMetersProvider(consumerId)).value ?? [];
    final reports = ref.watch(consumerReportsProvider(consumerId)).value ?? [];

    return consumer.when(
      loading: () => loadingOrError(null),
      error: (e, _) => loadingOrError(e),
      data: (c) {
        if (c == null) return const Center(child: Text('Consumer not found'));
        return ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(c.name, style: Theme.of(context).textTheme.headlineSmall),
            Text('${c.accountNo}  /  ${c.tariff}'),
            if (c.address.isNotEmpty) Text(c.address),
            const SizedBox(height: 8),
            Wrap(
              spacing: 16,
              runSpacing: 4,
              children: [
                _kv('Sub Division', c.subDivision),
                _kv('Division', c.opDivision),
                _kv(
                  'Sanctioned',
                  c.sanctionedLoadKw.isEmpty ? '' : '${c.sanctionedLoadKw} KW',
                ),
                _kv('Industry', c.industryKind),
                _kv(
                  'Transformer',
                  c.transformerKva.isEmpty ? '' : '${c.transformerKva} KVA',
                ),
                _kv(
                  'CT',
                  c.ctPrimary.isEmpty ? '' : '${c.ctPrimary}/${c.ctSecondary}',
                ),
                _kv('MF', c.mf),
                _kv('Cable', c.cableSize),
                _kv('MSB', c.msbType),
              ],
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () =>
                      startNewReport(context, ref, consumerId: c.id),
                  icon: const Icon(Icons.note_add),
                  label: const Text('New report'),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.push('/consumers/${c.id}/edit'),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
                OutlinedButton.icon(
                  onPressed: () => context.push('/consumers/${c.id}/history'),
                  icon: const Icon(Icons.timeline),
                  label: const Text('History'),
                ),
              ],
            ),
            const SectionTitle('Meters'),
            if (meters.isEmpty) const Text('No meters yet.'),
            for (final m in meters)
              Card(
                child: ListTile(
                  leading: Icon(
                    m.status == 'active'
                        ? Icons.electric_meter
                        : Icons.remove_circle_outline,
                  ),
                  title: Text('${m.mfgNo}  ${m.make}'),
                  subtitle: Text(
                    [
                      m.meterKind,
                      if (m.mf.isNotEmpty) 'MF ${m.mf}',
                      m.status == 'active'
                          ? 'Active'
                          : 'Removed ${fmtDate(m.removedOn)}',
                    ].join('  •  '),
                  ),
                  trailing: const Icon(Icons.edit),
                  onTap: () => context.push('/meters/${m.id}/edit'),
                ),
              ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                onPressed: () => context.push('/consumers/${c.id}/meters/new'),
                icon: const Icon(Icons.add),
                label: const Text('Add meter'),
              ),
            ),
            const SectionTitle('Reports (newest first)'),
            if (reports.isEmpty) const Text('No reports yet.'),
            for (final r in reports)
              Card(
                child: ListTile(
                  leading: Icon(
                    r.report.status == 'final'
                        ? Icons.verified
                        : Icons.edit_note,
                  ),
                  title: Text(
                    '${templateFor(r.report.reportType).shortName}  •  ${fmtDate(r.report.visitDate)}',
                  ),
                  subtitle: Text(
                    'Memo ${r.report.memoNo.isEmpty ? '-' : r.report.memoNo}  •  ${r.report.status}',
                  ),
                  onTap: () => context.push('/reports/${r.report.id}'),
                ),
              ),
            if (c.notes.isNotEmpty) ...[
              const SectionTitle('Notes'),
              Text(c.notes),
            ],
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () => _delete(context, ref, c),
                icon: const Icon(Icons.delete_outline),
                label: const Text('Delete consumer'),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _delete(
    BuildContext context,
    WidgetRef ref,
    ConsumerRow c,
  ) async {
    final ok = await confirm(
      context,
      'Delete consumer?',
      'This deletes ${c.name} with all meters and reports. This cannot be undone.',
      ok: 'Delete',
    );
    if (!ok) return;
    await ref.read(consumersDaoProvider).delete(c.id);
    if (context.mounted && context.canPop()) context.pop();
  }

  Widget _kv(String k, String v) => v.isEmpty
      ? const SizedBox.shrink()
      : Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: '$k: ',
                style: const TextStyle(color: Colors.black54),
              ),
              TextSpan(
                text: v,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        );
}
