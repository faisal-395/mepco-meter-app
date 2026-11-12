import '../data/database.dart';
import 'report_templates.dart';

/// One meter column of a report (e.g. "AMR Meter") and its readings.
class ColumnSlot {
  ColumnSlot({
    required this.role,
    this.meter,
    this.notApplicable = false,
    Map<String, String>? readings,
  }) : readings = readings ?? {};

  final String role;
  Meter? meter;
  bool notApplicable;

  /// param code -> value exactly as typed.
  final Map<String, String> readings;

  /// A column is used when it is not marked N/A and has a meter or a reading.
  bool get isUsed =>
      !notApplicable &&
      (meter != null || readings.values.any((v) => v.trim().isNotEmpty));

  ColumnSlot copy() => ColumnSlot(
        role: role,
        meter: meter,
        notApplicable: notApplicable,
        readings: Map.of(readings),
      );
}

class PhaseLoadValues {
  PhaseLoadValues({
    this.volts = '',
    this.amps = '',
    this.pf = '',
    this.kwOverride = '',
  });
  String volts;
  String amps;
  String pf;
  String kwOverride;

  bool get isEmpty =>
      volts.trim().isEmpty &&
      amps.trim().isEmpty &&
      pf.trim().isEmpty &&
      kwOverride.trim().isEmpty;

  PhaseLoadValues copy() => PhaseLoadValues(
      volts: volts, amps: amps, pf: pf, kwOverride: kwOverride);
}

class SealValues {
  SealValues({this.mtSeal = '', this.postalOrder = ''});
  String mtSeal;
  String postalOrder;
  bool get isEmpty => mtSeal.trim().isEmpty && postalOrder.trim().isEmpty;
}

const phases = ['R', 'Y', 'B'];
const loadSides = ['import', 'export'];

String phaseKey(String side, String phase) => '${side}_$phase';
String sealKey(String spot, String role) => '$spot|$role';

/// Everything that makes up one report, loaded and saved as a unit.
class ReportBundle {
  ReportBundle({
    required this.report,
    required this.consumer,
    required this.sectionA,
    required this.columns,
    required this.phaseLoads,
    required this.seals,
  });

  Report report;
  ConsumerRow consumer;

  /// Snapshot of section A for this report (see section_a.dart).
  Map<String, String> sectionA;
  List<ColumnSlot> columns;

  /// key phaseKey(side, phase)
  Map<String, PhaseLoadValues> phaseLoads;

  /// key sealKey(spot, role)
  Map<String, SealValues> seals;

  ReportTemplate get template => templateFor(report.reportType);
  bool get isFinal => report.status == 'final';

  ColumnSlot column(String role) => columns.firstWhere((c) => c.role == role);

  PhaseLoadValues load(String side, String phase) =>
      phaseLoads.putIfAbsent(phaseKey(side, phase), PhaseLoadValues.new);

  SealValues seal(String spot, String role) =>
      seals.putIfAbsent(sealKey(spot, role), SealValues.new);

  /// MF of the installation (section A), as typed.
  String get mfText => sectionA['mf'] ?? '';

  /// Empty column slots for a report type, with default N/A flags.
  static List<ColumnSlot> emptyColumns(String type) => templateFor(type)
      .columns
      .map((c) =>
          ColumnSlot(role: c.role, notApplicable: c.defaultNotApplicable))
      .toList();
}
