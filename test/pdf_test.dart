import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mepco_meter_app/data/daos.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';
import 'package:mepco_meter_app/domain/settings_keys.dart';
import 'package:mepco_meter_app/features/pdf/report_pdf.dart';

void main() {
  late AppDatabase db;
  late List<int> ids;

  setUp(() async {
    db = AppDatabase(NativeDatabase.memory());
    ids = await insertDemoData(db);
  });
  tearDown(() => db.close());

  for (final (i, name) in [
    (0, 'AMR_TEST_CHECK'),
    (1, 'NET_METER'),
    (2, 'NEW_CONNECTION'),
  ]) {
    test('PDF builds for test data ${i + 1} ($name)', () async {
      final b = (await ReportsDao(db).loadBundle(ids[i]))!;
      final bytes = await buildReportPdf(b, SettingKeys.defaults);
      expect(bytes.length, greaterThan(1000));
      final text = String.fromCharCodes(bytes.take(8));
      expect(text, startsWith('%PDF'));
      // Two pages.
      final s = String.fromCharCodes(bytes);
      expect(RegExp(r'/Type\s*/Page\b').allMatches(s).length, 2);
      expect(reportPdfFileName(b), endsWith('_$name.pdf'));
      final out = Directory('build/test_pdfs')..createSync(recursive: true);
      File('${out.path}/${reportPdfFileName(b)}').writeAsBytesSync(bytes);
    });
  }
}
