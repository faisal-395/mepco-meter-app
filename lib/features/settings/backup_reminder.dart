import 'package:drift/drift.dart' show countAll;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../domain/settings_keys.dart';

/// True when there is data and the last backup is older than 7 days (or never made).
bool backupIsDue(
  String? lastBackupIso, {
  required bool hasData,
  DateTime? now,
}) {
  if (!hasData) return false;
  final last = DateTime.tryParse(lastBackupIso ?? '');
  if (last == null) return true;
  return (now ?? DateTime.now()).difference(last).inDays >= 7;
}

final _hasDataProvider = StreamProvider.autoDispose<bool>((ref) {
  final db = ref.watch(databaseProvider);
  final count = countAll();
  return (db.selectOnly(
    db.reports,
  )..addColumns([count])).watchSingle().map((r) => (r.read(count) ?? 0) > 0);
});

/// Yellow banner on the home screen when a backup is due.
class BackupReminder extends ConsumerWidget {
  const BackupReminder({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final last = ref.watch(settingsProvider).value?[SettingKeys.lastBackupAt];
    final hasData = ref.watch(_hasDataProvider).value ?? false;
    if (!backupIsDue(last, hasData: hasData)) return const SizedBox.shrink();
    return Card(
      color: warningColor,
      child: ListTile(
        leading: const Icon(Icons.backup, color: Colors.brown),
        title: Text(
          last == null || last.isEmpty
              ? 'No backup made yet'
              : 'Last backup is more than 7 days old',
        ),
        subtitle: const Text('Tap to back up your data now.'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => context.push('/settings'),
      ),
    );
  }
}
