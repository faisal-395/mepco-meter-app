import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mepco_meter_app/data/daos.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart' as s3;

void main() {
  test('a schema v1 database is upgraded to v2 without losing data', () async {
    final dir = Directory.systemTemp.createTempSync('mepco_migration');
    addTearDown(() => dir.deleteSync(recursive: true));
    final file = File(p.join(dir.path, 'db.sqlite'));

    // Make a database with data, then turn it back into the v1 layout.
    var db = AppDatabase(NativeDatabase(file));
    await insertDemoData(db);
    await db.close();
    final raw = s3.sqlite3.open(file.path);
    raw.execute('ALTER TABLE consumers DROP COLUMN ct_va_burden');
    raw.execute('ALTER TABLE reports DROP COLUMN load_type');
    raw.execute('PRAGMA user_version = 1');
    raw.close();

    db = AppDatabase(NativeDatabase(file));
    final b = (await ReportsDao(db).loadBundle(1))!;
    expect(b.sectionA['account_no'], '99-00001-0000001');
    expect(b.report.loadType, '3Ø H/Load');
    expect(b.consumer.ctVaBurden, '');
    expect(await db.select(db.reports).get(), hasLength(3));
    await db.close();
  });
}
