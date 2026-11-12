import 'dart:io';

import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_ui/material_ui.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../app/providers.dart';
import '../../app/widgets.dart';
import '../../data/database.dart';
import '../../data/demo_data.dart';
import '../../domain/settings_keys.dart';
import '../pdf/pdf_screen.dart';
import 'backup_service.dart';

/// Makes a backup .zip, records the time and returns the file.
Future<File> makeBackup(WidgetRef ref, {String prefix = 'mepco_backup'}) async {
  final db = ref.read(databaseProvider);
  final docs = await getApplicationDocumentsDirectory();
  final zip = await writeBackupZip(
    db: db,
    pdfDir: await pdfDirectory(),
    outDir: Directory(p.join(docs.path, 'backups')),
    prefix: prefix,
  );
  await ref
      .read(settingsDaoProvider)
      .set(SettingKeys.lastBackupAt, DateTime.now().toIso8601String());
  return zip;
}

/// Backup / restore / demo data buttons on the settings screen.
class BackupSection extends ConsumerStatefulWidget {
  const BackupSection({super.key});

  @override
  ConsumerState<BackupSection> createState() => _BackupSectionState();
}

class _BackupSectionState extends ConsumerState<BackupSection> {
  bool _busy = false;

  Future<void> _run(Future<void> Function() job) async {
    setState(() => _busy = true);
    try {
      await job();
    } catch (e) {
      if (mounted) showSnack(context, 'Error: $e');
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _backup() => _run(() async {
    final zip = await makeBackup(ref);
    await SharePlus.instance.share(
      ShareParams(
        files: [XFile(zip.path, mimeType: 'application/zip')],
        subject: p.basename(zip.path),
        text: 'MEPCO Meter Reports backup',
      ),
    );
    if (mounted) showSnack(context, 'Backup created: ${p.basename(zip.path)}');
  });

  Future<void> _restore() async {
    // FileType.any: some Android pickers grey out .zip files with a custom filter.
    final picked = await FilePicker.pickFile(type: FileType.any);
    final path = picked?.path;
    if (path == null || !mounted) return;
    final zipFile = File(path);
    final archive = readBackupZipSafe(zipFile);
    if (archive == null) return;
    final ok = await confirm(
      context,
      'Restore this backup?',
      'ALL current data will be replaced by the backup "${p.basename(path)}".\n\n'
          'A backup of the current data is made first (in the app\'s backups folder).',
      ok: 'Restore',
      cancel: 'Cancel',
    );
    if (!ok) return;
    await _run(() async {
      final safety = await makeBackup(ref, prefix: 'before_restore');
      final db = ref.read(databaseProvider);
      try {
        await db.close();
        await restoreFiles(
          archive: archive,
          dbFile: await databaseFile(),
          pdfDir: await pdfDirectory(),
        );
      } finally {
        // Re-open the database file (restored or not).
        ref.invalidate(databaseProvider);
      }
      if (mounted) {
        showSnack(
          context,
          'Restore complete. Previous data saved as ${p.basename(safety.path)}',
        );
        context.go('/');
      }
    });
  }

  Archive? readBackupZipSafe(File f) {
    try {
      return readBackupZip(f);
    } on BackupException catch (e) {
      showSnack(context, e.message);
      return null;
    }
  }

  Future<void> _demo() async {
    final ok = await confirm(
      context,
      'Load demo data?',
      'Adds three example consumers and reports (dummy names) so you can try the app.',
      ok: 'Load',
      cancel: 'Cancel',
    );
    if (!ok) return;
    await _run(() async {
      await insertDemoData(ref.read(databaseProvider));
      if (mounted) showSnack(context, 'Demo data loaded. See Home → Drafts.');
    });
  }

  @override
  Widget build(BuildContext context) {
    final last = DateTime.tryParse(
      ref.watch(settingsProvider).value?[SettingKeys.lastBackupAt] ?? '',
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SectionTitle('Backup and restore'),
        Text(
          last == null
              ? 'No backup made yet.'
              : 'Last backup: ${last.day.toString().padLeft(2, '0')}-${last.month.toString().padLeft(2, '0')}-${last.year} '
                    '${last.hour.toString().padLeft(2, '0')}:${last.minute.toString().padLeft(2, '0')}',
        ),
        const SizedBox(height: 8),
        if (_busy) const LinearProgressIndicator(),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: _busy ? null : _backup,
          icon: const Icon(Icons.backup),
          label: const Text('Backup now (share .zip to Drive / WhatsApp)'),
        ),
        const SizedBox(height: 8),
        OutlinedButton.icon(
          onPressed: _busy ? null : _restore,
          icon: const Icon(Icons.restore),
          label: const Text('Restore from a .zip backup'),
        ),
        const SectionTitle('Demo'),
        OutlinedButton.icon(
          onPressed: _busy ? null : _demo,
          icon: const Icon(Icons.science),
          label: const Text('Load demo data'),
        ),
      ],
    );
  }
}
