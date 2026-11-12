import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mepco_meter_app/data/daos.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';
import 'package:mepco_meter_app/features/settings/backup_reminder.dart';
import 'package:mepco_meter_app/features/settings/backup_service.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tmp;
  setUp(() => tmp = Directory.systemTemp.createTempSync('mepco_backup_test'));
  tearDown(() => tmp.deleteSync(recursive: true));

  test('backup zip round trip restores database and PDFs', () async {
    final dbFile = File(p.join(tmp.path, 'app.sqlite'));
    final pdfDir = Directory(p.join(tmp.path, 'pdfs'))..createSync();
    File(p.join(pdfDir.path, 'a.pdf')).writeAsStringSync('%PDF-test');

    var db = AppDatabase(NativeDatabase(dbFile));
    await insertDemoData(db);
    final zip = await writeBackupZip(
      db: db,
      pdfDir: pdfDir,
      outDir: Directory(p.join(tmp.path, 'out')),
    );
    expect(zip.existsSync(), isTrue);

    // Change data after the backup, then restore.
    await ReportsDao(db).delete(1);
    File(p.join(pdfDir.path, 'b.pdf')).writeAsStringSync('%PDF-new');
    await db.close();

    final archive = readBackupZip(zip);
    await restoreFiles(archive: archive, dbFile: dbFile, pdfDir: pdfDir);

    db = AppDatabase(NativeDatabase(dbFile));
    expect(await ReportsDao(db).loadBundle(1), isNotNull);
    expect(await db.select(db.reports).get(), hasLength(3));
    await db.close();
    expect(pdfDir.listSync().map((f) => p.basename(f.path)), ['a.pdf']);
  });

  test('invalid zip is rejected', () {
    final f = File(p.join(tmp.path, 'bad.zip'))..writeAsStringSync('nope');
    expect(() => readBackupZip(f), throwsA(isA<BackupException>()));
  });

  test('backup reminder after 7 days', () {
    final now = DateTime(2026, 11, 12);
    expect(backupIsDue(null, hasData: false, now: now), isFalse);
    expect(backupIsDue(null, hasData: true, now: now), isTrue);
    expect(
      backupIsDue(
        DateTime(2026, 11, 10).toIso8601String(),
        hasData: true,
        now: now,
      ),
      isFalse,
    );
    expect(
      backupIsDue(
        DateTime(2026, 11, 4).toIso8601String(),
        hasData: true,
        now: now,
      ),
      isTrue,
    );
  });
}
