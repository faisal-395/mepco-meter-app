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
  });
  final String code;
  final String label;
  final bool numeric;
  final bool date;
}

/// All consumer fields kept in a report's section A snapshot, in form order.
const sectionAFields = [
  SectionAField('name', 'Name (M/S)'),
  SectionAField('address', 'Address'),
  SectionAField('account_no', 'A/C No'),
  SectionAField('tariff', 'Tariff'),
  SectionAField('sanctioned_load_kw', 'Sanctioned Load (KW)', numeric: true),
  SectionAField('connected_load', 'Connected Load'),
  SectionAField('industry_kind', 'Kind of Industry'),
  SectionAField('transformer_kva', 'Transformer (KVA)'),
  SectionAField('transformer_make', 'Transformer Make'),
  SectionAField('transformer_no', 'T/F No'),
  SectionAField('ct_primary', 'CT Primary (A)', numeric: true),
  SectionAField('ct_secondary', 'CT Secondary (A)', numeric: true),
  SectionAField('mf', 'M.F', numeric: true),
  SectionAField('cable_size', 'Cable Size'),
  SectionAField('msb_type', 'MSB Type'),
  SectionAField('feeder_name', 'Feeder Name'),
  SectionAField('sub_division', 'Sub Division'),
  SectionAField('op_division', 'Division (OP)'),
  SectionAField('sanction_ref', 'Sanction Ref (SE/XEN No & Date)'),
  SectionAField('application_no', 'Application No'),
  SectionAField('application_date', 'Application Date', date: true),
  SectionAField('sco_mco_rco_no', 'SCO/MCO/RCO No'),
  SectionAField('sco_date', 'SCO Date', date: true),
];

/// The 12 numbered cells printed in section A.
class SectionACell {
  const SectionACell(this.no, this.label, this.value);
  final int no;
  final String label;
  final String Function(Map<String, String> a) value;
}

String _v(Map<String, String> a, String k) => a[k] ?? '';

String ctRatioText(Map<String, String> a) {
  final p = _v(a, 'ct_primary'), s = _v(a, 'ct_secondary');
  if (p.isEmpty && s.isEmpty) return '';
  return '$p/$s';
}

final sectionACells = [
  SectionACell(1, 'Name & Address', (a) {
    final n = _v(a, 'name'), ad = _v(a, 'address');
    return ad.isEmpty ? n : '$n, $ad';
  }),
  SectionACell(2, 'A/C No & Tariff', (a) {
    final t = _v(a, 'tariff');
    return t.isEmpty ? _v(a, 'account_no') : '${_v(a, 'account_no')} / $t';
  }),
  SectionACell(3, 'Sanctioned Load', (a) {
    final s = _v(a, 'sanctioned_load_kw');
    return s.isEmpty ? '' : '$s KW';
  }),
  SectionACell(4, 'Connected Load', (a) => _v(a, 'connected_load')),
  SectionACell(5, 'Kind of Industry', (a) => _v(a, 'industry_kind')),
  SectionACell(6, 'Transformer Capacity', (a) {
    final k = _v(a, 'transformer_kva'), mk = _v(a, 'transformer_make');
    final kv = k.isEmpty ? '' : '$k KVA';
    return mk.isEmpty ? kv : '$kv ($mk)';
  }),
  SectionACell(7, 'T/F No', (a) => _v(a, 'transformer_no')),
  SectionACell(8, 'C.T Ratio', (a) {
    final r = ctRatioText(a);
    return r.isEmpty ? '' : '$r A';
  }),
  SectionACell(9, 'M.F', (a) => _v(a, 'mf')),
  SectionACell(10, 'Cable Size', (a) => _v(a, 'cable_size')),
  SectionACell(11, 'MSB Type', (a) => _v(a, 'msb_type')),
  SectionACell(12, 'Feeder / Sub Division', (a) {
    final f = _v(a, 'feeder_name'), s = _v(a, 'sub_division');
    if (f.isEmpty) return s;
    if (s.isEmpty) return f;
    return '$f / $s';
  }),
];

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
