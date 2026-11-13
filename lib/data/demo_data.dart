import 'package:drift/drift.dart';

import '../domain/formatters.dart';
import '../domain/models.dart';
import '../domain/report_templates.dart';
import 'daos.dart';
import 'database.dart';

/// Inserts the three test reports from PLAN.md (dummy names and numbers).
/// Returns the report ids [amrTestCheck, netMeter, newConnection].
/// If a demo consumer already exists, its first report is reused.
Future<List<int>> insertDemoData(AppDatabase db) async {
  return [await _demo1(db), await _demo2(db), await _demo3(db)];
}

Future<int?> _existing(AppDatabase db, String acc) async {
  final c = await ConsumersDao(db).findByAccount(acc);
  if (c == null) return null;
  final r =
      await (db.select(db.reports)
            ..where((t) => t.consumerId.equals(c.id))
            ..orderBy([(t) => OrderingTerm.asc(t.id)])
            ..limit(1))
          .getSingleOrNull();
  return r?.id;
}

DateTime _d(String s) => parseDate(s)!;

Future<int> _meter(
  AppDatabase db,
  int consumerId,
  String no,
  String make,
  String kind,
  String amps,
  String volts,
  String mf, {
  String sim = '',
  String comm = '',
}) {
  return MetersDao(db).insert(
    MetersCompanion.insert(
      consumerId: consumerId,
      mfgNo: no,
      make: Value(make),
      meterKind: Value(kind),
      amps: Value(amps),
      volts: Value(volts),
      meterConstant: const Value('10000'),
      mf: Value(mf),
      simNo: Value(sim),
      commId: Value(comm),
    ),
  );
}

// ------------------------------------------------------------------ 1. AMR

Future<int> _demo1(AppDatabase db) async {
  const acc = '99-00001-0000001';
  final ex = await _existing(db, acc);
  if (ex != null) return ex;
  final cid = await ConsumersDao(db).insert(
    ConsumersCompanion.insert(
      accountNo: acc,
      tariff: const Value('B2'),
      name: const Value('Test Cotton Factory'),
      address: const Value('F/Abbas'),
      subDivision: const Value('F/Abbas'),
      opDivision: const Value('HND'),
      sanctionedLoadKw: const Value('255.00'),
      industryKind: const Value('Cotton & Factory'),
      transformerKva: const Value('400'),
      ctPrimary: const Value('400'),
      ctSecondary: const Value('5'),
      mf: const Value('80'),
      cableSize: const Value('37/0.103'),
      msbType: const Value('"A" Type New'),
    ),
  );
  await _meter(db, cid, '000001', 'MTL', 'AMR', '5(10)A', '3x230/400V', '80');
  await _meter(db, cid, '000002', 'CE', 'TOU', '5(10)A', '3x230/400V', '80');

  final dao = ReportsDao(db);
  final id = await dao.createDraft(
    consumerId: cid,
    type: ReportType.amrTestCheck,
  );
  final b = (await dao.loadBundle(id))!;
  b.report = b.report.copyWith(
    memoNo: 'DEMO-1',
    memoDate: Value(_d('06-10-26')),
    visitDate: Value(_d('06-10-26')),
    refType: 'routine',
    toSubDivision: 'F/Abbas',
    teamText: 'Mr. Abdul Hafeez (TI), Sajid Naveed (T.A)',
    msbStatus: 'Welded',
    accuracyText: 'OK',
    transformerLtBushes: 'Sealed',
  );
  b.column(ColumnRole.removed).notApplicable = true;
  b.column(ColumnRole.amr).readings.addAll({
    'date': '06-10-26',
    'time': '14:55',
    'kwh_total': '2556.74',
    'kwh_peak': '508.62',
    'kwh_off': '2048.11',
    'kvarh_total': '1937.75',
    'kvarh_peak': '391.22',
    'kvarh_off': '1546.53',
    'mdi_total': '2.00',
    'mdi_peak': '1.99',
    'mdi_off': '2.00',
    'cum_mdi_total': '12.45',
    'cum_mdi_peak': '18.15',
    'cum_mdi_off': '12.42',
    'reset_no': '09',
    'instant_kw': '2.25',
  });
  b.column(ColumnRole.existing).readings.addAll({
    'date': '06-10-26',
    'time': '14:52',
    'kwh_total': '8651.72',
    'kwh_peak': '1745.70',
    'kwh_off': '6906.02',
    'kvarh_total': '4785.78',
    'kvarh_peak': '968.12',
    'kvarh_off': '3817.66',
    'mdi_total': '2.016',
    'mdi_peak': '1.990',
    'mdi_off': '2.016',
    'cum_mdi_total': '34.26',
    'cum_mdi_peak': '33.11',
    'cum_mdi_off': '34.22',
    'reset_no': '25',
    'instant_kw': '2.25',
  });
  _loads(b, [
    ('425', '275', '0.89'),
    ('419', '270', '0.92'),
    ('428', '272', '0.94'),
  ]);
  b.report = b.report.copyWith(checkedLoadKw: '183.33');
  await dao.saveBundle(b);
  return id;
}

void _loads(ReportBundle b, List<(String, String, String)> rows) {
  for (var i = 0; i < 3; i++) {
    final l = b.load('import', phases[i]);
    l.volts = rows[i].$1;
    l.amps = rows[i].$2;
    l.pf = rows[i].$3;
  }
}

// ------------------------------------------------------------------ 2. NET

Future<int> _demo2(AppDatabase db) async {
  const acc = '99-00001-0000002';
  final ex = await _existing(db, acc);
  if (ex != null) return ex;
  final cid = await ConsumersDao(db).insert(
    ConsumersCompanion.insert(
      accountNo: acc,
      tariff: const Value('B2'),
      name: const Value('Test Marble Factory'),
      address: const Value('F/Abbas'),
      subDivision: const Value('F/Abbas'),
      opDivision: const Value('HND'),
      sanctionedLoadKw: const Value('40.00'),
      industryKind: const Value('Marble Factory'),
      transformerKva: const Value('50'),
      ctPrimary: const Value('100'),
      ctSecondary: const Value('5'),
      mf: const Value('20'),
      cableSize: const Value('37/0.083'),
      msbType: const Value('"A" Type New'),
    ),
  );
  await _meter(db, cid, '100001', 'CE', 'NET', '5/10A', '230/400V', '20');
  await _meter(db, cid, '100002', 'CE', 'NET', '5/10A', '230/400V', '20');

  final dao = ReportsDao(db);
  final id = await dao.createDraft(consumerId: cid, type: ReportType.netMeter);
  final b = (await dao.loadBundle(id))!;
  b.report = b.report.copyWith(
    memoNo: 'DEMO-2',
    memoDate: Value(_d('06-10-26')),
    visitDate: Value(_d('06-10-26')),
    refType: 'routine',
    toSubDivision: 'F/Abbas',
    teamText: 'Mr. Abdul Hafeez (TI), Sajid Naveed (T.A)',
  );
  b.column(ColumnRole.billing).readings.addAll({
    'date': '06-10-26',
    'time': '16:40',
    'imp_kwh_total': '780.2',
    'imp_kwh_t1': '73.8',
    'imp_kwh_t2': '706.4',
    'exp_kwh_total': '1855.4',
    'exp_kwh_t1': '22.8',
    'exp_kwh_t2': '1832.6',
    'imp_kvarh_total': '287.1',
    'imp_kvarh_t1': '14.9',
    'imp_kvarh_t2': '272.2',
    'exp_kvarh_total': '411.3',
    'exp_kvarh_t1': '54.6',
    'exp_kvarh_t2': '356.7',
    'resets_no': '22',
    'imp_instant_kw': '0.801',
  });
  b.column(ColumnRole.backup).readings.addAll({
    'date': '06-10-26',
    'time': '16:41',
    'imp_kwh_total': '773.6',
    'imp_kwh_t1': '72.6',
    'imp_kwh_t2': '701.0',
    'exp_kwh_total': '1842.0',
    'exp_kwh_t1': '21.2',
    'exp_kwh_t2': '1820.8',
    'imp_kvarh_total': '301.4',
    'imp_kvarh_t1': '14.2',
    'imp_kvarh_t2': '287.2',
    'exp_kvarh_total': '402.2',
    'exp_kvarh_t1': '52.9',
    'exp_kvarh_t2': '349.3',
    'resets_no': '22',
    'imp_instant_kw': '0.801',
  });
  await dao.saveBundle(b);
  return id;
}

// ------------------------------------------------------------------ 3. NEW

Future<int> _demo3(AppDatabase db) async {
  const acc = '99-00002-0000003';
  final ex = await _existing(db, acc);
  if (ex != null) return ex;
  final cid = await ConsumersDao(db).insert(
    ConsumersCompanion.insert(
      accountNo: acc,
      tariff: const Value('A3'),
      name: const Value('Test School'),
      address: const Value('13/G Road CTN'),
      subDivision: const Value('S/Town CTN'),
      opDivision: const Value('CTN'),
      sanctionedLoadKw: const Value('39.00'),
      industryKind: const Value('School'),
      transformerKva: const Value('50'),
      transformerMake: const Value('PEL'),
      transformerNo: const Value('100001'),
      ctPrimary: const Value('100'),
      ctSecondary: const Value('5'),
      mf: const Value('20'),
      cableSize: const Value('19/0.083'),
      msbType: const Value('"A" Type New'),
      applicationNo: const Value('10000000000001'),
      applicationDate: Value(_d('17-07-26')),
      scoMcoRcoNo: const Value('10000000000001'),
      scoDate: Value(_d('17-07-26')),
    ),
  );
  await _meter(
    db,
    cid,
    '3200000001',
    'CE',
    'AMI',
    '5(10)A',
    '3x230/400V',
    '20',
    sim: '0300-0000000',
    comm: '000000000000000',
  );

  final dao = ReportsDao(db);
  final id = await dao.createDraft(
    consumerId: cid,
    type: ReportType.newConnection,
  );
  final b = (await dao.loadBundle(id))!;
  b.report = b.report.copyWith(
    memoNo: '101-11',
    memoDate: Value(_d('05-11-26')),
    visitDate: Value(_d('05-11-26')),
    toSubDivision: 'S/Town CTN',
    refType: 'memo',
    refNo: '10001-05',
    refDate: Value(_d('29-10-26')),
    teamText: 'Mr. Abdul Hafeez (TI), Sajid Naveed (T.A)',
    storeChallanNo: '1001',
    storeChallanDate: Value(_d('30-10-26')),
    newMeterCount: '1',
    ctCount: '4',
    checkedLoadKw: '14.78',
    signerExenOp: 'Test One',
    signerSdoOp: 'Test Two',
  );
  b.column(ColumnRole.amr).readings.addAll({
    'date': '05-11-26',
    'kwh_total': '0.40',
    'kwh_peak': '0.00',
    'kwh_off': '0.40',
    'kvarh_total': '0.70',
    'kvarh_peak': '0.00',
    'kvarh_off': '0.70',
    'reset_no': '01',
    'instant_kw': '0.736',
  });
  _loads(b, [
    ('414', '21', '1.00'),
    ('412', '20', '1.00'),
    ('413', '21', '1.00'),
  ]);
  const seals = {
    'TOU_MC': 'TA-900001',
    'TOU_TC': 'TA-900002',
    'MSB': 'TA-900003-04',
    'MSB_2': 'TA-900005-06',
    'MSB_GLASS': 'TA-900007-08',
    'TFORMER': 'TA-900009-10-11-12',
  };
  seals.forEach((spot, v) => b.seal(spot, ColumnRole.amr).postalOrder = v);
  await dao.saveBundle(b);
  return id;
}
