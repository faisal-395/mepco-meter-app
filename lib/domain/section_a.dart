import 'package:drift/drift.dart';

import '../data/database.dart';
import 'formatters.dart';

/// One field of section A ("Description of installation").
class SectionAField {
  const SectionAField(
    this.code,
    this.label, {
    this.numeric = false,
    this.date = false,
    this.suggestions = const [],
  });
  final String code;
  final String label;
  final bool numeric;
  final bool date;

  /// Quick-pick values shown as chips under the field.
  final List<String> suggestions;
}

/// A group of fields: one numbered cell of the paper form (or a header block).
class SectionAGroup {
  const SectionAGroup(this.title, this.fields, {this.no});
  final int? no;
  final String title;
  final List<SectionAField> fields;
}

/// Section A as on the paper form: M/S box, office, then cells 1-12.
const sectionAGroups = [
  SectionAGroup('M/S (consumer)', [
    SectionAField('name', 'Name'),
    SectionAField('address', 'Address / place'),
  ]),
  SectionAGroup('Office (OP)', [
    SectionAField('sub_division', 'Sub Division'),
    SectionAField('op_division', 'Division'),
  ]),
  SectionAGroup('Application No & Date', no: 1, [
    SectionAField('application_no', 'Application No'),
    SectionAField('application_date', 'Date', date: true),
  ]),
  SectionAGroup('A/C No & Tariff', no: 2, [
    SectionAField('account_no', 'A/C No'),
    SectionAField(
      'tariff',
      'Tariff',
      suggestions: ['A1', 'A2', 'A3', 'B1', 'B2', 'B3'],
    ),
  ]),
  SectionAGroup('Sanctioned by SE/XEN No & Date', no: 3, [
    SectionAField('sanction_ref', 'No & Date'),
  ]),
  SectionAGroup('Sanction Load', no: 4, [
    SectionAField('sanctioned_load_kw', 'Load (Kw)', numeric: true),
  ]),
  SectionAGroup('SCO / MCO / RCO No & Date', no: 5, [
    SectionAField('sco_mco_rco_no', 'No'),
    SectionAField('sco_date', 'Date', date: true),
  ]),
  SectionAGroup('Kind of Industry', no: 6, [
    SectionAField('industry_kind', 'Kind of Industry'),
  ]),
  SectionAGroup('Capacity of Transformer & Make', no: 7, [
    SectionAField(
      'transformer_kva',
      'KVA',
      numeric: true,
      suggestions: ['25', '50', '100', '200', '400', '630'],
    ),
    SectionAField('transformer_make', 'Make', suggestions: ['PEL', 'Siemens']),
  ]),
  SectionAGroup('Size of Cable', no: 8, [
    SectionAField(
      'cable_size',
      'Cable',
      suggestions: ['19/0.083', '37/0.083', '37/0.103'],
    ),
  ]),
  SectionAGroup('CT Ratio & VA Burden', no: 9, [
    SectionAField(
      'ct_primary',
      'CT Primary (A)',
      numeric: true,
      suggestions: ['100', '200', '300', '400', '600'],
    ),
    SectionAField('ct_secondary', 'CT Secondary (A)', numeric: true),
    SectionAField('ct_va_burden', 'VA Burden'),
    SectionAField('mf', 'M.F', numeric: true),
  ]),
  SectionAGroup('Type of MSB', no: 10, [
    SectionAField(
      'msb_type',
      'Type of MSB',
      suggestions: ['"A" Type New', '"B" Type New', '"A" Type Old'],
    ),
  ]),
  SectionAGroup('Connected Load / T/F No', no: 11, [
    SectionAField('connected_load', 'Connected Load'),
    SectionAField('transformer_no', 'T/F No'),
  ]),
  SectionAGroup('Feeder Name', no: 12, [
    SectionAField('feeder_name', 'Feeder Name'),
  ]),
];

/// All section A fields (flat), in form order.
final sectionAFields = [for (final g in sectionAGroups) ...g.fields];

String _v(Map<String, String> a, String k) => (a[k] ?? '').trim();

/// "100/5A" (and the VA burden if given).
String ctRatioText(Map<String, String> a) {
  final p = _v(a, 'ct_primary'), s = _v(a, 'ct_secondary');
  if (p.isEmpty && s.isEmpty) return '';
  final b = _v(a, 'ct_va_burden');
  return '$p/${s}A${b.isEmpty ? '' : ' $b'}';
}

/// Builds the section A snapshot from a consumer row.
Map<String, String> sectionAFromConsumer(ConsumerRow c) => {
  'name': c.name,
  'address': c.address,
  'account_no': c.accountNo,
  'tariff': c.tariff,
  'sanctioned_load_kw': c.sanctionedLoadKw,
  'connected_load': c.connectedLoad,
  'industry_kind': c.industryKind,
  'transformer_kva': c.transformerKva,
  'transformer_make': c.transformerMake,
  'transformer_no': c.transformerNo,
  'ct_primary': c.ctPrimary,
  'ct_secondary': c.ctSecondary,
  'ct_va_burden': c.ctVaBurden,
  'mf': c.mf,
  'cable_size': c.cableSize,
  'msb_type': c.msbType,
  'feeder_name': c.feederName,
  'sub_division': c.subDivision,
  'op_division': c.opDivision,
  'sanction_ref': c.sanctionRef,
  'application_no': c.applicationNo,
  'application_date': fmtDate(c.applicationDate),
  'sco_mco_rco_no': c.scoMcoRcoNo,
  'sco_date': fmtDate(c.scoDate),
};

/// Turns a section A snapshot back into consumer column values.
ConsumersCompanion consumerCompanionFromSectionA(Map<String, String> a) {
  String g(String k) => a[k] ?? '';
  return ConsumersCompanion(
    name: Value(g('name')),
    address: Value(g('address')),
    accountNo: Value(g('account_no')),
    tariff: Value(g('tariff')),
    sanctionedLoadKw: Value(g('sanctioned_load_kw')),
    connectedLoad: Value(g('connected_load')),
    industryKind: Value(g('industry_kind')),
    transformerKva: Value(g('transformer_kva')),
    transformerMake: Value(g('transformer_make')),
    transformerNo: Value(g('transformer_no')),
    ctPrimary: Value(g('ct_primary')),
    ctSecondary: Value(g('ct_secondary')),
    ctVaBurden: Value(g('ct_va_burden')),
    mf: Value(g('mf')),
    cableSize: Value(g('cable_size')),
    msbType: Value(g('msb_type')),
    feederName: Value(g('feeder_name')),
    subDivision: Value(g('sub_division')),
    opDivision: Value(g('op_division')),
    sanctionRef: Value(g('sanction_ref')),
    applicationNo: Value(g('application_no')),
    applicationDate: Value(parseDate(g('application_date'))),
    scoMcoRcoNo: Value(g('sco_mco_rco_no')),
    scoDate: Value(parseDate(g('sco_date'))),
    updatedAt: Value(DateTime.now()),
  );
}
