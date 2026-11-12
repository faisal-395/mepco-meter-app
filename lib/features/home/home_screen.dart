import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../app/widgets.dart';
import '../../domain/formatters.dart';
import '../../domain/report_templates.dart';
import '../reports/new_report.dart';
import '../settings/backup_reminder.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drafts = ref.watch(draftsProvider);
    final buttons = [
      _HomeButton(
        icon: Icons.note_add,
        label: 'New report',
        primary: true,
        onTap: () => startNewReport(context, ref),
      ),
      _HomeButton(
        icon: Icons.people,
        label: 'Consumers',
        onTap: () => context.push('/consumers'),
      ),
      _HomeButton(
        icon: Icons.list_alt,
        label: 'Reports',
        onTap: () => context.push('/reports'),
      ),
      _HomeButton(
        icon: Icons.search,
        label: 'Search',
        onTap: () => context.push('/search'),
      ),
      _HomeButton(
        icon: Icons.settings,
        label: 'Settings',
        onTap: () => context.push('/settings'),
      ),
    ];

    final draftList = drafts.when(
      loading: () => loadingOrError(null),
      error: (e, _) => loadingOrError(e),
      data: (items) => items.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(16),
              child: Text('No drafts. Tap "New report" to start one.'),
            )
          : Column(
              children: [
                for (final d in items)
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.edit_note),
                      title: Text(d.consumer.name),
                      subtitle: Text(
                        '${templateFor(d.report.reportType).shortName}  •  ${d.consumer.accountNo}  •  ${fmtDate(d.report.visitDate)}',
                      ),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => context.push('/reports/${d.report.id}'),
                    ),
                  ),
              ],
            ),
    );

    final wide = isWide(context);
    return Scaffold(
      appBar: AppBar(title: const Text('MEPCO Meter Reports')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const BackupReminder(),
          if (wide)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(width: 360, child: Column(children: buttons)),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [const SectionTitle('Drafts'), draftList],
                  ),
                ),
              ],
            )
          else ...[
            ...buttons,
            const SectionTitle('Drafts'),
            draftList,
          ],
        ],
      ),
    );
  }
}

class _HomeButton extends StatelessWidget {
  const _HomeButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.primary = false,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final child = Row(
      children: [
        Icon(icon, size: 28),
        const SizedBox(width: 16),
        Text(label, style: const TextStyle(fontSize: 18)),
      ],
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: SizedBox(
        width: double.infinity,
        height: 64,
        child: primary
            ? FilledButton(onPressed: onTap, child: child)
            : OutlinedButton(onPressed: onTap, child: child),
      ),
    );
  }
}
