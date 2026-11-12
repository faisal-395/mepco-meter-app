/// Report templates: the columns and reading rows of each report type.
/// The wizard and the PDF both render from these definitions.
library;

enum ParamKind { meterNo, date, time, number, integer, instantKw, pf }

class ParamDef {
  const ParamDef(this.code, this.label, this.kind, {this.number});
  final String code;

  /// Label exactly as printed on the paper form.
  final String label;
  final ParamKind kind;

  /// Row number printed on the form (NET_METER only).
  final int? number;

  bool get isNumeric =>
      kind == ParamKind.number ||
      kind == ParamKind.integer ||
      kind == ParamKind.instantKw ||
      kind == ParamKind.pf;
}

class ColumnDef {
  const ColumnDef(this.role, this.label, {this.defaultNotApplicable = false});
  final String role;
  final String label;
  final bool defaultNotApplicable;
}

/// total = partA + partB (warn if the difference is more than 0.02).
class TotalRule {
  const TotalRule(this.total, this.partA, this.partB);
  final String total;
  final String partA;
  final String partB;
}

class ReportType {
  static const amrTestCheck = 'AMR_TEST_CHECK';
  static const netMeter = 'NET_METER';
  static const newConnection = 'NEW_CONNECTION';
  static const all = [amrTestCheck, netMeter, newConnection];
}

class ColumnRole {
  static const removed = 'removed';
  static const amr = 'amr';
  static const existing = 'existing';
  static const billing = 'billing';
  static const backup = 'backup';
  static const backupRemoved = 'backup_removed';
}

class ReportTemplate {
  const ReportTemplate({
    required this.type,
    required this.shortName,
    required this.title,
    required this.columns,
    required this.params,
    required this.totals,
    required this.registerCodes,
    required this.consumptionCodes,
    required this.importInstantCode,
    this.exportInstantCode,
  });

  final String type;
  final String shortName;

  /// Title printed on the form.
  final String title;
  final List<ColumnDef> columns;
  final List<ParamDef> params;
  final List<TotalRule> totals;

  /// Registers that must never go down between visits (energy, cum MDI, resets).
  final List<String> registerCodes;

  /// Registers shown as consumption between visits (x MF) in the history.
  final List<String> consumptionCodes;
  final String importInstantCode;
  final String? exportInstantCode;

  bool get isNet => type == ReportType.netMeter;
  bool get isNewConnection => type == ReportType.newConnection;

  ParamDef param(String code) => params.firstWhere((p) => p.code == code);
  ColumnDef column(String role) => columns.firstWhere((c) => c.role == role);
}

// ---------------------------------------------------------------- AMR / TOU

const _amrParams = [
  ParamDef('date', 'Current Date', ParamKind.date),
  ParamDef('time', 'Current Time', ParamKind.time),
  ParamDef('kwh_total', 'Current Total KWH', ParamKind.number),
  ParamDef('kwh_peak', 'Peak', ParamKind.number),
  ParamDef('kwh_off', 'Off Peak', ParamKind.number),
  ParamDef('kvarh_total', 'Current Total KVARH', ParamKind.number),
  ParamDef('kvarh_peak', 'Peak', ParamKind.number),
  ParamDef('kvarh_off', 'Off Peak', ParamKind.number),
  ParamDef('mdi_total', 'MDI Current', ParamKind.number),
  ParamDef('mdi_peak', 'Peak', ParamKind.number),
  ParamDef('mdi_off', 'Off Peak', ParamKind.number),
  ParamDef('cum_mdi_total', 'CUM (MDI)', ParamKind.number),
  ParamDef('cum_mdi_peak', 'Peak', ParamKind.number),
  ParamDef('cum_mdi_off', 'Off Peak', ParamKind.number),
  ParamDef('reset_no', 'Reset No', ParamKind.integer),
  ParamDef('instant_kw', 'Instant K.W', ParamKind.instantKw),
  ParamDef('avg_pf', 'A.V P.F', ParamKind.pf),
  ParamDef('current_pf', 'Current P.F', ParamKind.pf),
];

const _amrTotals = [
  TotalRule('kwh_total', 'kwh_peak', 'kwh_off'),
  TotalRule('kvarh_total', 'kvarh_peak', 'kvarh_off'),
];

const _amrRegisters = [
  'kwh_total',
  'kwh_peak',
  'kwh_off',
  'kvarh_total',
  'kvarh_peak',
  'kvarh_off',
  'cum_mdi_total',
  'cum_mdi_peak',
  'cum_mdi_off',
  'reset_no',
];

// ---------------------------------------------------------------- NET METER

const _netParams = [
  ParamDef('meter_no', 'Meter No', ParamKind.meterNo, number: 1),
  ParamDef('date', 'Current Date', ParamKind.date, number: 2),
  ParamDef('time', 'Current Time', ParamKind.time, number: 3),
  ParamDef('imp_kwh_total', 'Import active Energy Total', ParamKind.number,
      number: 4),
  ParamDef('exp_kwh_total', 'Export active Energy Total', ParamKind.number,
      number: 5),
  ParamDef('imp_kwh_t1', 'Import active Energy T-1', ParamKind.number,
      number: 6),
  ParamDef('exp_kwh_t1', 'Export active Energy T-1', ParamKind.number,
      number: 7),
  ParamDef('imp_kwh_t2', 'Import active Energy T-2', ParamKind.number,
      number: 8),
  ParamDef('exp_kwh_t2', 'Export active Energy T-2', ParamKind.number,
      number: 9),
  ParamDef('imp_kvarh_total', 'Import reactive Energy Total', ParamKind.number,
      number: 10),
  ParamDef('exp_kvarh_total', 'Export reactive Energy Total', ParamKind.number,
      number: 11),
  ParamDef('imp_kvarh_t1', 'Import reactive Energy T-1', ParamKind.number,
      number: 12),
  ParamDef('exp_kvarh_t1', 'Export reactive Energy T-1', ParamKind.number,
      number: 13),
  ParamDef('imp_kvarh_t2', 'Import reactive Energy T-2', ParamKind.number,
      number: 14),
  ParamDef('exp_kvarh_t2', 'Export reactive Energy T-2', ParamKind.number,
      number: 15),
  ParamDef('imp_mdi_total', 'Import active MDI Total', ParamKind.number,
      number: 16),
  ParamDef('exp_mdi_total', 'Export active MDI Total', ParamKind.number,
      number: 17),
  ParamDef('imp_mdi_t1', 'Import active MDI T-1', ParamKind.number,
      number: 18),
  ParamDef('exp_mdi_t1', 'Export active MDI T-1', ParamKind.number,
      number: 19),
  ParamDef('imp_mdi_t2', 'Import active MDI T-2', ParamKind.number,
      number: 20),
  ParamDef('exp_mdi_t2', 'Export active MDI T-2', ParamKind.number,
      number: 21),
  ParamDef('imp_cum_mdi_total', 'Import active Cum MDI Total', ParamKind.number,
      number: 22),
  ParamDef('exp_cum_mdi_total', 'Export active Cum MDI Total', ParamKind.number,
      number: 23),
  ParamDef('imp_cum_mdi_t1', 'Import active Cum MDI T-1', ParamKind.number,
      number: 24),
  ParamDef('exp_cum_mdi_t1', 'Export active Cum MDI T-1', ParamKind.number,
      number: 25),
  ParamDef('imp_cum_mdi_t2', 'Import active Cum MDI T-2', ParamKind.number,
      number: 26),
  ParamDef('exp_cum_mdi_t2', 'Export active Cum MDI T-2', ParamKind.number,
      number: 27),
  ParamDef('resets_no', 'Resets No', ParamKind.integer, number: 28),
  ParamDef('imp_instant_kw', 'Import Instant Total active KW',
      ParamKind.instantKw,
      number: 29),
  ParamDef('exp_instant_kw', 'Export Instant Total active KW',
      ParamKind.instantKw,
      number: 30),
];

const _netTotals = [
  TotalRule('imp_kwh_total', 'imp_kwh_t1', 'imp_kwh_t2'),
  TotalRule('exp_kwh_total', 'exp_kwh_t1', 'exp_kwh_t2'),
  TotalRule('imp_kvarh_total', 'imp_kvarh_t1', 'imp_kvarh_t2'),
  TotalRule('exp_kvarh_total', 'exp_kvarh_t1', 'exp_kvarh_t2'),
];

const _netRegisters = [
  'imp_kwh_total',
  'exp_kwh_total',
  'imp_kwh_t1',
  'exp_kwh_t1',
  'imp_kwh_t2',
  'exp_kwh_t2',
  'imp_kvarh_total',
  'exp_kvarh_total',
  'imp_kvarh_t1',
  'exp_kvarh_t1',
  'imp_kvarh_t2',
  'exp_kvarh_t2',
  'imp_cum_mdi_total',
  'exp_cum_mdi_total',
  'imp_cum_mdi_t1',
  'exp_cum_mdi_t1',
  'imp_cum_mdi_t2',
  'exp_cum_mdi_t2',
  'resets_no',
];

// ---------------------------------------------------------------- templates

const amrTestCheckTemplate = ReportTemplate(
  type: ReportType.amrTestCheck,
  shortName: 'AMR Test Check',
  title: 'Installation cum Test Check Report of the Metering Equipments',
  columns: [
    ColumnDef(ColumnRole.removed, 'Removed Meter'),
    ColumnDef(ColumnRole.amr, 'AMR Meter'),
    ColumnDef(ColumnRole.existing, 'Installed / Existing Meter'),
  ],
  params: _amrParams,
  totals: _amrTotals,
  registerCodes: _amrRegisters,
  consumptionCodes: ['kwh_total', 'kvarh_total'],
  importInstantCode: 'instant_kw',
);

const newConnectionTemplate = ReportTemplate(
  type: ReportType.newConnection,
  shortName: 'New Connection',
  title: 'Installation Report of the Metering Equipments (New Connection)',
  columns: [
    ColumnDef(ColumnRole.removed, 'Removed Meter', defaultNotApplicable: true),
    ColumnDef(ColumnRole.amr, 'AMR / AMI Meter'),
    ColumnDef(ColumnRole.existing, 'Installed / Existing Meter',
        defaultNotApplicable: true),
  ],
  params: _amrParams,
  totals: _amrTotals,
  registerCodes: _amrRegisters,
  consumptionCodes: ['kwh_total', 'kvarh_total'],
  importInstantCode: 'instant_kw',
);

const netMeterTemplate = ReportTemplate(
  type: ReportType.netMeter,
  shortName: 'Net Meter',
  title: 'Description of Installation of Bi-Direction Meter (Net Meter)',
  columns: [
    ColumnDef(ColumnRole.billing, 'Billing Net Meter'),
    ColumnDef(ColumnRole.backup, 'Backup Net Meter'),
    ColumnDef(ColumnRole.removed, 'Removed Meter', defaultNotApplicable: true),
    ColumnDef(ColumnRole.backupRemoved, 'Removed B/up Meter',
        defaultNotApplicable: true),
  ],
  params: _netParams,
  totals: _netTotals,
  registerCodes: _netRegisters,
  consumptionCodes: ['imp_kwh_total', 'exp_kwh_total'],
  importInstantCode: 'imp_instant_kw',
  exportInstantCode: 'exp_instant_kw',
);

ReportTemplate templateFor(String type) => switch (type) {
      ReportType.netMeter => netMeterTemplate,
      ReportType.newConnection => newConnectionTemplate,
      _ => amrTestCheckTemplate,
    };

// ---------------------------------------------------------------- seals

class SealSpot {
  const SealSpot(this.code, this.label);
  final String code;
  final String label;
}

const sealSpots = [
  SealSpot('TOU_MC', 'TOU M/C'),
  SealSpot('TOU_TC', 'TOU T/C'),
  SealSpot('MSB', 'MSB'),
  SealSpot('MSB_2', ''),
  SealSpot('MSB_GLASS', 'MSB Glass'),
  SealSpot('TFORMER', 'T/Former'),
];

const refTypes = {
  'memo': 'Memo',
  'telephonic': 'Telephonic',
  'seasonal': 'Seasonal Check',
  'routine': 'Routine Check',
};

const meterKinds = ['AMR', 'TOU', 'AMI', 'NET'];

/// Remarks paragraph of a NEW_CONNECTION report (section E).
const newConnectionRemarksTemplate =
    'The Site was visited by the committee of M/S: {consumer_name} on Dated '
    '{visit_date} for installation of New connection vide XEN (OP) '
    '{op_division}. Memo No. {ref_no} Dated {ref_date}, App No. '
    '{application_no} dt {application_date}. SDO (OP) Store challan No. '
    '{store_challan_no} dt. {store_challan_date} SCO No. {sco_no} dt '
    '{sco_date}. The job was carried out and ({new_meter_count}) No. New AMI '
    'Meter install in Separate MSBs with ({ct_count}) no. {ct_ratio} Amp CTs. '
    'After installation the accuracy checked of new installed AMI Meter at '
    '3/Phase Heater Load ({checked_load_kw} KW) and found within permissible '
    'limits of error. Finally MSB Closed / Secured with postal orders duly '
    'signed by the committee mentioned above in this performa. RO / SDO (OP) '
    'is advised to implement the SCO/SJO as per SOP.';
