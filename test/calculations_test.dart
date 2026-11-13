import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mepco_meter_app/data/daos.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';
import 'package:mepco_meter_app/domain/calculations.dart';
import 'package:mepco_meter_app/domain/formatters.dart';
import 'package:mepco_meter_app/domain/models.dart';
import 'package:mepco_meter_app/domain/report_calc.dart';
import 'package:mepco_meter_app/domain/report_templates.dart';
import 'package:mepco_meter_app/domain/settings_keys.dart';
import 'package:mepco_meter_app/domain/validators.dart';

void main() {
  group('basic rules', () {
    test('MF from CT ratio', () {
      expect(mfFromCt('400', '5'), 80);
      expect(mfFromCt('100', '5'), 20);
      expect(mfFromCt('', '5'), isNull);
      expect(mfFromCt('100', '0'), isNull);
      expect(parseMf('R x 80'), 80);
      expect(parseMf('20'), 20);
    });

    test('instant kW = raw x MF, 2 decimals, printed form', () {
      expect(instantKw('2.25', 80), 180.00);
      expect(instantKw('0.801', 20), 16.02);
      expect(instantKw('0.736', 20), 14.72);
      expect(instantKwText('2.258', 80), '2.258 x 80 = 180.64 KW');
      expect(instantKwText('', 80), '');
    });

    test('totals within 0.02', () {
      expect(checkTotal('2556.74', '508.62', '2048.11')!.ok, isTrue);
      expect(
        checkTotal('2556.74', '508.62', '2048.11')!.difference,
        closeTo(0.01, 1e-9),
      );
      expect(checkTotal('100', '50', '49.97')!.ok, isFalse);
      expect(checkTotal('', '1', '2'), isNull);
    });

    test('phase kW, check load, % error, limit', () {
      expect(phaseKw('425', '275', '0.89'), closeTo(180.17, 0.01));
      expect(phaseKw('419', '270', '0.92'), closeTo(180.27, 0.01));
      expect(phaseKw('428', '272', '0.94'), closeTo(189.54, 0.01));
      final kws = [
        phaseKw('425', '275', '0.89'),
        phaseKw('419', '270', '0.92'),
        phaseKw('428', '272', '0.94'),
      ];
      expect(checkLoad(kws), closeTo(183.33, 0.01));
      expect(
        checkLoad(kws, method: SettingKeys.methodSum),
        closeTo(549.98, 0.02),
      );
      expect(percentError(14.72, 14.7842), closeTo(-0.43, 0.01));
      expect(withinLimit(-0.43, ''), isNull);
      expect(withinLimit(-0.43, '1'), isTrue);
      expect(withinLimit(-1.8, '1'), isFalse);
    });

    test('consumption and register regression', () {
      expect(consumption('150', '100', 80), 4000);
      expect(registerWentDown('99', '100'), isTrue);
      expect(registerWentDown('100', '100'), isFalse);
      expect(registerWentDown('', '100'), isFalse);
    });

    test('dates and numbers keep their text', () {
      expect(fmtDate(parseDate('06-10-26')), '06-10-26');
      expect(parseDate('31-02-26'), isNull);
      expect(parseNum('035165'), 35165);
      expect(fmtCompact(80), '80');
      expect(fmtCompact(0.5), '0.5');
    });
  });

  group('templates', () {
    test('AMR has 18 rows, NET has 30 numbered rows', () {
      expect(amrTestCheckTemplate.params, hasLength(18));
      expect(newConnectionTemplate.params, hasLength(18));
      expect(netMeterTemplate.params, hasLength(30));
      for (var i = 0; i < 30; i++) {
        expect(netMeterTemplate.params[i].number, i + 1);
      }
      expect(amrTestCheckTemplate.params.first.label, 'Current Date');
      expect(amrTestCheckTemplate.params.last.label, 'Current P.F');
      expect(
        netMeterTemplate.params.last.label,
        'Export Instant Total active KW',
      );
    });
  });

  group('test data', () {
    late AppDatabase db;
    late List<int> ids;
    late ReportsDao dao;
    final settings = Map.of(SettingKeys.defaults);

    setUp(() async {
      db = AppDatabase(NativeDatabase.memory());
      dao = ReportsDao(db);
      ids = await insertDemoData(db);
    });
    tearDown(() => db.close());

    test('demo data is idempotent', () async {
      expect(await insertDemoData(db), ids);
    });

    test('1. AMR_TEST_CHECK', () async {
      final b = (await dao.loadBundle(ids[0]))!;
      final amr = b.column(ColumnRole.amr);
      expect(totalCheckFor(amr, amrTestCheckTemplate.totals[0])!.ok, isTrue);
      expect(totalWarnings(b.template, amr), isEmpty);
      expect(totalWarnings(b.template, b.column(ColumnRole.existing)), isEmpty);
      final c = computeSectionC(b, settings);
      expect(c.instantImport[ColumnRole.amr], 180.00);
      expect(c.phaseKw[phaseKey('import', 'R')], closeTo(180.17, 0.01));
      expect(c.phaseKw[phaseKey('import', 'Y')], closeTo(180.27, 0.01));
      expect(c.phaseKw[phaseKey('import', 'B')], closeTo(189.54, 0.01));
      expect(c.importCheckLoad, closeTo(183.33, 0.01));
      expect(c.within, isNull); // no limit set
      expect(b.column(ColumnRole.removed).isUsed, isFalse);
      final w = validateReport(b, settings);
      expect(w.where((x) => x.section == 'Readings'), isEmpty);
      // With a 1 % limit, -1.8 % is outside.
      final c2 = computeSectionC(b, {
        ...settings,
        SettingKeys.permissibleErrorLimit: '1',
      });
      expect(c2.within, isFalse);
    });

    test('2. NET_METER', () async {
      final b = (await dao.loadBundle(ids[1]))!;
      for (final role in [ColumnRole.billing, ColumnRole.backup]) {
        final col = b.column(role);
        for (final rule in netMeterTemplate.totals) {
          final chk = totalCheckFor(col, rule)!;
          expect(
            chk.difference,
            closeTo(0, 1e-9),
            reason: '$role ${rule.total}',
          );
        }
      }
      final c = computeSectionC(b, settings);
      expect(c.instantImport[ColumnRole.billing], 16.02);
      expect(c.instantImport[ColumnRole.backup], 16.02);
      expect(
        validateReport(b, settings).where((x) => x.section == 'Readings'),
        isEmpty,
      );
    });

    test('3. NEW_CONNECTION', () async {
      final b = (await dao.loadBundle(ids[2]))!;
      final c = computeSectionC(b, settings);
      expect(c.instantImport[ColumnRole.amr], 14.72);
      expect(c.phaseKw[phaseKey('import', 'R')], closeTo(15.06, 0.01));
      expect(c.phaseKw[phaseKey('import', 'Y')], closeTo(14.27, 0.01));
      expect(c.phaseKw[phaseKey('import', 'B')], closeTo(15.02, 0.01));
      expect(c.importCheckLoad, closeTo(14.78, 0.01));
      expect(c.errorImport[ColumnRole.amr], closeTo(-0.43, 0.01));
      expect(
        newConnectionRemarks(b),
        contains('M/S: Test School on Dated 05-11-26'),
      );
      expect(newConnectionRemarks(b), contains('(4) no. 100/5 Amp CTs'));
      expect(newConnectionRemarks(b), contains('(14.78 KW)'));
      expect(
        b.seal('TFORMER', ColumnRole.amr).postalOrder,
        'TA-900009-10-11-12',
      );
    });

    test('regression warning against an earlier visit', () async {
      final b = (await dao.loadBundle(ids[0]))!;
      final w = regressionWarnings(b.template, b.column(ColumnRole.amr), {
        'kwh_total': '3000',
        'reset_no': '08',
      });
      expect(w, hasLength(1));
      expect(w.first.message, contains('Current Total KWH'));
    });
  });
}
