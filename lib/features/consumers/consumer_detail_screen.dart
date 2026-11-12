import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../domain/formatters.dart';
import '../home/home_screen.dart' show ReportCard;
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
            Container(
              padding: const EdgeInsets.all(14),
              decoration: const BoxDecoration(
                color: AppColors.navy,
                borderRadius: BorderRadius.all(Radius.circular(6)),
                border: Border(
                  bottom: BorderSide(color: AppColors.gold, width: 3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'M/S ${c.name}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  if (c.address.isNotEmpty)
                    Text(
                      c.address,
                      style: const TextStyle(color: Color(0xFFDCE4EF)),
                    ),
                  const SizedBox(height: 6),
                  Text(
                    'A/C ${c.accountNo}${c.tariff.isEmpty ? '' : '   •   Tariff ${c.tariff}'}',
                    style: const TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: FilledButton.icon(
                    onPressed: () =>
                        startNewReport(context, ref, consumerId: c.id),
                    icon: const Icon(Icons.note_add),
                    label: const Text('New report'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/consumers/${c.id}/edit'),
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 2,
                  child: OutlinedButton.icon(
                    onPressed: () => context.push('/consumers/${c.id}/history'),
                    icon: const Icon(Icons.timeline),
                    label: const Text('History'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            FormSection(
              letter: 'A',
              title: 'Description of installation',
              child: InfoTable([
                ('Sub Division', c.subDivision),
                ('Division (OP)', c.opDivision),
                (
                  'Sanctioned Load',
                  c.sanctionedLoadKw.isEmpty ? '' : '${c.sanctionedLoadKw} KW',
                ),
                ('Connected Load', c.connectedLoad),
                ('Kind of Industry', c.industryKind),
                (
                  'Transformer',
                  [
                    if (c.transformerKva.isNotEmpty) '${c.transformerKva} KVA',
                    if (c.transformerMake.isNotEmpty) '(${c.transformerMake})',
                    if (c.transformerNo.isNotEmpty) 'No ${c.transformerNo}',
                  ].join(' '),
                ),
                (
                  'C.T Ratio',
                  c.ctPrimary.isEmpty
                      ? ''
                      : '${c.ctPrimary}/${c.ctSecondary} A',
                ),
                ('M.F', c.mf),
                ('Cable Size', c.cableSize),
                ('MSB Type', c.msbType),
                ('Feeder', c.feederName),
              ]),
            ),
            FormSection(
              letter: 'B',
              title: 'Meters',
              action: TextButton.icon(
                onPressed: () => context.push('/consumers/${c.id}/meters/new'),
                icon: const Icon(Icons.add, size: 18),
                label: const Text('Add'),
              ),
              child: meters.isEmpty
                  ? const Text(
                      'No meters yet.',
                      style: TextStyle(color: AppColors.muted),
                    )
                  : Column(
                      children: [
                        for (final m in meters)
                          InkWell(
                            onTap: () => context.push('/meters/${m.id}/edit'),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border: m == meters.last
                                    ? null
                                    : const Border(
                                        bottom: BorderSide(
                                          color: AppColors.line,
                                        ),
                                      ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.electric_meter,
                                    color: m.status == 'active'
                                        ? AppColors.navy
                                        : AppColors.muted,
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'MFG No ${m.mfgNo}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 15.5,
                                          ),
                                        ),
                                        Text(
                                          [
                                            '${m.make} ${m.meterKind}'.trim(),
                                            if (m.mf.isNotEmpty) 'MF ${m.mf}',
                                            if (m.status != 'active')
                                              'removed ${fmtDate(m.removedOn)}',
                                          ].join('  •  '),
                                          style: const TextStyle(
                                            color: AppColors.muted,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  StatusChip(
                                    m.status == 'active' ? 'active' : 'removed',
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
            const SectionTitle('Reports (newest first)'),
            if (reports.isEmpty)
              const Text(
                'No reports yet.',
                style: TextStyle(color: AppColors.muted),
              ),
            for (final r in reports) ReportCard(item: r, showConsumer: false),
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
}
