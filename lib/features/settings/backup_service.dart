import 'dart:io';

import 'package:archive/archive.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

import '../../data/database.dart';

/// Name of the database file inside a backup .zip.
const backupDbName = 'mepco_meter.sqlite';

class BackupException implements Exception {
  BackupException(this.message);
  final String message;
  @override
  String toString() => message;
}

/// Writes a .zip with a consistent copy of the database and all PDFs.
Future<File> writeBackupZip({
  required AppDatabase db,
  required Directory pdfDir,
  required Directory outDir,
  String prefix = 'mepco_backup',
}) async {
  if (!outDir.existsSync()) outDir.createSync(recursive: true);
  final stamp = DateFormat('yyyy-MM-dd_HHmm').format(DateTime.now());
  final tmpDb = File(p.join(outDir.path, 'tmp_$stamp.sqlite'));
  if (tmpDb.existsSync()) tmpDb.deleteSync();
  // VACUUM INTO makes a clean, consistent copy while the database is open.
  final escaped = tmpDb.path.replaceAll("'", "''");
  await db.customStatement("VACUUM INTO '$escaped'");

  final archive = Archive()
    ..addFile(ArchiveFile.bytes(backupDbName, await tmpDb.readAsBytes()));
  if (pdfDir.existsSync()) {
    for (final f in pdfDir.listSync().whereType<File>()) {
      if (!f.path.toLowerCase().endsWith('.pdf')) continue;
      archive.addFile(
        ArchiveFile.bytes('pdfs/${p.basename(f.path)}', await f.readAsBytes()),
      );
    }
  }
  final zip = File(p.join(outDir.path, '${prefix}_$stamp.zip'));
  await zip.writeAsBytes(ZipEncoder().encodeBytes(archive), flush: true);
  await tmpDb.delete();
  return zip;
}

/// Checks a backup .zip and returns its archive. Throws [BackupException].
Archive readBackupZip(File zip) {
  Archive archive;
  try {
    archive = ZipDecoder().decodeBytes(zip.readAsBytesSync());
  } catch (_) {
    throw BackupException('This file is not a valid .zip backup.');
  }
  final dbEntry = archive.findFile(backupDbName);
  if (dbEntry == null) {
    throw BackupException('This .zip does not contain $backupDbName.');
  }
  final bytes = dbEntry.readBytes();
  if (bytes == null ||
      bytes.length < 16 ||
      String.fromCharCodes(bytes.take(15)) != 'SQLite format 3') {
    throw BackupException('The database in this backup is damaged.');
  }
  return archive;
}

/// Replaces the database file and PDFs with the backup's content.
/// The database must be CLOSED before calling this.
Future<void> restoreFiles({
  required Archive archive,
  required File dbFile,
  required Directory pdfDir,
}) async {
  for (final suffix in ['', '-journal', '-wal', '-shm']) {
    final f = File('${dbFile.path}$suffix');
    if (f.existsSync()) f.deleteSync();
  }
  await dbFile.writeAsBytes(
    archive.findFile(backupDbName)!.readBytes()!,
    flush: true,
  );
  if (!pdfDir.existsSync()) pdfDir.createSync(recursive: true);
  for (final f in pdfDir.listSync().whereType<File>()) {
    f.deleteSync();
  }
  for (final entry in archive.files) {
    if (!entry.isFile || !entry.name.startsWith('pdfs/')) continue;
    final name = p.basename(entry.name);
    if (name.isEmpty || name.startsWith('.')) continue;
    await File(p.join(pdfDir.path, name)).writeAsBytes(entry.readBytes()!);
  }
}
