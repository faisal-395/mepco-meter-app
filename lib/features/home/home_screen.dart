import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../data/daos.dart';
import '../../data/database.dart';
import '../../domain/formatters.dart';
import '../../domain/report_templates.dart';
import '../../domain/settings_keys.dart';
import '../reports/new_report.dart';
import '../settings/backup_reminder.dart';

final _allReportsProvider = StreamProvider.autoDispose<List<ReportListItem>>(
  (ref) => ref.watch(reportsDaoProvider).watchFiltered(),
);
final _allConsumersProvider = StreamProvider.autoDispose<List<ConsumerRow>>(
  (ref) => ref.watch(consumersDaoProvider).watchAll(),
);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftsProvider);
    final reports = ref.watch(_allReportsProvider).value ?? [];
    final consumers = ref.watch(_allConsumersProvider).value ?? [];
    final circle =
        ref.watch(settingsProvider).value?[SettingKeys.circle] ??
        'Bahawalnagar';
    final now = DateTime.now();
    final finalThisMonth = reports
        .where(
          (r) =>
              r.report.status == 'final' &&
              r.report.visitDate != null &&
              r.report.visitDate!.year == now.year &&
              r.report.visitDate!.month == now.month,
        )
        .length;
    final wide = isWide(context);

    final newReport = SizedBox(
      width: double.infinity,
      height: 60,
      child: FilledButton.icon(
        onPressed: () => startNewReport(context, ref),
        icon: const Icon(Icons.note_add, size: 26),
        label: const Text('NEW REPORT', style: TextStyle(fontSize: 17)),
      ),
    );

    final stats = Row(
      children: [
        _StatTile(
          label: 'Drafts',
          value: '${drafts.value?.length ?? 0}',
          icon: Icons.edit_note,
        ),
        const SizedBox(width: 8),
        _StatTile(
          label: 'Final this month',
          value: '$finalThisMonth',
          icon: Icons.verified_outlined,
        ),
        const SizedBox(width: 8),
        _StatTile(
          label: 'Consumers',
          value: '${consumers.length}',
          icon: Icons.groups_outlined,
        ),
      ],
    );

    final tiles = GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      childAspectRatio: 1.9,
      children: [
        _MenuTile(
          icon: Icons.groups,
          title: 'Consumers',
          subtitle: 'Accounts & meters',
          onTap: () => context.push('/consumers'),
        ),
        _MenuTile(
          icon: Icons.menu_book,
          title: 'Memo Register',
          subtitle: 'All reports',
          onTap: () => context.push('/reports'),
        ),
        _MenuTile(
          icon: Icons.search,
          title: 'Search',
          subtitle: 'A/C, meter, memo',
          onTap: () => context.push('/search'),
        ),
        _MenuTile(
          icon: Icons.settings,
          title: 'Settings',
          subtitle: 'Office & backup',
          onTap: () => context.push('/settings'),
        ),
      ],
    );

    final draftList = drafts.when(
      loading: () => loadingOrError(null),
      error: (e, _) => loadingOrError(e),
      data: (items) => items.isEmpty
          ? Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColors.line),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'No drafts in progress. Tap NEW REPORT to start one.',
                style: TextStyle(color: AppColors.muted),
              ),
            )
          : Column(children: [for (final d in items) _DraftCard(item: d)]),
    );

    final left = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const BackupReminder(),
        newReport,
        const SizedBox(height: 12),
        stats,
        const SizedBox(height: 12),
        tiles,
      ],
    );
    final right = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [const SectionTitle('Drafts in progress'), draftList],
    );

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.navy,
            child: SafeArea(bottom: false, child: OfficeHeader(circle: circle)),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                const Text(
                  'METER REPORTS',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                Text(
                  DateFormat('EEEE, dd-MM-yy').format(now),
                  style: const TextStyle(color: AppColors.muted),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (wide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 420, child: left),
                      const SizedBox(width: 24),
                      Expanded(child: right),
                    ],
                  )
                else ...[
                  left,
                  right,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({
    required this.label,
    required this.value,
    required this.icon,
  });
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: AppColors.line),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 18, color: AppColors.gold),
                const SizedBox(width: 6),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.navy,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: AppColors.muted),
            ),
          ],
        ),
      ),
    );
  }
}

class _MenuTile extends StatelessWidget {
  const _MenuTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: const BorderSide(color: AppColors.line),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.navyLight,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(icon, color: AppColors.navy),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                        color: AppColors.text,
                      ),
                    ),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// One report in a list: consumer, A/C, type, date, memo and status.
class ReportCard extends StatelessWidget {
  const ReportCard({super.key, required this.item, this.showConsumer = true});
  final ReportListItem item;
  final bool showConsumer;

  @override
  Widget build(BuildContext context) {
    final r = item.report;
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(6),
        onTap: () => context.push('/reports/${r.id}'),
        child: Container(
          decoration: const BoxDecoration(
            border: Border(left: BorderSide(color: AppColors.navy, width: 4)),
          ),
          padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      showConsumer
                          ? item.consumer.name
                          : templateFor(r.reportType).shortName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      [
                        if (showConsumer) item.consumer.accountNo,
                        if (showConsumer) templateFor(r.reportType).shortName,
                        'Visit ${fmtDate(r.visitDate)}',
                        if (r.memoNo.isNotEmpty) 'Memo ${r.memoNo}',
                      ].join('  •  '),
                      style: const TextStyle(
                        color: AppColors.muted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              StatusChip(r.status),
              const Icon(Icons.chevron_right, color: AppColors.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class _DraftCard extends StatelessWidget {
  const _DraftCard({required this.item});
  final ReportListItem item;
  @override
  Widget build(BuildContext context) => ReportCard(item: item);
}
