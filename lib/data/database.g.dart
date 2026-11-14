// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ConsumersTable extends Consumers
    with TableInfo<$ConsumersTable, ConsumerRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ConsumersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _accountNoMeta = const VerificationMeta(
    'accountNo',
  );
  @override
  late final GeneratedColumn<String> accountNo = GeneratedColumn<String>(
    'account_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _tariffMeta = const VerificationMeta('tariff');
  @override
  late final GeneratedColumn<String> tariff = GeneratedColumn<String>(
    'tariff',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _addressMeta = const VerificationMeta(
    'address',
  );
  @override
  late final GeneratedColumn<String> address = GeneratedColumn<String>(
    'address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _subDivisionMeta = const VerificationMeta(
    'subDivision',
  );
  @override
  late final GeneratedColumn<String> subDivision = GeneratedColumn<String>(
    'sub_division',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _opDivisionMeta = const VerificationMeta(
    'opDivision',
  );
  @override
  late final GeneratedColumn<String> opDivision = GeneratedColumn<String>(
    'op_division',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sanctionedLoadKwMeta = const VerificationMeta(
    'sanctionedLoadKw',
  );
  @override
  late final GeneratedColumn<String> sanctionedLoadKw = GeneratedColumn<String>(
    'sanctioned_load_kw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _connectedLoadMeta = const VerificationMeta(
    'connectedLoad',
  );
  @override
  late final GeneratedColumn<String> connectedLoad = GeneratedColumn<String>(
    'connected_load',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _industryKindMeta = const VerificationMeta(
    'industryKind',
  );
  @override
  late final GeneratedColumn<String> industryKind = GeneratedColumn<String>(
    'industry_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _transformerKvaMeta = const VerificationMeta(
    'transformerKva',
  );
  @override
  late final GeneratedColumn<String> transformerKva = GeneratedColumn<String>(
    'transformer_kva',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _transformerMakeMeta = const VerificationMeta(
    'transformerMake',
  );
  @override
  late final GeneratedColumn<String> transformerMake = GeneratedColumn<String>(
    'transformer_make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _transformerNoMeta = const VerificationMeta(
    'transformerNo',
  );
  @override
  late final GeneratedColumn<String> transformerNo = GeneratedColumn<String>(
    'transformer_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ctPrimaryMeta = const VerificationMeta(
    'ctPrimary',
  );
  @override
  late final GeneratedColumn<String> ctPrimary = GeneratedColumn<String>(
    'ct_primary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ctSecondaryMeta = const VerificationMeta(
    'ctSecondary',
  );
  @override
  late final GeneratedColumn<String> ctSecondary = GeneratedColumn<String>(
    'ct_secondary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ctVaBurdenMeta = const VerificationMeta(
    'ctVaBurden',
  );
  @override
  late final GeneratedColumn<String> ctVaBurden = GeneratedColumn<String>(
    'ct_va_burden',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _mfMeta = const VerificationMeta('mf');
  @override
  late final GeneratedColumn<String> mf = GeneratedColumn<String>(
    'mf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _cableSizeMeta = const VerificationMeta(
    'cableSize',
  );
  @override
  late final GeneratedColumn<String> cableSize = GeneratedColumn<String>(
    'cable_size',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _msbTypeMeta = const VerificationMeta(
    'msbType',
  );
  @override
  late final GeneratedColumn<String> msbType = GeneratedColumn<String>(
    'msb_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _feederNameMeta = const VerificationMeta(
    'feederName',
  );
  @override
  late final GeneratedColumn<String> feederName = GeneratedColumn<String>(
    'feeder_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _applicationNoMeta = const VerificationMeta(
    'applicationNo',
  );
  @override
  late final GeneratedColumn<String> applicationNo = GeneratedColumn<String>(
    'application_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _applicationDateMeta = const VerificationMeta(
    'applicationDate',
  );
  @override
  late final GeneratedColumn<DateTime> applicationDate =
      GeneratedColumn<DateTime>(
        'application_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sanctionRefMeta = const VerificationMeta(
    'sanctionRef',
  );
  @override
  late final GeneratedColumn<String> sanctionRef = GeneratedColumn<String>(
    'sanction_ref',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sanctionDateMeta = const VerificationMeta(
    'sanctionDate',
  );
  @override
  late final GeneratedColumn<DateTime> sanctionDate = GeneratedColumn<DateTime>(
    'sanction_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoMcoRcoNoMeta = const VerificationMeta(
    'scoMcoRcoNo',
  );
  @override
  late final GeneratedColumn<String> scoMcoRcoNo = GeneratedColumn<String>(
    'sco_mco_rco_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _scoDateMeta = const VerificationMeta(
    'scoDate',
  );
  @override
  late final GeneratedColumn<DateTime> scoDate = GeneratedColumn<DateTime>(
    'sco_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    accountNo,
    tariff,
    name,
    address,
    subDivision,
    opDivision,
    sanctionedLoadKw,
    connectedLoad,
    industryKind,
    transformerKva,
    transformerMake,
    transformerNo,
    ctPrimary,
    ctSecondary,
    ctVaBurden,
    mf,
    cableSize,
    msbType,
    feederName,
    applicationNo,
    applicationDate,
    sanctionRef,
    sanctionDate,
    scoMcoRcoNo,
    scoDate,
    notes,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'consumers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ConsumerRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('account_no')) {
      context.handle(
        _accountNoMeta,
        accountNo.isAcceptableOrUnknown(data['account_no']!, _accountNoMeta),
      );
    } else if (isInserting) {
      context.missing(_accountNoMeta);
    }
    if (data.containsKey('tariff')) {
      context.handle(
        _tariffMeta,
        tariff.isAcceptableOrUnknown(data['tariff']!, _tariffMeta),
      );
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    }
    if (data.containsKey('address')) {
      context.handle(
        _addressMeta,
        address.isAcceptableOrUnknown(data['address']!, _addressMeta),
      );
    }
    if (data.containsKey('sub_division')) {
      context.handle(
        _subDivisionMeta,
        subDivision.isAcceptableOrUnknown(
          data['sub_division']!,
          _subDivisionMeta,
        ),
      );
    }
    if (data.containsKey('op_division')) {
      context.handle(
        _opDivisionMeta,
        opDivision.isAcceptableOrUnknown(data['op_division']!, _opDivisionMeta),
      );
    }
    if (data.containsKey('sanctioned_load_kw')) {
      context.handle(
        _sanctionedLoadKwMeta,
        sanctionedLoadKw.isAcceptableOrUnknown(
          data['sanctioned_load_kw']!,
          _sanctionedLoadKwMeta,
        ),
      );
    }
    if (data.containsKey('connected_load')) {
      context.handle(
        _connectedLoadMeta,
        connectedLoad.isAcceptableOrUnknown(
          data['connected_load']!,
          _connectedLoadMeta,
        ),
      );
    }
    if (data.containsKey('industry_kind')) {
      context.handle(
        _industryKindMeta,
        industryKind.isAcceptableOrUnknown(
          data['industry_kind']!,
          _industryKindMeta,
        ),
      );
    }
    if (data.containsKey('transformer_kva')) {
      context.handle(
        _transformerKvaMeta,
        transformerKva.isAcceptableOrUnknown(
          data['transformer_kva']!,
          _transformerKvaMeta,
        ),
      );
    }
    if (data.containsKey('transformer_make')) {
      context.handle(
        _transformerMakeMeta,
        transformerMake.isAcceptableOrUnknown(
          data['transformer_make']!,
          _transformerMakeMeta,
        ),
      );
    }
    if (data.containsKey('transformer_no')) {
      context.handle(
        _transformerNoMeta,
        transformerNo.isAcceptableOrUnknown(
          data['transformer_no']!,
          _transformerNoMeta,
        ),
      );
    }
    if (data.containsKey('ct_primary')) {
      context.handle(
        _ctPrimaryMeta,
        ctPrimary.isAcceptableOrUnknown(data['ct_primary']!, _ctPrimaryMeta),
      );
    }
    if (data.containsKey('ct_secondary')) {
      context.handle(
        _ctSecondaryMeta,
        ctSecondary.isAcceptableOrUnknown(
          data['ct_secondary']!,
          _ctSecondaryMeta,
        ),
      );
    }
    if (data.containsKey('ct_va_burden')) {
      context.handle(
        _ctVaBurdenMeta,
        ctVaBurden.isAcceptableOrUnknown(
          data['ct_va_burden']!,
          _ctVaBurdenMeta,
        ),
      );
    }
    if (data.containsKey('mf')) {
      context.handle(_mfMeta, mf.isAcceptableOrUnknown(data['mf']!, _mfMeta));
    }
    if (data.containsKey('cable_size')) {
      context.handle(
        _cableSizeMeta,
        cableSize.isAcceptableOrUnknown(data['cable_size']!, _cableSizeMeta),
      );
    }
    if (data.containsKey('msb_type')) {
      context.handle(
        _msbTypeMeta,
        msbType.isAcceptableOrUnknown(data['msb_type']!, _msbTypeMeta),
      );
    }
    if (data.containsKey('feeder_name')) {
      context.handle(
        _feederNameMeta,
        feederName.isAcceptableOrUnknown(data['feeder_name']!, _feederNameMeta),
      );
    }
    if (data.containsKey('application_no')) {
      context.handle(
        _applicationNoMeta,
        applicationNo.isAcceptableOrUnknown(
          data['application_no']!,
          _applicationNoMeta,
        ),
      );
    }
    if (data.containsKey('application_date')) {
      context.handle(
        _applicationDateMeta,
        applicationDate.isAcceptableOrUnknown(
          data['application_date']!,
          _applicationDateMeta,
        ),
      );
    }
    if (data.containsKey('sanction_ref')) {
      context.handle(
        _sanctionRefMeta,
        sanctionRef.isAcceptableOrUnknown(
          data['sanction_ref']!,
          _sanctionRefMeta,
        ),
      );
    }
    if (data.containsKey('sanction_date')) {
      context.handle(
        _sanctionDateMeta,
        sanctionDate.isAcceptableOrUnknown(
          data['sanction_date']!,
          _sanctionDateMeta,
        ),
      );
    }
    if (data.containsKey('sco_mco_rco_no')) {
      context.handle(
        _scoMcoRcoNoMeta,
        scoMcoRcoNo.isAcceptableOrUnknown(
          data['sco_mco_rco_no']!,
          _scoMcoRcoNoMeta,
        ),
      );
    }
    if (data.containsKey('sco_date')) {
      context.handle(
        _scoDateMeta,
        scoDate.isAcceptableOrUnknown(data['sco_date']!, _scoDateMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ConsumerRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ConsumerRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      accountNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}account_no'],
      )!,
      tariff: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tariff'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      address: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}address'],
      )!,
      subDivision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sub_division'],
      )!,
      opDivision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}op_division'],
      )!,
      sanctionedLoadKw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sanctioned_load_kw'],
      )!,
      connectedLoad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}connected_load'],
      )!,
      industryKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}industry_kind'],
      )!,
      transformerKva: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transformer_kva'],
      )!,
      transformerMake: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transformer_make'],
      )!,
      transformerNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transformer_no'],
      )!,
      ctPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ct_primary'],
      )!,
      ctSecondary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ct_secondary'],
      )!,
      ctVaBurden: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ct_va_burden'],
      )!,
      mf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mf'],
      )!,
      cableSize: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cable_size'],
      )!,
      msbType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}msb_type'],
      )!,
      feederName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}feeder_name'],
      )!,
      applicationNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}application_no'],
      )!,
      applicationDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}application_date'],
      ),
      sanctionRef: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sanction_ref'],
      )!,
      sanctionDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sanction_date'],
      ),
      scoMcoRcoNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sco_mco_rco_no'],
      )!,
      scoDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}sco_date'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ConsumersTable createAlias(String alias) {
    return $ConsumersTable(attachedDatabase, alias);
  }
}

class ConsumerRow extends DataClass implements Insertable<ConsumerRow> {
  final int id;
  final String accountNo;
  final String tariff;
  final String name;
  final String address;
  final String subDivision;
  final String opDivision;
  final String sanctionedLoadKw;
  final String connectedLoad;
  final String industryKind;
  final String transformerKva;
  final String transformerMake;
  final String transformerNo;
  final String ctPrimary;
  final String ctSecondary;

  /// Added in schema v2: "VA Burden" of the CTs (section A cell 9).
  final String ctVaBurden;
  final String mf;
  final String cableSize;
  final String msbType;
  final String feederName;
  final String applicationNo;
  final DateTime? applicationDate;
  final String sanctionRef;

  /// Added in schema v3: date of the SE/XEN sanction (cell 3).
  final DateTime? sanctionDate;
  final String scoMcoRcoNo;
  final DateTime? scoDate;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;
  const ConsumerRow({
    required this.id,
    required this.accountNo,
    required this.tariff,
    required this.name,
    required this.address,
    required this.subDivision,
    required this.opDivision,
    required this.sanctionedLoadKw,
    required this.connectedLoad,
    required this.industryKind,
    required this.transformerKva,
    required this.transformerMake,
    required this.transformerNo,
    required this.ctPrimary,
    required this.ctSecondary,
    required this.ctVaBurden,
    required this.mf,
    required this.cableSize,
    required this.msbType,
    required this.feederName,
    required this.applicationNo,
    this.applicationDate,
    required this.sanctionRef,
    this.sanctionDate,
    required this.scoMcoRcoNo,
    this.scoDate,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['account_no'] = Variable<String>(accountNo);
    map['tariff'] = Variable<String>(tariff);
    map['name'] = Variable<String>(name);
    map['address'] = Variable<String>(address);
    map['sub_division'] = Variable<String>(subDivision);
    map['op_division'] = Variable<String>(opDivision);
    map['sanctioned_load_kw'] = Variable<String>(sanctionedLoadKw);
    map['connected_load'] = Variable<String>(connectedLoad);
    map['industry_kind'] = Variable<String>(industryKind);
    map['transformer_kva'] = Variable<String>(transformerKva);
    map['transformer_make'] = Variable<String>(transformerMake);
    map['transformer_no'] = Variable<String>(transformerNo);
    map['ct_primary'] = Variable<String>(ctPrimary);
    map['ct_secondary'] = Variable<String>(ctSecondary);
    map['ct_va_burden'] = Variable<String>(ctVaBurden);
    map['mf'] = Variable<String>(mf);
    map['cable_size'] = Variable<String>(cableSize);
    map['msb_type'] = Variable<String>(msbType);
    map['feeder_name'] = Variable<String>(feederName);
    map['application_no'] = Variable<String>(applicationNo);
    if (!nullToAbsent || applicationDate != null) {
      map['application_date'] = Variable<DateTime>(applicationDate);
    }
    map['sanction_ref'] = Variable<String>(sanctionRef);
    if (!nullToAbsent || sanctionDate != null) {
      map['sanction_date'] = Variable<DateTime>(sanctionDate);
    }
    map['sco_mco_rco_no'] = Variable<String>(scoMcoRcoNo);
    if (!nullToAbsent || scoDate != null) {
      map['sco_date'] = Variable<DateTime>(scoDate);
    }
    map['notes'] = Variable<String>(notes);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ConsumersCompanion toCompanion(bool nullToAbsent) {
    return ConsumersCompanion(
      id: Value(id),
      accountNo: Value(accountNo),
      tariff: Value(tariff),
      name: Value(name),
      address: Value(address),
      subDivision: Value(subDivision),
      opDivision: Value(opDivision),
      sanctionedLoadKw: Value(sanctionedLoadKw),
      connectedLoad: Value(connectedLoad),
      industryKind: Value(industryKind),
      transformerKva: Value(transformerKva),
      transformerMake: Value(transformerMake),
      transformerNo: Value(transformerNo),
      ctPrimary: Value(ctPrimary),
      ctSecondary: Value(ctSecondary),
      ctVaBurden: Value(ctVaBurden),
      mf: Value(mf),
      cableSize: Value(cableSize),
      msbType: Value(msbType),
      feederName: Value(feederName),
      applicationNo: Value(applicationNo),
      applicationDate: applicationDate == null && nullToAbsent
          ? const Value.absent()
          : Value(applicationDate),
      sanctionRef: Value(sanctionRef),
      sanctionDate: sanctionDate == null && nullToAbsent
          ? const Value.absent()
          : Value(sanctionDate),
      scoMcoRcoNo: Value(scoMcoRcoNo),
      scoDate: scoDate == null && nullToAbsent
          ? const Value.absent()
          : Value(scoDate),
      notes: Value(notes),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory ConsumerRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ConsumerRow(
      id: serializer.fromJson<int>(json['id']),
      accountNo: serializer.fromJson<String>(json['accountNo']),
      tariff: serializer.fromJson<String>(json['tariff']),
      name: serializer.fromJson<String>(json['name']),
      address: serializer.fromJson<String>(json['address']),
      subDivision: serializer.fromJson<String>(json['subDivision']),
      opDivision: serializer.fromJson<String>(json['opDivision']),
      sanctionedLoadKw: serializer.fromJson<String>(json['sanctionedLoadKw']),
      connectedLoad: serializer.fromJson<String>(json['connectedLoad']),
      industryKind: serializer.fromJson<String>(json['industryKind']),
      transformerKva: serializer.fromJson<String>(json['transformerKva']),
      transformerMake: serializer.fromJson<String>(json['transformerMake']),
      transformerNo: serializer.fromJson<String>(json['transformerNo']),
      ctPrimary: serializer.fromJson<String>(json['ctPrimary']),
      ctSecondary: serializer.fromJson<String>(json['ctSecondary']),
      ctVaBurden: serializer.fromJson<String>(json['ctVaBurden']),
      mf: serializer.fromJson<String>(json['mf']),
      cableSize: serializer.fromJson<String>(json['cableSize']),
      msbType: serializer.fromJson<String>(json['msbType']),
      feederName: serializer.fromJson<String>(json['feederName']),
      applicationNo: serializer.fromJson<String>(json['applicationNo']),
      applicationDate: serializer.fromJson<DateTime?>(json['applicationDate']),
      sanctionRef: serializer.fromJson<String>(json['sanctionRef']),
      sanctionDate: serializer.fromJson<DateTime?>(json['sanctionDate']),
      scoMcoRcoNo: serializer.fromJson<String>(json['scoMcoRcoNo']),
      scoDate: serializer.fromJson<DateTime?>(json['scoDate']),
      notes: serializer.fromJson<String>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'accountNo': serializer.toJson<String>(accountNo),
      'tariff': serializer.toJson<String>(tariff),
      'name': serializer.toJson<String>(name),
      'address': serializer.toJson<String>(address),
      'subDivision': serializer.toJson<String>(subDivision),
      'opDivision': serializer.toJson<String>(opDivision),
      'sanctionedLoadKw': serializer.toJson<String>(sanctionedLoadKw),
      'connectedLoad': serializer.toJson<String>(connectedLoad),
      'industryKind': serializer.toJson<String>(industryKind),
      'transformerKva': serializer.toJson<String>(transformerKva),
      'transformerMake': serializer.toJson<String>(transformerMake),
      'transformerNo': serializer.toJson<String>(transformerNo),
      'ctPrimary': serializer.toJson<String>(ctPrimary),
      'ctSecondary': serializer.toJson<String>(ctSecondary),
      'ctVaBurden': serializer.toJson<String>(ctVaBurden),
      'mf': serializer.toJson<String>(mf),
      'cableSize': serializer.toJson<String>(cableSize),
      'msbType': serializer.toJson<String>(msbType),
      'feederName': serializer.toJson<String>(feederName),
      'applicationNo': serializer.toJson<String>(applicationNo),
      'applicationDate': serializer.toJson<DateTime?>(applicationDate),
      'sanctionRef': serializer.toJson<String>(sanctionRef),
      'sanctionDate': serializer.toJson<DateTime?>(sanctionDate),
      'scoMcoRcoNo': serializer.toJson<String>(scoMcoRcoNo),
      'scoDate': serializer.toJson<DateTime?>(scoDate),
      'notes': serializer.toJson<String>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ConsumerRow copyWith({
    int? id,
    String? accountNo,
    String? tariff,
    String? name,
    String? address,
    String? subDivision,
    String? opDivision,
    String? sanctionedLoadKw,
    String? connectedLoad,
    String? industryKind,
    String? transformerKva,
    String? transformerMake,
    String? transformerNo,
    String? ctPrimary,
    String? ctSecondary,
    String? ctVaBurden,
    String? mf,
    String? cableSize,
    String? msbType,
    String? feederName,
    String? applicationNo,
    Value<DateTime?> applicationDate = const Value.absent(),
    String? sanctionRef,
    Value<DateTime?> sanctionDate = const Value.absent(),
    String? scoMcoRcoNo,
    Value<DateTime?> scoDate = const Value.absent(),
    String? notes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => ConsumerRow(
    id: id ?? this.id,
    accountNo: accountNo ?? this.accountNo,
    tariff: tariff ?? this.tariff,
    name: name ?? this.name,
    address: address ?? this.address,
    subDivision: subDivision ?? this.subDivision,
    opDivision: opDivision ?? this.opDivision,
    sanctionedLoadKw: sanctionedLoadKw ?? this.sanctionedLoadKw,
    connectedLoad: connectedLoad ?? this.connectedLoad,
    industryKind: industryKind ?? this.industryKind,
    transformerKva: transformerKva ?? this.transformerKva,
    transformerMake: transformerMake ?? this.transformerMake,
    transformerNo: transformerNo ?? this.transformerNo,
    ctPrimary: ctPrimary ?? this.ctPrimary,
    ctSecondary: ctSecondary ?? this.ctSecondary,
    ctVaBurden: ctVaBurden ?? this.ctVaBurden,
    mf: mf ?? this.mf,
    cableSize: cableSize ?? this.cableSize,
    msbType: msbType ?? this.msbType,
    feederName: feederName ?? this.feederName,
    applicationNo: applicationNo ?? this.applicationNo,
    applicationDate: applicationDate.present
        ? applicationDate.value
        : this.applicationDate,
    sanctionRef: sanctionRef ?? this.sanctionRef,
    sanctionDate: sanctionDate.present ? sanctionDate.value : this.sanctionDate,
    scoMcoRcoNo: scoMcoRcoNo ?? this.scoMcoRcoNo,
    scoDate: scoDate.present ? scoDate.value : this.scoDate,
    notes: notes ?? this.notes,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ConsumerRow copyWithCompanion(ConsumersCompanion data) {
    return ConsumerRow(
      id: data.id.present ? data.id.value : this.id,
      accountNo: data.accountNo.present ? data.accountNo.value : this.accountNo,
      tariff: data.tariff.present ? data.tariff.value : this.tariff,
      name: data.name.present ? data.name.value : this.name,
      address: data.address.present ? data.address.value : this.address,
      subDivision: data.subDivision.present
          ? data.subDivision.value
          : this.subDivision,
      opDivision: data.opDivision.present
          ? data.opDivision.value
          : this.opDivision,
      sanctionedLoadKw: data.sanctionedLoadKw.present
          ? data.sanctionedLoadKw.value
          : this.sanctionedLoadKw,
      connectedLoad: data.connectedLoad.present
          ? data.connectedLoad.value
          : this.connectedLoad,
      industryKind: data.industryKind.present
          ? data.industryKind.value
          : this.industryKind,
      transformerKva: data.transformerKva.present
          ? data.transformerKva.value
          : this.transformerKva,
      transformerMake: data.transformerMake.present
          ? data.transformerMake.value
          : this.transformerMake,
      transformerNo: data.transformerNo.present
          ? data.transformerNo.value
          : this.transformerNo,
      ctPrimary: data.ctPrimary.present ? data.ctPrimary.value : this.ctPrimary,
      ctSecondary: data.ctSecondary.present
          ? data.ctSecondary.value
          : this.ctSecondary,
      ctVaBurden: data.ctVaBurden.present
          ? data.ctVaBurden.value
          : this.ctVaBurden,
      mf: data.mf.present ? data.mf.value : this.mf,
      cableSize: data.cableSize.present ? data.cableSize.value : this.cableSize,
      msbType: data.msbType.present ? data.msbType.value : this.msbType,
      feederName: data.feederName.present
          ? data.feederName.value
          : this.feederName,
      applicationNo: data.applicationNo.present
          ? data.applicationNo.value
          : this.applicationNo,
      applicationDate: data.applicationDate.present
          ? data.applicationDate.value
          : this.applicationDate,
      sanctionRef: data.sanctionRef.present
          ? data.sanctionRef.value
          : this.sanctionRef,
      sanctionDate: data.sanctionDate.present
          ? data.sanctionDate.value
          : this.sanctionDate,
      scoMcoRcoNo: data.scoMcoRcoNo.present
          ? data.scoMcoRcoNo.value
          : this.scoMcoRcoNo,
      scoDate: data.scoDate.present ? data.scoDate.value : this.scoDate,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ConsumerRow(')
          ..write('id: $id, ')
          ..write('accountNo: $accountNo, ')
          ..write('tariff: $tariff, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('subDivision: $subDivision, ')
          ..write('opDivision: $opDivision, ')
          ..write('sanctionedLoadKw: $sanctionedLoadKw, ')
          ..write('connectedLoad: $connectedLoad, ')
          ..write('industryKind: $industryKind, ')
          ..write('transformerKva: $transformerKva, ')
          ..write('transformerMake: $transformerMake, ')
          ..write('transformerNo: $transformerNo, ')
          ..write('ctPrimary: $ctPrimary, ')
          ..write('ctSecondary: $ctSecondary, ')
          ..write('ctVaBurden: $ctVaBurden, ')
          ..write('mf: $mf, ')
          ..write('cableSize: $cableSize, ')
          ..write('msbType: $msbType, ')
          ..write('feederName: $feederName, ')
          ..write('applicationNo: $applicationNo, ')
          ..write('applicationDate: $applicationDate, ')
          ..write('sanctionRef: $sanctionRef, ')
          ..write('sanctionDate: $sanctionDate, ')
          ..write('scoMcoRcoNo: $scoMcoRcoNo, ')
          ..write('scoDate: $scoDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    accountNo,
    tariff,
    name,
    address,
    subDivision,
    opDivision,
    sanctionedLoadKw,
    connectedLoad,
    industryKind,
    transformerKva,
    transformerMake,
    transformerNo,
    ctPrimary,
    ctSecondary,
    ctVaBurden,
    mf,
    cableSize,
    msbType,
    feederName,
    applicationNo,
    applicationDate,
    sanctionRef,
    sanctionDate,
    scoMcoRcoNo,
    scoDate,
    notes,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ConsumerRow &&
          other.id == this.id &&
          other.accountNo == this.accountNo &&
          other.tariff == this.tariff &&
          other.name == this.name &&
          other.address == this.address &&
          other.subDivision == this.subDivision &&
          other.opDivision == this.opDivision &&
          other.sanctionedLoadKw == this.sanctionedLoadKw &&
          other.connectedLoad == this.connectedLoad &&
          other.industryKind == this.industryKind &&
          other.transformerKva == this.transformerKva &&
          other.transformerMake == this.transformerMake &&
          other.transformerNo == this.transformerNo &&
          other.ctPrimary == this.ctPrimary &&
          other.ctSecondary == this.ctSecondary &&
          other.ctVaBurden == this.ctVaBurden &&
          other.mf == this.mf &&
          other.cableSize == this.cableSize &&
          other.msbType == this.msbType &&
          other.feederName == this.feederName &&
          other.applicationNo == this.applicationNo &&
          other.applicationDate == this.applicationDate &&
          other.sanctionRef == this.sanctionRef &&
          other.sanctionDate == this.sanctionDate &&
          other.scoMcoRcoNo == this.scoMcoRcoNo &&
          other.scoDate == this.scoDate &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ConsumersCompanion extends UpdateCompanion<ConsumerRow> {
  final Value<int> id;
  final Value<String> accountNo;
  final Value<String> tariff;
  final Value<String> name;
  final Value<String> address;
  final Value<String> subDivision;
  final Value<String> opDivision;
  final Value<String> sanctionedLoadKw;
  final Value<String> connectedLoad;
  final Value<String> industryKind;
  final Value<String> transformerKva;
  final Value<String> transformerMake;
  final Value<String> transformerNo;
  final Value<String> ctPrimary;
  final Value<String> ctSecondary;
  final Value<String> ctVaBurden;
  final Value<String> mf;
  final Value<String> cableSize;
  final Value<String> msbType;
  final Value<String> feederName;
  final Value<String> applicationNo;
  final Value<DateTime?> applicationDate;
  final Value<String> sanctionRef;
  final Value<DateTime?> sanctionDate;
  final Value<String> scoMcoRcoNo;
  final Value<DateTime?> scoDate;
  final Value<String> notes;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ConsumersCompanion({
    this.id = const Value.absent(),
    this.accountNo = const Value.absent(),
    this.tariff = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.subDivision = const Value.absent(),
    this.opDivision = const Value.absent(),
    this.sanctionedLoadKw = const Value.absent(),
    this.connectedLoad = const Value.absent(),
    this.industryKind = const Value.absent(),
    this.transformerKva = const Value.absent(),
    this.transformerMake = const Value.absent(),
    this.transformerNo = const Value.absent(),
    this.ctPrimary = const Value.absent(),
    this.ctSecondary = const Value.absent(),
    this.ctVaBurden = const Value.absent(),
    this.mf = const Value.absent(),
    this.cableSize = const Value.absent(),
    this.msbType = const Value.absent(),
    this.feederName = const Value.absent(),
    this.applicationNo = const Value.absent(),
    this.applicationDate = const Value.absent(),
    this.sanctionRef = const Value.absent(),
    this.sanctionDate = const Value.absent(),
    this.scoMcoRcoNo = const Value.absent(),
    this.scoDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ConsumersCompanion.insert({
    this.id = const Value.absent(),
    required String accountNo,
    this.tariff = const Value.absent(),
    this.name = const Value.absent(),
    this.address = const Value.absent(),
    this.subDivision = const Value.absent(),
    this.opDivision = const Value.absent(),
    this.sanctionedLoadKw = const Value.absent(),
    this.connectedLoad = const Value.absent(),
    this.industryKind = const Value.absent(),
    this.transformerKva = const Value.absent(),
    this.transformerMake = const Value.absent(),
    this.transformerNo = const Value.absent(),
    this.ctPrimary = const Value.absent(),
    this.ctSecondary = const Value.absent(),
    this.ctVaBurden = const Value.absent(),
    this.mf = const Value.absent(),
    this.cableSize = const Value.absent(),
    this.msbType = const Value.absent(),
    this.feederName = const Value.absent(),
    this.applicationNo = const Value.absent(),
    this.applicationDate = const Value.absent(),
    this.sanctionRef = const Value.absent(),
    this.sanctionDate = const Value.absent(),
    this.scoMcoRcoNo = const Value.absent(),
    this.scoDate = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : accountNo = Value(accountNo);
  static Insertable<ConsumerRow> custom({
    Expression<int>? id,
    Expression<String>? accountNo,
    Expression<String>? tariff,
    Expression<String>? name,
    Expression<String>? address,
    Expression<String>? subDivision,
    Expression<String>? opDivision,
    Expression<String>? sanctionedLoadKw,
    Expression<String>? connectedLoad,
    Expression<String>? industryKind,
    Expression<String>? transformerKva,
    Expression<String>? transformerMake,
    Expression<String>? transformerNo,
    Expression<String>? ctPrimary,
    Expression<String>? ctSecondary,
    Expression<String>? ctVaBurden,
    Expression<String>? mf,
    Expression<String>? cableSize,
    Expression<String>? msbType,
    Expression<String>? feederName,
    Expression<String>? applicationNo,
    Expression<DateTime>? applicationDate,
    Expression<String>? sanctionRef,
    Expression<DateTime>? sanctionDate,
    Expression<String>? scoMcoRcoNo,
    Expression<DateTime>? scoDate,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (accountNo != null) 'account_no': accountNo,
      if (tariff != null) 'tariff': tariff,
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (subDivision != null) 'sub_division': subDivision,
      if (opDivision != null) 'op_division': opDivision,
      if (sanctionedLoadKw != null) 'sanctioned_load_kw': sanctionedLoadKw,
      if (connectedLoad != null) 'connected_load': connectedLoad,
      if (industryKind != null) 'industry_kind': industryKind,
      if (transformerKva != null) 'transformer_kva': transformerKva,
      if (transformerMake != null) 'transformer_make': transformerMake,
      if (transformerNo != null) 'transformer_no': transformerNo,
      if (ctPrimary != null) 'ct_primary': ctPrimary,
      if (ctSecondary != null) 'ct_secondary': ctSecondary,
      if (ctVaBurden != null) 'ct_va_burden': ctVaBurden,
      if (mf != null) 'mf': mf,
      if (cableSize != null) 'cable_size': cableSize,
      if (msbType != null) 'msb_type': msbType,
      if (feederName != null) 'feeder_name': feederName,
      if (applicationNo != null) 'application_no': applicationNo,
      if (applicationDate != null) 'application_date': applicationDate,
      if (sanctionRef != null) 'sanction_ref': sanctionRef,
      if (sanctionDate != null) 'sanction_date': sanctionDate,
      if (scoMcoRcoNo != null) 'sco_mco_rco_no': scoMcoRcoNo,
      if (scoDate != null) 'sco_date': scoDate,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ConsumersCompanion copyWith({
    Value<int>? id,
    Value<String>? accountNo,
    Value<String>? tariff,
    Value<String>? name,
    Value<String>? address,
    Value<String>? subDivision,
    Value<String>? opDivision,
    Value<String>? sanctionedLoadKw,
    Value<String>? connectedLoad,
    Value<String>? industryKind,
    Value<String>? transformerKva,
    Value<String>? transformerMake,
    Value<String>? transformerNo,
    Value<String>? ctPrimary,
    Value<String>? ctSecondary,
    Value<String>? ctVaBurden,
    Value<String>? mf,
    Value<String>? cableSize,
    Value<String>? msbType,
    Value<String>? feederName,
    Value<String>? applicationNo,
    Value<DateTime?>? applicationDate,
    Value<String>? sanctionRef,
    Value<DateTime?>? sanctionDate,
    Value<String>? scoMcoRcoNo,
    Value<DateTime?>? scoDate,
    Value<String>? notes,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ConsumersCompanion(
      id: id ?? this.id,
      accountNo: accountNo ?? this.accountNo,
      tariff: tariff ?? this.tariff,
      name: name ?? this.name,
      address: address ?? this.address,
      subDivision: subDivision ?? this.subDivision,
      opDivision: opDivision ?? this.opDivision,
      sanctionedLoadKw: sanctionedLoadKw ?? this.sanctionedLoadKw,
      connectedLoad: connectedLoad ?? this.connectedLoad,
      industryKind: industryKind ?? this.industryKind,
      transformerKva: transformerKva ?? this.transformerKva,
      transformerMake: transformerMake ?? this.transformerMake,
      transformerNo: transformerNo ?? this.transformerNo,
      ctPrimary: ctPrimary ?? this.ctPrimary,
      ctSecondary: ctSecondary ?? this.ctSecondary,
      ctVaBurden: ctVaBurden ?? this.ctVaBurden,
      mf: mf ?? this.mf,
      cableSize: cableSize ?? this.cableSize,
      msbType: msbType ?? this.msbType,
      feederName: feederName ?? this.feederName,
      applicationNo: applicationNo ?? this.applicationNo,
      applicationDate: applicationDate ?? this.applicationDate,
      sanctionRef: sanctionRef ?? this.sanctionRef,
      sanctionDate: sanctionDate ?? this.sanctionDate,
      scoMcoRcoNo: scoMcoRcoNo ?? this.scoMcoRcoNo,
      scoDate: scoDate ?? this.scoDate,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (accountNo.present) {
      map['account_no'] = Variable<String>(accountNo.value);
    }
    if (tariff.present) {
      map['tariff'] = Variable<String>(tariff.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (address.present) {
      map['address'] = Variable<String>(address.value);
    }
    if (subDivision.present) {
      map['sub_division'] = Variable<String>(subDivision.value);
    }
    if (opDivision.present) {
      map['op_division'] = Variable<String>(opDivision.value);
    }
    if (sanctionedLoadKw.present) {
      map['sanctioned_load_kw'] = Variable<String>(sanctionedLoadKw.value);
    }
    if (connectedLoad.present) {
      map['connected_load'] = Variable<String>(connectedLoad.value);
    }
    if (industryKind.present) {
      map['industry_kind'] = Variable<String>(industryKind.value);
    }
    if (transformerKva.present) {
      map['transformer_kva'] = Variable<String>(transformerKva.value);
    }
    if (transformerMake.present) {
      map['transformer_make'] = Variable<String>(transformerMake.value);
    }
    if (transformerNo.present) {
      map['transformer_no'] = Variable<String>(transformerNo.value);
    }
    if (ctPrimary.present) {
      map['ct_primary'] = Variable<String>(ctPrimary.value);
    }
    if (ctSecondary.present) {
      map['ct_secondary'] = Variable<String>(ctSecondary.value);
    }
    if (ctVaBurden.present) {
      map['ct_va_burden'] = Variable<String>(ctVaBurden.value);
    }
    if (mf.present) {
      map['mf'] = Variable<String>(mf.value);
    }
    if (cableSize.present) {
      map['cable_size'] = Variable<String>(cableSize.value);
    }
    if (msbType.present) {
      map['msb_type'] = Variable<String>(msbType.value);
    }
    if (feederName.present) {
      map['feeder_name'] = Variable<String>(feederName.value);
    }
    if (applicationNo.present) {
      map['application_no'] = Variable<String>(applicationNo.value);
    }
    if (applicationDate.present) {
      map['application_date'] = Variable<DateTime>(applicationDate.value);
    }
    if (sanctionRef.present) {
      map['sanction_ref'] = Variable<String>(sanctionRef.value);
    }
    if (sanctionDate.present) {
      map['sanction_date'] = Variable<DateTime>(sanctionDate.value);
    }
    if (scoMcoRcoNo.present) {
      map['sco_mco_rco_no'] = Variable<String>(scoMcoRcoNo.value);
    }
    if (scoDate.present) {
      map['sco_date'] = Variable<DateTime>(scoDate.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ConsumersCompanion(')
          ..write('id: $id, ')
          ..write('accountNo: $accountNo, ')
          ..write('tariff: $tariff, ')
          ..write('name: $name, ')
          ..write('address: $address, ')
          ..write('subDivision: $subDivision, ')
          ..write('opDivision: $opDivision, ')
          ..write('sanctionedLoadKw: $sanctionedLoadKw, ')
          ..write('connectedLoad: $connectedLoad, ')
          ..write('industryKind: $industryKind, ')
          ..write('transformerKva: $transformerKva, ')
          ..write('transformerMake: $transformerMake, ')
          ..write('transformerNo: $transformerNo, ')
          ..write('ctPrimary: $ctPrimary, ')
          ..write('ctSecondary: $ctSecondary, ')
          ..write('ctVaBurden: $ctVaBurden, ')
          ..write('mf: $mf, ')
          ..write('cableSize: $cableSize, ')
          ..write('msbType: $msbType, ')
          ..write('feederName: $feederName, ')
          ..write('applicationNo: $applicationNo, ')
          ..write('applicationDate: $applicationDate, ')
          ..write('sanctionRef: $sanctionRef, ')
          ..write('sanctionDate: $sanctionDate, ')
          ..write('scoMcoRcoNo: $scoMcoRcoNo, ')
          ..write('scoDate: $scoDate, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MetersTable extends Meters with TableInfo<$MetersTable, Meter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MetersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _consumerIdMeta = const VerificationMeta(
    'consumerId',
  );
  @override
  late final GeneratedColumn<int> consumerId = GeneratedColumn<int>(
    'consumer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES consumers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _mfgNoMeta = const VerificationMeta('mfgNo');
  @override
  late final GeneratedColumn<String> mfgNo = GeneratedColumn<String>(
    'mfg_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _meterKindMeta = const VerificationMeta(
    'meterKind',
  );
  @override
  late final GeneratedColumn<String> meterKind = GeneratedColumn<String>(
    'meter_kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('AMR'),
  );
  static const VerificationMeta _ampsMeta = const VerificationMeta('amps');
  @override
  late final GeneratedColumn<String> amps = GeneratedColumn<String>(
    'amps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _voltsMeta = const VerificationMeta('volts');
  @override
  late final GeneratedColumn<String> volts = GeneratedColumn<String>(
    'volts',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _meterConstantMeta = const VerificationMeta(
    'meterConstant',
  );
  @override
  late final GeneratedColumn<String> meterConstant = GeneratedColumn<String>(
    'meter_constant',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _mfMeta = const VerificationMeta('mf');
  @override
  late final GeneratedColumn<String> mf = GeneratedColumn<String>(
    'mf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _simNoMeta = const VerificationMeta('simNo');
  @override
  late final GeneratedColumn<String> simNo = GeneratedColumn<String>(
    'sim_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _commIdMeta = const VerificationMeta('commId');
  @override
  late final GeneratedColumn<String> commId = GeneratedColumn<String>(
    'comm_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('active'),
  );
  static const VerificationMeta _installedOnMeta = const VerificationMeta(
    'installedOn',
  );
  @override
  late final GeneratedColumn<DateTime> installedOn = GeneratedColumn<DateTime>(
    'installed_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _removedOnMeta = const VerificationMeta(
    'removedOn',
  );
  @override
  late final GeneratedColumn<DateTime> removedOn = GeneratedColumn<DateTime>(
    'removed_on',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    consumerId,
    mfgNo,
    make,
    meterKind,
    amps,
    volts,
    meterConstant,
    mf,
    simNo,
    commId,
    status,
    installedOn,
    removedOn,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meters';
  @override
  VerificationContext validateIntegrity(
    Insertable<Meter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('consumer_id')) {
      context.handle(
        _consumerIdMeta,
        consumerId.isAcceptableOrUnknown(data['consumer_id']!, _consumerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_consumerIdMeta);
    }
    if (data.containsKey('mfg_no')) {
      context.handle(
        _mfgNoMeta,
        mfgNo.isAcceptableOrUnknown(data['mfg_no']!, _mfgNoMeta),
      );
    } else if (isInserting) {
      context.missing(_mfgNoMeta);
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    }
    if (data.containsKey('meter_kind')) {
      context.handle(
        _meterKindMeta,
        meterKind.isAcceptableOrUnknown(data['meter_kind']!, _meterKindMeta),
      );
    }
    if (data.containsKey('amps')) {
      context.handle(
        _ampsMeta,
        amps.isAcceptableOrUnknown(data['amps']!, _ampsMeta),
      );
    }
    if (data.containsKey('volts')) {
      context.handle(
        _voltsMeta,
        volts.isAcceptableOrUnknown(data['volts']!, _voltsMeta),
      );
    }
    if (data.containsKey('meter_constant')) {
      context.handle(
        _meterConstantMeta,
        meterConstant.isAcceptableOrUnknown(
          data['meter_constant']!,
          _meterConstantMeta,
        ),
      );
    }
    if (data.containsKey('mf')) {
      context.handle(_mfMeta, mf.isAcceptableOrUnknown(data['mf']!, _mfMeta));
    }
    if (data.containsKey('sim_no')) {
      context.handle(
        _simNoMeta,
        simNo.isAcceptableOrUnknown(data['sim_no']!, _simNoMeta),
      );
    }
    if (data.containsKey('comm_id')) {
      context.handle(
        _commIdMeta,
        commId.isAcceptableOrUnknown(data['comm_id']!, _commIdMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('installed_on')) {
      context.handle(
        _installedOnMeta,
        installedOn.isAcceptableOrUnknown(
          data['installed_on']!,
          _installedOnMeta,
        ),
      );
    }
    if (data.containsKey('removed_on')) {
      context.handle(
        _removedOnMeta,
        removedOn.isAcceptableOrUnknown(data['removed_on']!, _removedOnMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Meter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Meter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      consumerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}consumer_id'],
      )!,
      mfgNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mfg_no'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      meterKind: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meter_kind'],
      )!,
      amps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amps'],
      )!,
      volts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}volts'],
      )!,
      meterConstant: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}meter_constant'],
      )!,
      mf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mf'],
      )!,
      simNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sim_no'],
      )!,
      commId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comm_id'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      installedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}installed_on'],
      ),
      removedOn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}removed_on'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MetersTable createAlias(String alias) {
    return $MetersTable(attachedDatabase, alias);
  }
}

class Meter extends DataClass implements Insertable<Meter> {
  final int id;
  final int consumerId;
  final String mfgNo;
  final String make;

  /// AMR / TOU / AMI / NET
  final String meterKind;
  final String amps;
  final String volts;
  final String meterConstant;
  final String mf;
  final String simNo;
  final String commId;

  /// active / removed
  final String status;
  final DateTime? installedOn;
  final DateTime? removedOn;
  final DateTime createdAt;
  const Meter({
    required this.id,
    required this.consumerId,
    required this.mfgNo,
    required this.make,
    required this.meterKind,
    required this.amps,
    required this.volts,
    required this.meterConstant,
    required this.mf,
    required this.simNo,
    required this.commId,
    required this.status,
    this.installedOn,
    this.removedOn,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['consumer_id'] = Variable<int>(consumerId);
    map['mfg_no'] = Variable<String>(mfgNo);
    map['make'] = Variable<String>(make);
    map['meter_kind'] = Variable<String>(meterKind);
    map['amps'] = Variable<String>(amps);
    map['volts'] = Variable<String>(volts);
    map['meter_constant'] = Variable<String>(meterConstant);
    map['mf'] = Variable<String>(mf);
    map['sim_no'] = Variable<String>(simNo);
    map['comm_id'] = Variable<String>(commId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || installedOn != null) {
      map['installed_on'] = Variable<DateTime>(installedOn);
    }
    if (!nullToAbsent || removedOn != null) {
      map['removed_on'] = Variable<DateTime>(removedOn);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MetersCompanion toCompanion(bool nullToAbsent) {
    return MetersCompanion(
      id: Value(id),
      consumerId: Value(consumerId),
      mfgNo: Value(mfgNo),
      make: Value(make),
      meterKind: Value(meterKind),
      amps: Value(amps),
      volts: Value(volts),
      meterConstant: Value(meterConstant),
      mf: Value(mf),
      simNo: Value(simNo),
      commId: Value(commId),
      status: Value(status),
      installedOn: installedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(installedOn),
      removedOn: removedOn == null && nullToAbsent
          ? const Value.absent()
          : Value(removedOn),
      createdAt: Value(createdAt),
    );
  }

  factory Meter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Meter(
      id: serializer.fromJson<int>(json['id']),
      consumerId: serializer.fromJson<int>(json['consumerId']),
      mfgNo: serializer.fromJson<String>(json['mfgNo']),
      make: serializer.fromJson<String>(json['make']),
      meterKind: serializer.fromJson<String>(json['meterKind']),
      amps: serializer.fromJson<String>(json['amps']),
      volts: serializer.fromJson<String>(json['volts']),
      meterConstant: serializer.fromJson<String>(json['meterConstant']),
      mf: serializer.fromJson<String>(json['mf']),
      simNo: serializer.fromJson<String>(json['simNo']),
      commId: serializer.fromJson<String>(json['commId']),
      status: serializer.fromJson<String>(json['status']),
      installedOn: serializer.fromJson<DateTime?>(json['installedOn']),
      removedOn: serializer.fromJson<DateTime?>(json['removedOn']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'consumerId': serializer.toJson<int>(consumerId),
      'mfgNo': serializer.toJson<String>(mfgNo),
      'make': serializer.toJson<String>(make),
      'meterKind': serializer.toJson<String>(meterKind),
      'amps': serializer.toJson<String>(amps),
      'volts': serializer.toJson<String>(volts),
      'meterConstant': serializer.toJson<String>(meterConstant),
      'mf': serializer.toJson<String>(mf),
      'simNo': serializer.toJson<String>(simNo),
      'commId': serializer.toJson<String>(commId),
      'status': serializer.toJson<String>(status),
      'installedOn': serializer.toJson<DateTime?>(installedOn),
      'removedOn': serializer.toJson<DateTime?>(removedOn),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Meter copyWith({
    int? id,
    int? consumerId,
    String? mfgNo,
    String? make,
    String? meterKind,
    String? amps,
    String? volts,
    String? meterConstant,
    String? mf,
    String? simNo,
    String? commId,
    String? status,
    Value<DateTime?> installedOn = const Value.absent(),
    Value<DateTime?> removedOn = const Value.absent(),
    DateTime? createdAt,
  }) => Meter(
    id: id ?? this.id,
    consumerId: consumerId ?? this.consumerId,
    mfgNo: mfgNo ?? this.mfgNo,
    make: make ?? this.make,
    meterKind: meterKind ?? this.meterKind,
    amps: amps ?? this.amps,
    volts: volts ?? this.volts,
    meterConstant: meterConstant ?? this.meterConstant,
    mf: mf ?? this.mf,
    simNo: simNo ?? this.simNo,
    commId: commId ?? this.commId,
    status: status ?? this.status,
    installedOn: installedOn.present ? installedOn.value : this.installedOn,
    removedOn: removedOn.present ? removedOn.value : this.removedOn,
    createdAt: createdAt ?? this.createdAt,
  );
  Meter copyWithCompanion(MetersCompanion data) {
    return Meter(
      id: data.id.present ? data.id.value : this.id,
      consumerId: data.consumerId.present
          ? data.consumerId.value
          : this.consumerId,
      mfgNo: data.mfgNo.present ? data.mfgNo.value : this.mfgNo,
      make: data.make.present ? data.make.value : this.make,
      meterKind: data.meterKind.present ? data.meterKind.value : this.meterKind,
      amps: data.amps.present ? data.amps.value : this.amps,
      volts: data.volts.present ? data.volts.value : this.volts,
      meterConstant: data.meterConstant.present
          ? data.meterConstant.value
          : this.meterConstant,
      mf: data.mf.present ? data.mf.value : this.mf,
      simNo: data.simNo.present ? data.simNo.value : this.simNo,
      commId: data.commId.present ? data.commId.value : this.commId,
      status: data.status.present ? data.status.value : this.status,
      installedOn: data.installedOn.present
          ? data.installedOn.value
          : this.installedOn,
      removedOn: data.removedOn.present ? data.removedOn.value : this.removedOn,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Meter(')
          ..write('id: $id, ')
          ..write('consumerId: $consumerId, ')
          ..write('mfgNo: $mfgNo, ')
          ..write('make: $make, ')
          ..write('meterKind: $meterKind, ')
          ..write('amps: $amps, ')
          ..write('volts: $volts, ')
          ..write('meterConstant: $meterConstant, ')
          ..write('mf: $mf, ')
          ..write('simNo: $simNo, ')
          ..write('commId: $commId, ')
          ..write('status: $status, ')
          ..write('installedOn: $installedOn, ')
          ..write('removedOn: $removedOn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    consumerId,
    mfgNo,
    make,
    meterKind,
    amps,
    volts,
    meterConstant,
    mf,
    simNo,
    commId,
    status,
    installedOn,
    removedOn,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Meter &&
          other.id == this.id &&
          other.consumerId == this.consumerId &&
          other.mfgNo == this.mfgNo &&
          other.make == this.make &&
          other.meterKind == this.meterKind &&
          other.amps == this.amps &&
          other.volts == this.volts &&
          other.meterConstant == this.meterConstant &&
          other.mf == this.mf &&
          other.simNo == this.simNo &&
          other.commId == this.commId &&
          other.status == this.status &&
          other.installedOn == this.installedOn &&
          other.removedOn == this.removedOn &&
          other.createdAt == this.createdAt);
}

class MetersCompanion extends UpdateCompanion<Meter> {
  final Value<int> id;
  final Value<int> consumerId;
  final Value<String> mfgNo;
  final Value<String> make;
  final Value<String> meterKind;
  final Value<String> amps;
  final Value<String> volts;
  final Value<String> meterConstant;
  final Value<String> mf;
  final Value<String> simNo;
  final Value<String> commId;
  final Value<String> status;
  final Value<DateTime?> installedOn;
  final Value<DateTime?> removedOn;
  final Value<DateTime> createdAt;
  const MetersCompanion({
    this.id = const Value.absent(),
    this.consumerId = const Value.absent(),
    this.mfgNo = const Value.absent(),
    this.make = const Value.absent(),
    this.meterKind = const Value.absent(),
    this.amps = const Value.absent(),
    this.volts = const Value.absent(),
    this.meterConstant = const Value.absent(),
    this.mf = const Value.absent(),
    this.simNo = const Value.absent(),
    this.commId = const Value.absent(),
    this.status = const Value.absent(),
    this.installedOn = const Value.absent(),
    this.removedOn = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MetersCompanion.insert({
    this.id = const Value.absent(),
    required int consumerId,
    required String mfgNo,
    this.make = const Value.absent(),
    this.meterKind = const Value.absent(),
    this.amps = const Value.absent(),
    this.volts = const Value.absent(),
    this.meterConstant = const Value.absent(),
    this.mf = const Value.absent(),
    this.simNo = const Value.absent(),
    this.commId = const Value.absent(),
    this.status = const Value.absent(),
    this.installedOn = const Value.absent(),
    this.removedOn = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : consumerId = Value(consumerId),
       mfgNo = Value(mfgNo);
  static Insertable<Meter> custom({
    Expression<int>? id,
    Expression<int>? consumerId,
    Expression<String>? mfgNo,
    Expression<String>? make,
    Expression<String>? meterKind,
    Expression<String>? amps,
    Expression<String>? volts,
    Expression<String>? meterConstant,
    Expression<String>? mf,
    Expression<String>? simNo,
    Expression<String>? commId,
    Expression<String>? status,
    Expression<DateTime>? installedOn,
    Expression<DateTime>? removedOn,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (consumerId != null) 'consumer_id': consumerId,
      if (mfgNo != null) 'mfg_no': mfgNo,
      if (make != null) 'make': make,
      if (meterKind != null) 'meter_kind': meterKind,
      if (amps != null) 'amps': amps,
      if (volts != null) 'volts': volts,
      if (meterConstant != null) 'meter_constant': meterConstant,
      if (mf != null) 'mf': mf,
      if (simNo != null) 'sim_no': simNo,
      if (commId != null) 'comm_id': commId,
      if (status != null) 'status': status,
      if (installedOn != null) 'installed_on': installedOn,
      if (removedOn != null) 'removed_on': removedOn,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MetersCompanion copyWith({
    Value<int>? id,
    Value<int>? consumerId,
    Value<String>? mfgNo,
    Value<String>? make,
    Value<String>? meterKind,
    Value<String>? amps,
    Value<String>? volts,
    Value<String>? meterConstant,
    Value<String>? mf,
    Value<String>? simNo,
    Value<String>? commId,
    Value<String>? status,
    Value<DateTime?>? installedOn,
    Value<DateTime?>? removedOn,
    Value<DateTime>? createdAt,
  }) {
    return MetersCompanion(
      id: id ?? this.id,
      consumerId: consumerId ?? this.consumerId,
      mfgNo: mfgNo ?? this.mfgNo,
      make: make ?? this.make,
      meterKind: meterKind ?? this.meterKind,
      amps: amps ?? this.amps,
      volts: volts ?? this.volts,
      meterConstant: meterConstant ?? this.meterConstant,
      mf: mf ?? this.mf,
      simNo: simNo ?? this.simNo,
      commId: commId ?? this.commId,
      status: status ?? this.status,
      installedOn: installedOn ?? this.installedOn,
      removedOn: removedOn ?? this.removedOn,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (consumerId.present) {
      map['consumer_id'] = Variable<int>(consumerId.value);
    }
    if (mfgNo.present) {
      map['mfg_no'] = Variable<String>(mfgNo.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (meterKind.present) {
      map['meter_kind'] = Variable<String>(meterKind.value);
    }
    if (amps.present) {
      map['amps'] = Variable<String>(amps.value);
    }
    if (volts.present) {
      map['volts'] = Variable<String>(volts.value);
    }
    if (meterConstant.present) {
      map['meter_constant'] = Variable<String>(meterConstant.value);
    }
    if (mf.present) {
      map['mf'] = Variable<String>(mf.value);
    }
    if (simNo.present) {
      map['sim_no'] = Variable<String>(simNo.value);
    }
    if (commId.present) {
      map['comm_id'] = Variable<String>(commId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (installedOn.present) {
      map['installed_on'] = Variable<DateTime>(installedOn.value);
    }
    if (removedOn.present) {
      map['removed_on'] = Variable<DateTime>(removedOn.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MetersCompanion(')
          ..write('id: $id, ')
          ..write('consumerId: $consumerId, ')
          ..write('mfgNo: $mfgNo, ')
          ..write('make: $make, ')
          ..write('meterKind: $meterKind, ')
          ..write('amps: $amps, ')
          ..write('volts: $volts, ')
          ..write('meterConstant: $meterConstant, ')
          ..write('mf: $mf, ')
          ..write('simNo: $simNo, ')
          ..write('commId: $commId, ')
          ..write('status: $status, ')
          ..write('installedOn: $installedOn, ')
          ..write('removedOn: $removedOn, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $ReportsTable extends Reports with TableInfo<$ReportsTable, Report> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _consumerIdMeta = const VerificationMeta(
    'consumerId',
  );
  @override
  late final GeneratedColumn<int> consumerId = GeneratedColumn<int>(
    'consumer_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES consumers (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reportTypeMeta = const VerificationMeta(
    'reportType',
  );
  @override
  late final GeneratedColumn<String> reportType = GeneratedColumn<String>(
    'report_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('draft'),
  );
  static const VerificationMeta _memoNoMeta = const VerificationMeta('memoNo');
  @override
  late final GeneratedColumn<String> memoNo = GeneratedColumn<String>(
    'memo_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _memoDateMeta = const VerificationMeta(
    'memoDate',
  );
  @override
  late final GeneratedColumn<DateTime> memoDate = GeneratedColumn<DateTime>(
    'memo_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toSubDivisionMeta = const VerificationMeta(
    'toSubDivision',
  );
  @override
  late final GeneratedColumn<String> toSubDivision = GeneratedColumn<String>(
    'to_sub_division',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _refTypeMeta = const VerificationMeta(
    'refType',
  );
  @override
  late final GeneratedColumn<String> refType = GeneratedColumn<String>(
    'ref_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('memo'),
  );
  static const VerificationMeta _refNoMeta = const VerificationMeta('refNo');
  @override
  late final GeneratedColumn<String> refNo = GeneratedColumn<String>(
    'ref_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _refDateMeta = const VerificationMeta(
    'refDate',
  );
  @override
  late final GeneratedColumn<DateTime> refDate = GeneratedColumn<DateTime>(
    'ref_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _visitDateMeta = const VerificationMeta(
    'visitDate',
  );
  @override
  late final GeneratedColumn<DateTime> visitDate = GeneratedColumn<DateTime>(
    'visit_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _teamTextMeta = const VerificationMeta(
    'teamText',
  );
  @override
  late final GeneratedColumn<String> teamText = GeneratedColumn<String>(
    'team_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _sectionAJsonMeta = const VerificationMeta(
    'sectionAJson',
  );
  @override
  late final GeneratedColumn<String> sectionAJson = GeneratedColumn<String>(
    'section_a_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('{}'),
  );
  static const VerificationMeta _msbStatusMeta = const VerificationMeta(
    'msbStatus',
  );
  @override
  late final GeneratedColumn<String> msbStatus = GeneratedColumn<String>(
    'msb_status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _postalOrdersTextMeta = const VerificationMeta(
    'postalOrdersText',
  );
  @override
  late final GeneratedColumn<String> postalOrdersText = GeneratedColumn<String>(
    'postal_orders_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _checkedLoadKwMeta = const VerificationMeta(
    'checkedLoadKw',
  );
  @override
  late final GeneratedColumn<String> checkedLoadKw = GeneratedColumn<String>(
    'checked_load_kw',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _loadTypeMeta = const VerificationMeta(
    'loadType',
  );
  @override
  late final GeneratedColumn<String> loadType = GeneratedColumn<String>(
    'load_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('3Ø H/Load'),
  );
  static const VerificationMeta _exportLoadTextMeta = const VerificationMeta(
    'exportLoadText',
  );
  @override
  late final GeneratedColumn<String> exportLoadText = GeneratedColumn<String>(
    'export_load_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _accuracyTextMeta = const VerificationMeta(
    'accuracyText',
  );
  @override
  late final GeneratedColumn<String> accuracyText = GeneratedColumn<String>(
    'accuracy_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _transformerLtBushesMeta =
      const VerificationMeta('transformerLtBushes');
  @override
  late final GeneratedColumn<String> transformerLtBushes =
      GeneratedColumn<String>(
        'transformer_lt_bushes',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _remarksMeta = const VerificationMeta(
    'remarks',
  );
  @override
  late final GeneratedColumn<String> remarks = GeneratedColumn<String>(
    'remarks',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _storeChallanNoMeta = const VerificationMeta(
    'storeChallanNo',
  );
  @override
  late final GeneratedColumn<String> storeChallanNo = GeneratedColumn<String>(
    'store_challan_no',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _storeChallanDateMeta = const VerificationMeta(
    'storeChallanDate',
  );
  @override
  late final GeneratedColumn<DateTime> storeChallanDate =
      GeneratedColumn<DateTime>(
        'store_challan_date',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _newMeterCountMeta = const VerificationMeta(
    'newMeterCount',
  );
  @override
  late final GeneratedColumn<String> newMeterCount = GeneratedColumn<String>(
    'new_meter_count',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ctCountMeta = const VerificationMeta(
    'ctCount',
  );
  @override
  late final GeneratedColumn<String> ctCount = GeneratedColumn<String>(
    'ct_count',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _signerExenOpMeta = const VerificationMeta(
    'signerExenOp',
  );
  @override
  late final GeneratedColumn<String> signerExenOp = GeneratedColumn<String>(
    'signer_exen_op',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _signerSdoOpMeta = const VerificationMeta(
    'signerSdoOp',
  );
  @override
  late final GeneratedColumn<String> signerSdoOp = GeneratedColumn<String>(
    'signer_sdo_op',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _signer3Meta = const VerificationMeta(
    'signer3',
  );
  @override
  late final GeneratedColumn<String> signer3 = GeneratedColumn<String>(
    'signer3',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _signer4Meta = const VerificationMeta(
    'signer4',
  );
  @override
  late final GeneratedColumn<String> signer4 = GeneratedColumn<String>(
    'signer4',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _checkLoadOverrideMeta = const VerificationMeta(
    'checkLoadOverride',
  );
  @override
  late final GeneratedColumn<String> checkLoadOverride =
      GeneratedColumn<String>(
        'check_load_override',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _percentErrorOverrideMeta =
      const VerificationMeta('percentErrorOverride');
  @override
  late final GeneratedColumn<String> percentErrorOverride =
      GeneratedColumn<String>(
        'percent_error_override',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _withinLimitOverrideMeta =
      const VerificationMeta('withinLimitOverride');
  @override
  late final GeneratedColumn<String> withinLimitOverride =
      GeneratedColumn<String>(
        'within_limit_override',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant(''),
      );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    consumerId,
    reportType,
    status,
    memoNo,
    memoDate,
    toSubDivision,
    refType,
    refNo,
    refDate,
    visitDate,
    teamText,
    sectionAJson,
    msbStatus,
    postalOrdersText,
    checkedLoadKw,
    loadType,
    exportLoadText,
    accuracyText,
    transformerLtBushes,
    remarks,
    storeChallanNo,
    storeChallanDate,
    newMeterCount,
    ctCount,
    signerExenOp,
    signerSdoOp,
    signer3,
    signer4,
    checkLoadOverride,
    percentErrorOverride,
    withinLimitOverride,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reports';
  @override
  VerificationContext validateIntegrity(
    Insertable<Report> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('consumer_id')) {
      context.handle(
        _consumerIdMeta,
        consumerId.isAcceptableOrUnknown(data['consumer_id']!, _consumerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_consumerIdMeta);
    }
    if (data.containsKey('report_type')) {
      context.handle(
        _reportTypeMeta,
        reportType.isAcceptableOrUnknown(data['report_type']!, _reportTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_reportTypeMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    }
    if (data.containsKey('memo_no')) {
      context.handle(
        _memoNoMeta,
        memoNo.isAcceptableOrUnknown(data['memo_no']!, _memoNoMeta),
      );
    }
    if (data.containsKey('memo_date')) {
      context.handle(
        _memoDateMeta,
        memoDate.isAcceptableOrUnknown(data['memo_date']!, _memoDateMeta),
      );
    }
    if (data.containsKey('to_sub_division')) {
      context.handle(
        _toSubDivisionMeta,
        toSubDivision.isAcceptableOrUnknown(
          data['to_sub_division']!,
          _toSubDivisionMeta,
        ),
      );
    }
    if (data.containsKey('ref_type')) {
      context.handle(
        _refTypeMeta,
        refType.isAcceptableOrUnknown(data['ref_type']!, _refTypeMeta),
      );
    }
    if (data.containsKey('ref_no')) {
      context.handle(
        _refNoMeta,
        refNo.isAcceptableOrUnknown(data['ref_no']!, _refNoMeta),
      );
    }
    if (data.containsKey('ref_date')) {
      context.handle(
        _refDateMeta,
        refDate.isAcceptableOrUnknown(data['ref_date']!, _refDateMeta),
      );
    }
    if (data.containsKey('visit_date')) {
      context.handle(
        _visitDateMeta,
        visitDate.isAcceptableOrUnknown(data['visit_date']!, _visitDateMeta),
      );
    }
    if (data.containsKey('team_text')) {
      context.handle(
        _teamTextMeta,
        teamText.isAcceptableOrUnknown(data['team_text']!, _teamTextMeta),
      );
    }
    if (data.containsKey('section_a_json')) {
      context.handle(
        _sectionAJsonMeta,
        sectionAJson.isAcceptableOrUnknown(
          data['section_a_json']!,
          _sectionAJsonMeta,
        ),
      );
    }
    if (data.containsKey('msb_status')) {
      context.handle(
        _msbStatusMeta,
        msbStatus.isAcceptableOrUnknown(data['msb_status']!, _msbStatusMeta),
      );
    }
    if (data.containsKey('postal_orders_text')) {
      context.handle(
        _postalOrdersTextMeta,
        postalOrdersText.isAcceptableOrUnknown(
          data['postal_orders_text']!,
          _postalOrdersTextMeta,
        ),
      );
    }
    if (data.containsKey('checked_load_kw')) {
      context.handle(
        _checkedLoadKwMeta,
        checkedLoadKw.isAcceptableOrUnknown(
          data['checked_load_kw']!,
          _checkedLoadKwMeta,
        ),
      );
    }
    if (data.containsKey('load_type')) {
      context.handle(
        _loadTypeMeta,
        loadType.isAcceptableOrUnknown(data['load_type']!, _loadTypeMeta),
      );
    }
    if (data.containsKey('export_load_text')) {
      context.handle(
        _exportLoadTextMeta,
        exportLoadText.isAcceptableOrUnknown(
          data['export_load_text']!,
          _exportLoadTextMeta,
        ),
      );
    }
    if (data.containsKey('accuracy_text')) {
      context.handle(
        _accuracyTextMeta,
        accuracyText.isAcceptableOrUnknown(
          data['accuracy_text']!,
          _accuracyTextMeta,
        ),
      );
    }
    if (data.containsKey('transformer_lt_bushes')) {
      context.handle(
        _transformerLtBushesMeta,
        transformerLtBushes.isAcceptableOrUnknown(
          data['transformer_lt_bushes']!,
          _transformerLtBushesMeta,
        ),
      );
    }
    if (data.containsKey('remarks')) {
      context.handle(
        _remarksMeta,
        remarks.isAcceptableOrUnknown(data['remarks']!, _remarksMeta),
      );
    }
    if (data.containsKey('store_challan_no')) {
      context.handle(
        _storeChallanNoMeta,
        storeChallanNo.isAcceptableOrUnknown(
          data['store_challan_no']!,
          _storeChallanNoMeta,
        ),
      );
    }
    if (data.containsKey('store_challan_date')) {
      context.handle(
        _storeChallanDateMeta,
        storeChallanDate.isAcceptableOrUnknown(
          data['store_challan_date']!,
          _storeChallanDateMeta,
        ),
      );
    }
    if (data.containsKey('new_meter_count')) {
      context.handle(
        _newMeterCountMeta,
        newMeterCount.isAcceptableOrUnknown(
          data['new_meter_count']!,
          _newMeterCountMeta,
        ),
      );
    }
    if (data.containsKey('ct_count')) {
      context.handle(
        _ctCountMeta,
        ctCount.isAcceptableOrUnknown(data['ct_count']!, _ctCountMeta),
      );
    }
    if (data.containsKey('signer_exen_op')) {
      context.handle(
        _signerExenOpMeta,
        signerExenOp.isAcceptableOrUnknown(
          data['signer_exen_op']!,
          _signerExenOpMeta,
        ),
      );
    }
    if (data.containsKey('signer_sdo_op')) {
      context.handle(
        _signerSdoOpMeta,
        signerSdoOp.isAcceptableOrUnknown(
          data['signer_sdo_op']!,
          _signerSdoOpMeta,
        ),
      );
    }
    if (data.containsKey('signer3')) {
      context.handle(
        _signer3Meta,
        signer3.isAcceptableOrUnknown(data['signer3']!, _signer3Meta),
      );
    }
    if (data.containsKey('signer4')) {
      context.handle(
        _signer4Meta,
        signer4.isAcceptableOrUnknown(data['signer4']!, _signer4Meta),
      );
    }
    if (data.containsKey('check_load_override')) {
      context.handle(
        _checkLoadOverrideMeta,
        checkLoadOverride.isAcceptableOrUnknown(
          data['check_load_override']!,
          _checkLoadOverrideMeta,
        ),
      );
    }
    if (data.containsKey('percent_error_override')) {
      context.handle(
        _percentErrorOverrideMeta,
        percentErrorOverride.isAcceptableOrUnknown(
          data['percent_error_override']!,
          _percentErrorOverrideMeta,
        ),
      );
    }
    if (data.containsKey('within_limit_override')) {
      context.handle(
        _withinLimitOverrideMeta,
        withinLimitOverride.isAcceptableOrUnknown(
          data['within_limit_override']!,
          _withinLimitOverrideMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Report map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Report(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      consumerId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}consumer_id'],
      )!,
      reportType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}report_type'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      memoNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}memo_no'],
      )!,
      memoDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}memo_date'],
      ),
      toSubDivision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}to_sub_division'],
      )!,
      refType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_type'],
      )!,
      refNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ref_no'],
      )!,
      refDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}ref_date'],
      ),
      visitDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}visit_date'],
      ),
      teamText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_text'],
      )!,
      sectionAJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}section_a_json'],
      )!,
      msbStatus: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}msb_status'],
      )!,
      postalOrdersText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_orders_text'],
      )!,
      checkedLoadKw: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}checked_load_kw'],
      )!,
      loadType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}load_type'],
      )!,
      exportLoadText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}export_load_text'],
      )!,
      accuracyText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accuracy_text'],
      )!,
      transformerLtBushes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}transformer_lt_bushes'],
      )!,
      remarks: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remarks'],
      )!,
      storeChallanNo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}store_challan_no'],
      )!,
      storeChallanDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}store_challan_date'],
      ),
      newMeterCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}new_meter_count'],
      )!,
      ctCount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ct_count'],
      )!,
      signerExenOp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signer_exen_op'],
      )!,
      signerSdoOp: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signer_sdo_op'],
      )!,
      signer3: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signer3'],
      )!,
      signer4: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}signer4'],
      )!,
      checkLoadOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}check_load_override'],
      )!,
      percentErrorOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}percent_error_override'],
      )!,
      withinLimitOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}within_limit_override'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ReportsTable createAlias(String alias) {
    return $ReportsTable(attachedDatabase, alias);
  }
}

class Report extends DataClass implements Insertable<Report> {
  final int id;
  final int consumerId;
  final String reportType;

  /// draft / final
  final String status;
  final String memoNo;
  final DateTime? memoDate;
  final String toSubDivision;

  /// memo / telephonic / seasonal / routine
  final String refType;
  final String refNo;
  final DateTime? refDate;
  final DateTime? visitDate;
  final String teamText;

  /// Snapshot of section A (consumer fields) as JSON, so old reports never change.
  final String sectionAJson;
  final String msbStatus;
  final String postalOrdersText;
  final String checkedLoadKw;

  /// Added in schema v2: load used for the check, printed in the C total row.
  final String loadType;
  final String exportLoadText;
  final String accuracyText;
  final String transformerLtBushes;
  final String remarks;
  final String storeChallanNo;
  final DateTime? storeChallanDate;
  final String newMeterCount;
  final String ctCount;
  final String signerExenOp;
  final String signerSdoOp;
  final String signer3;
  final String signer4;

  /// Manual overrides of the computed values in section C (empty = computed).
  final String checkLoadOverride;
  final String percentErrorOverride;
  final String withinLimitOverride;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Report({
    required this.id,
    required this.consumerId,
    required this.reportType,
    required this.status,
    required this.memoNo,
    this.memoDate,
    required this.toSubDivision,
    required this.refType,
    required this.refNo,
    this.refDate,
    this.visitDate,
    required this.teamText,
    required this.sectionAJson,
    required this.msbStatus,
    required this.postalOrdersText,
    required this.checkedLoadKw,
    required this.loadType,
    required this.exportLoadText,
    required this.accuracyText,
    required this.transformerLtBushes,
    required this.remarks,
    required this.storeChallanNo,
    this.storeChallanDate,
    required this.newMeterCount,
    required this.ctCount,
    required this.signerExenOp,
    required this.signerSdoOp,
    required this.signer3,
    required this.signer4,
    required this.checkLoadOverride,
    required this.percentErrorOverride,
    required this.withinLimitOverride,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['consumer_id'] = Variable<int>(consumerId);
    map['report_type'] = Variable<String>(reportType);
    map['status'] = Variable<String>(status);
    map['memo_no'] = Variable<String>(memoNo);
    if (!nullToAbsent || memoDate != null) {
      map['memo_date'] = Variable<DateTime>(memoDate);
    }
    map['to_sub_division'] = Variable<String>(toSubDivision);
    map['ref_type'] = Variable<String>(refType);
    map['ref_no'] = Variable<String>(refNo);
    if (!nullToAbsent || refDate != null) {
      map['ref_date'] = Variable<DateTime>(refDate);
    }
    if (!nullToAbsent || visitDate != null) {
      map['visit_date'] = Variable<DateTime>(visitDate);
    }
    map['team_text'] = Variable<String>(teamText);
    map['section_a_json'] = Variable<String>(sectionAJson);
    map['msb_status'] = Variable<String>(msbStatus);
    map['postal_orders_text'] = Variable<String>(postalOrdersText);
    map['checked_load_kw'] = Variable<String>(checkedLoadKw);
    map['load_type'] = Variable<String>(loadType);
    map['export_load_text'] = Variable<String>(exportLoadText);
    map['accuracy_text'] = Variable<String>(accuracyText);
    map['transformer_lt_bushes'] = Variable<String>(transformerLtBushes);
    map['remarks'] = Variable<String>(remarks);
    map['store_challan_no'] = Variable<String>(storeChallanNo);
    if (!nullToAbsent || storeChallanDate != null) {
      map['store_challan_date'] = Variable<DateTime>(storeChallanDate);
    }
    map['new_meter_count'] = Variable<String>(newMeterCount);
    map['ct_count'] = Variable<String>(ctCount);
    map['signer_exen_op'] = Variable<String>(signerExenOp);
    map['signer_sdo_op'] = Variable<String>(signerSdoOp);
    map['signer3'] = Variable<String>(signer3);
    map['signer4'] = Variable<String>(signer4);
    map['check_load_override'] = Variable<String>(checkLoadOverride);
    map['percent_error_override'] = Variable<String>(percentErrorOverride);
    map['within_limit_override'] = Variable<String>(withinLimitOverride);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ReportsCompanion toCompanion(bool nullToAbsent) {
    return ReportsCompanion(
      id: Value(id),
      consumerId: Value(consumerId),
      reportType: Value(reportType),
      status: Value(status),
      memoNo: Value(memoNo),
      memoDate: memoDate == null && nullToAbsent
          ? const Value.absent()
          : Value(memoDate),
      toSubDivision: Value(toSubDivision),
      refType: Value(refType),
      refNo: Value(refNo),
      refDate: refDate == null && nullToAbsent
          ? const Value.absent()
          : Value(refDate),
      visitDate: visitDate == null && nullToAbsent
          ? const Value.absent()
          : Value(visitDate),
      teamText: Value(teamText),
      sectionAJson: Value(sectionAJson),
      msbStatus: Value(msbStatus),
      postalOrdersText: Value(postalOrdersText),
      checkedLoadKw: Value(checkedLoadKw),
      loadType: Value(loadType),
      exportLoadText: Value(exportLoadText),
      accuracyText: Value(accuracyText),
      transformerLtBushes: Value(transformerLtBushes),
      remarks: Value(remarks),
      storeChallanNo: Value(storeChallanNo),
      storeChallanDate: storeChallanDate == null && nullToAbsent
          ? const Value.absent()
          : Value(storeChallanDate),
      newMeterCount: Value(newMeterCount),
      ctCount: Value(ctCount),
      signerExenOp: Value(signerExenOp),
      signerSdoOp: Value(signerSdoOp),
      signer3: Value(signer3),
      signer4: Value(signer4),
      checkLoadOverride: Value(checkLoadOverride),
      percentErrorOverride: Value(percentErrorOverride),
      withinLimitOverride: Value(withinLimitOverride),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Report.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Report(
      id: serializer.fromJson<int>(json['id']),
      consumerId: serializer.fromJson<int>(json['consumerId']),
      reportType: serializer.fromJson<String>(json['reportType']),
      status: serializer.fromJson<String>(json['status']),
      memoNo: serializer.fromJson<String>(json['memoNo']),
      memoDate: serializer.fromJson<DateTime?>(json['memoDate']),
      toSubDivision: serializer.fromJson<String>(json['toSubDivision']),
      refType: serializer.fromJson<String>(json['refType']),
      refNo: serializer.fromJson<String>(json['refNo']),
      refDate: serializer.fromJson<DateTime?>(json['refDate']),
      visitDate: serializer.fromJson<DateTime?>(json['visitDate']),
      teamText: serializer.fromJson<String>(json['teamText']),
      sectionAJson: serializer.fromJson<String>(json['sectionAJson']),
      msbStatus: serializer.fromJson<String>(json['msbStatus']),
      postalOrdersText: serializer.fromJson<String>(json['postalOrdersText']),
      checkedLoadKw: serializer.fromJson<String>(json['checkedLoadKw']),
      loadType: serializer.fromJson<String>(json['loadType']),
      exportLoadText: serializer.fromJson<String>(json['exportLoadText']),
      accuracyText: serializer.fromJson<String>(json['accuracyText']),
      transformerLtBushes: serializer.fromJson<String>(
        json['transformerLtBushes'],
      ),
      remarks: serializer.fromJson<String>(json['remarks']),
      storeChallanNo: serializer.fromJson<String>(json['storeChallanNo']),
      storeChallanDate: serializer.fromJson<DateTime?>(
        json['storeChallanDate'],
      ),
      newMeterCount: serializer.fromJson<String>(json['newMeterCount']),
      ctCount: serializer.fromJson<String>(json['ctCount']),
      signerExenOp: serializer.fromJson<String>(json['signerExenOp']),
      signerSdoOp: serializer.fromJson<String>(json['signerSdoOp']),
      signer3: serializer.fromJson<String>(json['signer3']),
      signer4: serializer.fromJson<String>(json['signer4']),
      checkLoadOverride: serializer.fromJson<String>(json['checkLoadOverride']),
      percentErrorOverride: serializer.fromJson<String>(
        json['percentErrorOverride'],
      ),
      withinLimitOverride: serializer.fromJson<String>(
        json['withinLimitOverride'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'consumerId': serializer.toJson<int>(consumerId),
      'reportType': serializer.toJson<String>(reportType),
      'status': serializer.toJson<String>(status),
      'memoNo': serializer.toJson<String>(memoNo),
      'memoDate': serializer.toJson<DateTime?>(memoDate),
      'toSubDivision': serializer.toJson<String>(toSubDivision),
      'refType': serializer.toJson<String>(refType),
      'refNo': serializer.toJson<String>(refNo),
      'refDate': serializer.toJson<DateTime?>(refDate),
      'visitDate': serializer.toJson<DateTime?>(visitDate),
      'teamText': serializer.toJson<String>(teamText),
      'sectionAJson': serializer.toJson<String>(sectionAJson),
      'msbStatus': serializer.toJson<String>(msbStatus),
      'postalOrdersText': serializer.toJson<String>(postalOrdersText),
      'checkedLoadKw': serializer.toJson<String>(checkedLoadKw),
      'loadType': serializer.toJson<String>(loadType),
      'exportLoadText': serializer.toJson<String>(exportLoadText),
      'accuracyText': serializer.toJson<String>(accuracyText),
      'transformerLtBushes': serializer.toJson<String>(transformerLtBushes),
      'remarks': serializer.toJson<String>(remarks),
      'storeChallanNo': serializer.toJson<String>(storeChallanNo),
      'storeChallanDate': serializer.toJson<DateTime?>(storeChallanDate),
      'newMeterCount': serializer.toJson<String>(newMeterCount),
      'ctCount': serializer.toJson<String>(ctCount),
      'signerExenOp': serializer.toJson<String>(signerExenOp),
      'signerSdoOp': serializer.toJson<String>(signerSdoOp),
      'signer3': serializer.toJson<String>(signer3),
      'signer4': serializer.toJson<String>(signer4),
      'checkLoadOverride': serializer.toJson<String>(checkLoadOverride),
      'percentErrorOverride': serializer.toJson<String>(percentErrorOverride),
      'withinLimitOverride': serializer.toJson<String>(withinLimitOverride),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Report copyWith({
    int? id,
    int? consumerId,
    String? reportType,
    String? status,
    String? memoNo,
    Value<DateTime?> memoDate = const Value.absent(),
    String? toSubDivision,
    String? refType,
    String? refNo,
    Value<DateTime?> refDate = const Value.absent(),
    Value<DateTime?> visitDate = const Value.absent(),
    String? teamText,
    String? sectionAJson,
    String? msbStatus,
    String? postalOrdersText,
    String? checkedLoadKw,
    String? loadType,
    String? exportLoadText,
    String? accuracyText,
    String? transformerLtBushes,
    String? remarks,
    String? storeChallanNo,
    Value<DateTime?> storeChallanDate = const Value.absent(),
    String? newMeterCount,
    String? ctCount,
    String? signerExenOp,
    String? signerSdoOp,
    String? signer3,
    String? signer4,
    String? checkLoadOverride,
    String? percentErrorOverride,
    String? withinLimitOverride,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Report(
    id: id ?? this.id,
    consumerId: consumerId ?? this.consumerId,
    reportType: reportType ?? this.reportType,
    status: status ?? this.status,
    memoNo: memoNo ?? this.memoNo,
    memoDate: memoDate.present ? memoDate.value : this.memoDate,
    toSubDivision: toSubDivision ?? this.toSubDivision,
    refType: refType ?? this.refType,
    refNo: refNo ?? this.refNo,
    refDate: refDate.present ? refDate.value : this.refDate,
    visitDate: visitDate.present ? visitDate.value : this.visitDate,
    teamText: teamText ?? this.teamText,
    sectionAJson: sectionAJson ?? this.sectionAJson,
    msbStatus: msbStatus ?? this.msbStatus,
    postalOrdersText: postalOrdersText ?? this.postalOrdersText,
    checkedLoadKw: checkedLoadKw ?? this.checkedLoadKw,
    loadType: loadType ?? this.loadType,
    exportLoadText: exportLoadText ?? this.exportLoadText,
    accuracyText: accuracyText ?? this.accuracyText,
    transformerLtBushes: transformerLtBushes ?? this.transformerLtBushes,
    remarks: remarks ?? this.remarks,
    storeChallanNo: storeChallanNo ?? this.storeChallanNo,
    storeChallanDate: storeChallanDate.present
        ? storeChallanDate.value
        : this.storeChallanDate,
    newMeterCount: newMeterCount ?? this.newMeterCount,
    ctCount: ctCount ?? this.ctCount,
    signerExenOp: signerExenOp ?? this.signerExenOp,
    signerSdoOp: signerSdoOp ?? this.signerSdoOp,
    signer3: signer3 ?? this.signer3,
    signer4: signer4 ?? this.signer4,
    checkLoadOverride: checkLoadOverride ?? this.checkLoadOverride,
    percentErrorOverride: percentErrorOverride ?? this.percentErrorOverride,
    withinLimitOverride: withinLimitOverride ?? this.withinLimitOverride,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Report copyWithCompanion(ReportsCompanion data) {
    return Report(
      id: data.id.present ? data.id.value : this.id,
      consumerId: data.consumerId.present
          ? data.consumerId.value
          : this.consumerId,
      reportType: data.reportType.present
          ? data.reportType.value
          : this.reportType,
      status: data.status.present ? data.status.value : this.status,
      memoNo: data.memoNo.present ? data.memoNo.value : this.memoNo,
      memoDate: data.memoDate.present ? data.memoDate.value : this.memoDate,
      toSubDivision: data.toSubDivision.present
          ? data.toSubDivision.value
          : this.toSubDivision,
      refType: data.refType.present ? data.refType.value : this.refType,
      refNo: data.refNo.present ? data.refNo.value : this.refNo,
      refDate: data.refDate.present ? data.refDate.value : this.refDate,
      visitDate: data.visitDate.present ? data.visitDate.value : this.visitDate,
      teamText: data.teamText.present ? data.teamText.value : this.teamText,
      sectionAJson: data.sectionAJson.present
          ? data.sectionAJson.value
          : this.sectionAJson,
      msbStatus: data.msbStatus.present ? data.msbStatus.value : this.msbStatus,
      postalOrdersText: data.postalOrdersText.present
          ? data.postalOrdersText.value
          : this.postalOrdersText,
      checkedLoadKw: data.checkedLoadKw.present
          ? data.checkedLoadKw.value
          : this.checkedLoadKw,
      loadType: data.loadType.present ? data.loadType.value : this.loadType,
      exportLoadText: data.exportLoadText.present
          ? data.exportLoadText.value
          : this.exportLoadText,
      accuracyText: data.accuracyText.present
          ? data.accuracyText.value
          : this.accuracyText,
      transformerLtBushes: data.transformerLtBushes.present
          ? data.transformerLtBushes.value
          : this.transformerLtBushes,
      remarks: data.remarks.present ? data.remarks.value : this.remarks,
      storeChallanNo: data.storeChallanNo.present
          ? data.storeChallanNo.value
          : this.storeChallanNo,
      storeChallanDate: data.storeChallanDate.present
          ? data.storeChallanDate.value
          : this.storeChallanDate,
      newMeterCount: data.newMeterCount.present
          ? data.newMeterCount.value
          : this.newMeterCount,
      ctCount: data.ctCount.present ? data.ctCount.value : this.ctCount,
      signerExenOp: data.signerExenOp.present
          ? data.signerExenOp.value
          : this.signerExenOp,
      signerSdoOp: data.signerSdoOp.present
          ? data.signerSdoOp.value
          : this.signerSdoOp,
      signer3: data.signer3.present ? data.signer3.value : this.signer3,
      signer4: data.signer4.present ? data.signer4.value : this.signer4,
      checkLoadOverride: data.checkLoadOverride.present
          ? data.checkLoadOverride.value
          : this.checkLoadOverride,
      percentErrorOverride: data.percentErrorOverride.present
          ? data.percentErrorOverride.value
          : this.percentErrorOverride,
      withinLimitOverride: data.withinLimitOverride.present
          ? data.withinLimitOverride.value
          : this.withinLimitOverride,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Report(')
          ..write('id: $id, ')
          ..write('consumerId: $consumerId, ')
          ..write('reportType: $reportType, ')
          ..write('status: $status, ')
          ..write('memoNo: $memoNo, ')
          ..write('memoDate: $memoDate, ')
          ..write('toSubDivision: $toSubDivision, ')
          ..write('refType: $refType, ')
          ..write('refNo: $refNo, ')
          ..write('refDate: $refDate, ')
          ..write('visitDate: $visitDate, ')
          ..write('teamText: $teamText, ')
          ..write('sectionAJson: $sectionAJson, ')
          ..write('msbStatus: $msbStatus, ')
          ..write('postalOrdersText: $postalOrdersText, ')
          ..write('checkedLoadKw: $checkedLoadKw, ')
          ..write('loadType: $loadType, ')
          ..write('exportLoadText: $exportLoadText, ')
          ..write('accuracyText: $accuracyText, ')
          ..write('transformerLtBushes: $transformerLtBushes, ')
          ..write('remarks: $remarks, ')
          ..write('storeChallanNo: $storeChallanNo, ')
          ..write('storeChallanDate: $storeChallanDate, ')
          ..write('newMeterCount: $newMeterCount, ')
          ..write('ctCount: $ctCount, ')
          ..write('signerExenOp: $signerExenOp, ')
          ..write('signerSdoOp: $signerSdoOp, ')
          ..write('signer3: $signer3, ')
          ..write('signer4: $signer4, ')
          ..write('checkLoadOverride: $checkLoadOverride, ')
          ..write('percentErrorOverride: $percentErrorOverride, ')
          ..write('withinLimitOverride: $withinLimitOverride, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    consumerId,
    reportType,
    status,
    memoNo,
    memoDate,
    toSubDivision,
    refType,
    refNo,
    refDate,
    visitDate,
    teamText,
    sectionAJson,
    msbStatus,
    postalOrdersText,
    checkedLoadKw,
    loadType,
    exportLoadText,
    accuracyText,
    transformerLtBushes,
    remarks,
    storeChallanNo,
    storeChallanDate,
    newMeterCount,
    ctCount,
    signerExenOp,
    signerSdoOp,
    signer3,
    signer4,
    checkLoadOverride,
    percentErrorOverride,
    withinLimitOverride,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Report &&
          other.id == this.id &&
          other.consumerId == this.consumerId &&
          other.reportType == this.reportType &&
          other.status == this.status &&
          other.memoNo == this.memoNo &&
          other.memoDate == this.memoDate &&
          other.toSubDivision == this.toSubDivision &&
          other.refType == this.refType &&
          other.refNo == this.refNo &&
          other.refDate == this.refDate &&
          other.visitDate == this.visitDate &&
          other.teamText == this.teamText &&
          other.sectionAJson == this.sectionAJson &&
          other.msbStatus == this.msbStatus &&
          other.postalOrdersText == this.postalOrdersText &&
          other.checkedLoadKw == this.checkedLoadKw &&
          other.loadType == this.loadType &&
          other.exportLoadText == this.exportLoadText &&
          other.accuracyText == this.accuracyText &&
          other.transformerLtBushes == this.transformerLtBushes &&
          other.remarks == this.remarks &&
          other.storeChallanNo == this.storeChallanNo &&
          other.storeChallanDate == this.storeChallanDate &&
          other.newMeterCount == this.newMeterCount &&
          other.ctCount == this.ctCount &&
          other.signerExenOp == this.signerExenOp &&
          other.signerSdoOp == this.signerSdoOp &&
          other.signer3 == this.signer3 &&
          other.signer4 == this.signer4 &&
          other.checkLoadOverride == this.checkLoadOverride &&
          other.percentErrorOverride == this.percentErrorOverride &&
          other.withinLimitOverride == this.withinLimitOverride &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class ReportsCompanion extends UpdateCompanion<Report> {
  final Value<int> id;
  final Value<int> consumerId;
  final Value<String> reportType;
  final Value<String> status;
  final Value<String> memoNo;
  final Value<DateTime?> memoDate;
  final Value<String> toSubDivision;
  final Value<String> refType;
  final Value<String> refNo;
  final Value<DateTime?> refDate;
  final Value<DateTime?> visitDate;
  final Value<String> teamText;
  final Value<String> sectionAJson;
  final Value<String> msbStatus;
  final Value<String> postalOrdersText;
  final Value<String> checkedLoadKw;
  final Value<String> loadType;
  final Value<String> exportLoadText;
  final Value<String> accuracyText;
  final Value<String> transformerLtBushes;
  final Value<String> remarks;
  final Value<String> storeChallanNo;
  final Value<DateTime?> storeChallanDate;
  final Value<String> newMeterCount;
  final Value<String> ctCount;
  final Value<String> signerExenOp;
  final Value<String> signerSdoOp;
  final Value<String> signer3;
  final Value<String> signer4;
  final Value<String> checkLoadOverride;
  final Value<String> percentErrorOverride;
  final Value<String> withinLimitOverride;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const ReportsCompanion({
    this.id = const Value.absent(),
    this.consumerId = const Value.absent(),
    this.reportType = const Value.absent(),
    this.status = const Value.absent(),
    this.memoNo = const Value.absent(),
    this.memoDate = const Value.absent(),
    this.toSubDivision = const Value.absent(),
    this.refType = const Value.absent(),
    this.refNo = const Value.absent(),
    this.refDate = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.teamText = const Value.absent(),
    this.sectionAJson = const Value.absent(),
    this.msbStatus = const Value.absent(),
    this.postalOrdersText = const Value.absent(),
    this.checkedLoadKw = const Value.absent(),
    this.loadType = const Value.absent(),
    this.exportLoadText = const Value.absent(),
    this.accuracyText = const Value.absent(),
    this.transformerLtBushes = const Value.absent(),
    this.remarks = const Value.absent(),
    this.storeChallanNo = const Value.absent(),
    this.storeChallanDate = const Value.absent(),
    this.newMeterCount = const Value.absent(),
    this.ctCount = const Value.absent(),
    this.signerExenOp = const Value.absent(),
    this.signerSdoOp = const Value.absent(),
    this.signer3 = const Value.absent(),
    this.signer4 = const Value.absent(),
    this.checkLoadOverride = const Value.absent(),
    this.percentErrorOverride = const Value.absent(),
    this.withinLimitOverride = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ReportsCompanion.insert({
    this.id = const Value.absent(),
    required int consumerId,
    required String reportType,
    this.status = const Value.absent(),
    this.memoNo = const Value.absent(),
    this.memoDate = const Value.absent(),
    this.toSubDivision = const Value.absent(),
    this.refType = const Value.absent(),
    this.refNo = const Value.absent(),
    this.refDate = const Value.absent(),
    this.visitDate = const Value.absent(),
    this.teamText = const Value.absent(),
    this.sectionAJson = const Value.absent(),
    this.msbStatus = const Value.absent(),
    this.postalOrdersText = const Value.absent(),
    this.checkedLoadKw = const Value.absent(),
    this.loadType = const Value.absent(),
    this.exportLoadText = const Value.absent(),
    this.accuracyText = const Value.absent(),
    this.transformerLtBushes = const Value.absent(),
    this.remarks = const Value.absent(),
    this.storeChallanNo = const Value.absent(),
    this.storeChallanDate = const Value.absent(),
    this.newMeterCount = const Value.absent(),
    this.ctCount = const Value.absent(),
    this.signerExenOp = const Value.absent(),
    this.signerSdoOp = const Value.absent(),
    this.signer3 = const Value.absent(),
    this.signer4 = const Value.absent(),
    this.checkLoadOverride = const Value.absent(),
    this.percentErrorOverride = const Value.absent(),
    this.withinLimitOverride = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : consumerId = Value(consumerId),
       reportType = Value(reportType);
  static Insertable<Report> custom({
    Expression<int>? id,
    Expression<int>? consumerId,
    Expression<String>? reportType,
    Expression<String>? status,
    Expression<String>? memoNo,
    Expression<DateTime>? memoDate,
    Expression<String>? toSubDivision,
    Expression<String>? refType,
    Expression<String>? refNo,
    Expression<DateTime>? refDate,
    Expression<DateTime>? visitDate,
    Expression<String>? teamText,
    Expression<String>? sectionAJson,
    Expression<String>? msbStatus,
    Expression<String>? postalOrdersText,
    Expression<String>? checkedLoadKw,
    Expression<String>? loadType,
    Expression<String>? exportLoadText,
    Expression<String>? accuracyText,
    Expression<String>? transformerLtBushes,
    Expression<String>? remarks,
    Expression<String>? storeChallanNo,
    Expression<DateTime>? storeChallanDate,
    Expression<String>? newMeterCount,
    Expression<String>? ctCount,
    Expression<String>? signerExenOp,
    Expression<String>? signerSdoOp,
    Expression<String>? signer3,
    Expression<String>? signer4,
    Expression<String>? checkLoadOverride,
    Expression<String>? percentErrorOverride,
    Expression<String>? withinLimitOverride,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (consumerId != null) 'consumer_id': consumerId,
      if (reportType != null) 'report_type': reportType,
      if (status != null) 'status': status,
      if (memoNo != null) 'memo_no': memoNo,
      if (memoDate != null) 'memo_date': memoDate,
      if (toSubDivision != null) 'to_sub_division': toSubDivision,
      if (refType != null) 'ref_type': refType,
      if (refNo != null) 'ref_no': refNo,
      if (refDate != null) 'ref_date': refDate,
      if (visitDate != null) 'visit_date': visitDate,
      if (teamText != null) 'team_text': teamText,
      if (sectionAJson != null) 'section_a_json': sectionAJson,
      if (msbStatus != null) 'msb_status': msbStatus,
      if (postalOrdersText != null) 'postal_orders_text': postalOrdersText,
      if (checkedLoadKw != null) 'checked_load_kw': checkedLoadKw,
      if (loadType != null) 'load_type': loadType,
      if (exportLoadText != null) 'export_load_text': exportLoadText,
      if (accuracyText != null) 'accuracy_text': accuracyText,
      if (transformerLtBushes != null)
        'transformer_lt_bushes': transformerLtBushes,
      if (remarks != null) 'remarks': remarks,
      if (storeChallanNo != null) 'store_challan_no': storeChallanNo,
      if (storeChallanDate != null) 'store_challan_date': storeChallanDate,
      if (newMeterCount != null) 'new_meter_count': newMeterCount,
      if (ctCount != null) 'ct_count': ctCount,
      if (signerExenOp != null) 'signer_exen_op': signerExenOp,
      if (signerSdoOp != null) 'signer_sdo_op': signerSdoOp,
      if (signer3 != null) 'signer3': signer3,
      if (signer4 != null) 'signer4': signer4,
      if (checkLoadOverride != null) 'check_load_override': checkLoadOverride,
      if (percentErrorOverride != null)
        'percent_error_override': percentErrorOverride,
      if (withinLimitOverride != null)
        'within_limit_override': withinLimitOverride,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ReportsCompanion copyWith({
    Value<int>? id,
    Value<int>? consumerId,
    Value<String>? reportType,
    Value<String>? status,
    Value<String>? memoNo,
    Value<DateTime?>? memoDate,
    Value<String>? toSubDivision,
    Value<String>? refType,
    Value<String>? refNo,
    Value<DateTime?>? refDate,
    Value<DateTime?>? visitDate,
    Value<String>? teamText,
    Value<String>? sectionAJson,
    Value<String>? msbStatus,
    Value<String>? postalOrdersText,
    Value<String>? checkedLoadKw,
    Value<String>? loadType,
    Value<String>? exportLoadText,
    Value<String>? accuracyText,
    Value<String>? transformerLtBushes,
    Value<String>? remarks,
    Value<String>? storeChallanNo,
    Value<DateTime?>? storeChallanDate,
    Value<String>? newMeterCount,
    Value<String>? ctCount,
    Value<String>? signerExenOp,
    Value<String>? signerSdoOp,
    Value<String>? signer3,
    Value<String>? signer4,
    Value<String>? checkLoadOverride,
    Value<String>? percentErrorOverride,
    Value<String>? withinLimitOverride,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return ReportsCompanion(
      id: id ?? this.id,
      consumerId: consumerId ?? this.consumerId,
      reportType: reportType ?? this.reportType,
      status: status ?? this.status,
      memoNo: memoNo ?? this.memoNo,
      memoDate: memoDate ?? this.memoDate,
      toSubDivision: toSubDivision ?? this.toSubDivision,
      refType: refType ?? this.refType,
      refNo: refNo ?? this.refNo,
      refDate: refDate ?? this.refDate,
      visitDate: visitDate ?? this.visitDate,
      teamText: teamText ?? this.teamText,
      sectionAJson: sectionAJson ?? this.sectionAJson,
      msbStatus: msbStatus ?? this.msbStatus,
      postalOrdersText: postalOrdersText ?? this.postalOrdersText,
      checkedLoadKw: checkedLoadKw ?? this.checkedLoadKw,
      loadType: loadType ?? this.loadType,
      exportLoadText: exportLoadText ?? this.exportLoadText,
      accuracyText: accuracyText ?? this.accuracyText,
      transformerLtBushes: transformerLtBushes ?? this.transformerLtBushes,
      remarks: remarks ?? this.remarks,
      storeChallanNo: storeChallanNo ?? this.storeChallanNo,
      storeChallanDate: storeChallanDate ?? this.storeChallanDate,
      newMeterCount: newMeterCount ?? this.newMeterCount,
      ctCount: ctCount ?? this.ctCount,
      signerExenOp: signerExenOp ?? this.signerExenOp,
      signerSdoOp: signerSdoOp ?? this.signerSdoOp,
      signer3: signer3 ?? this.signer3,
      signer4: signer4 ?? this.signer4,
      checkLoadOverride: checkLoadOverride ?? this.checkLoadOverride,
      percentErrorOverride: percentErrorOverride ?? this.percentErrorOverride,
      withinLimitOverride: withinLimitOverride ?? this.withinLimitOverride,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (consumerId.present) {
      map['consumer_id'] = Variable<int>(consumerId.value);
    }
    if (reportType.present) {
      map['report_type'] = Variable<String>(reportType.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (memoNo.present) {
      map['memo_no'] = Variable<String>(memoNo.value);
    }
    if (memoDate.present) {
      map['memo_date'] = Variable<DateTime>(memoDate.value);
    }
    if (toSubDivision.present) {
      map['to_sub_division'] = Variable<String>(toSubDivision.value);
    }
    if (refType.present) {
      map['ref_type'] = Variable<String>(refType.value);
    }
    if (refNo.present) {
      map['ref_no'] = Variable<String>(refNo.value);
    }
    if (refDate.present) {
      map['ref_date'] = Variable<DateTime>(refDate.value);
    }
    if (visitDate.present) {
      map['visit_date'] = Variable<DateTime>(visitDate.value);
    }
    if (teamText.present) {
      map['team_text'] = Variable<String>(teamText.value);
    }
    if (sectionAJson.present) {
      map['section_a_json'] = Variable<String>(sectionAJson.value);
    }
    if (msbStatus.present) {
      map['msb_status'] = Variable<String>(msbStatus.value);
    }
    if (postalOrdersText.present) {
      map['postal_orders_text'] = Variable<String>(postalOrdersText.value);
    }
    if (checkedLoadKw.present) {
      map['checked_load_kw'] = Variable<String>(checkedLoadKw.value);
    }
    if (loadType.present) {
      map['load_type'] = Variable<String>(loadType.value);
    }
    if (exportLoadText.present) {
      map['export_load_text'] = Variable<String>(exportLoadText.value);
    }
    if (accuracyText.present) {
      map['accuracy_text'] = Variable<String>(accuracyText.value);
    }
    if (transformerLtBushes.present) {
      map['transformer_lt_bushes'] = Variable<String>(
        transformerLtBushes.value,
      );
    }
    if (remarks.present) {
      map['remarks'] = Variable<String>(remarks.value);
    }
    if (storeChallanNo.present) {
      map['store_challan_no'] = Variable<String>(storeChallanNo.value);
    }
    if (storeChallanDate.present) {
      map['store_challan_date'] = Variable<DateTime>(storeChallanDate.value);
    }
    if (newMeterCount.present) {
      map['new_meter_count'] = Variable<String>(newMeterCount.value);
    }
    if (ctCount.present) {
      map['ct_count'] = Variable<String>(ctCount.value);
    }
    if (signerExenOp.present) {
      map['signer_exen_op'] = Variable<String>(signerExenOp.value);
    }
    if (signerSdoOp.present) {
      map['signer_sdo_op'] = Variable<String>(signerSdoOp.value);
    }
    if (signer3.present) {
      map['signer3'] = Variable<String>(signer3.value);
    }
    if (signer4.present) {
      map['signer4'] = Variable<String>(signer4.value);
    }
    if (checkLoadOverride.present) {
      map['check_load_override'] = Variable<String>(checkLoadOverride.value);
    }
    if (percentErrorOverride.present) {
      map['percent_error_override'] = Variable<String>(
        percentErrorOverride.value,
      );
    }
    if (withinLimitOverride.present) {
      map['within_limit_override'] = Variable<String>(
        withinLimitOverride.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportsCompanion(')
          ..write('id: $id, ')
          ..write('consumerId: $consumerId, ')
          ..write('reportType: $reportType, ')
          ..write('status: $status, ')
          ..write('memoNo: $memoNo, ')
          ..write('memoDate: $memoDate, ')
          ..write('toSubDivision: $toSubDivision, ')
          ..write('refType: $refType, ')
          ..write('refNo: $refNo, ')
          ..write('refDate: $refDate, ')
          ..write('visitDate: $visitDate, ')
          ..write('teamText: $teamText, ')
          ..write('sectionAJson: $sectionAJson, ')
          ..write('msbStatus: $msbStatus, ')
          ..write('postalOrdersText: $postalOrdersText, ')
          ..write('checkedLoadKw: $checkedLoadKw, ')
          ..write('loadType: $loadType, ')
          ..write('exportLoadText: $exportLoadText, ')
          ..write('accuracyText: $accuracyText, ')
          ..write('transformerLtBushes: $transformerLtBushes, ')
          ..write('remarks: $remarks, ')
          ..write('storeChallanNo: $storeChallanNo, ')
          ..write('storeChallanDate: $storeChallanDate, ')
          ..write('newMeterCount: $newMeterCount, ')
          ..write('ctCount: $ctCount, ')
          ..write('signerExenOp: $signerExenOp, ')
          ..write('signerSdoOp: $signerSdoOp, ')
          ..write('signer3: $signer3, ')
          ..write('signer4: $signer4, ')
          ..write('checkLoadOverride: $checkLoadOverride, ')
          ..write('percentErrorOverride: $percentErrorOverride, ')
          ..write('withinLimitOverride: $withinLimitOverride, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ReportMetersTable extends ReportMeters
    with TableInfo<$ReportMetersTable, ReportMeter> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReportMetersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<int> reportId = GeneratedColumn<int>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _meterIdMeta = const VerificationMeta(
    'meterId',
  );
  @override
  late final GeneratedColumn<int> meterId = GeneratedColumn<int>(
    'meter_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES meters (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _columnRoleMeta = const VerificationMeta(
    'columnRole',
  );
  @override
  late final GeneratedColumn<String> columnRole = GeneratedColumn<String>(
    'column_role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notApplicableMeta = const VerificationMeta(
    'notApplicable',
  );
  @override
  late final GeneratedColumn<bool> notApplicable = GeneratedColumn<bool>(
    'not_applicable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("not_applicable" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    meterId,
    columnRole,
    notApplicable,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'report_meters';
  @override
  VerificationContext validateIntegrity(
    Insertable<ReportMeter> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('meter_id')) {
      context.handle(
        _meterIdMeta,
        meterId.isAcceptableOrUnknown(data['meter_id']!, _meterIdMeta),
      );
    }
    if (data.containsKey('column_role')) {
      context.handle(
        _columnRoleMeta,
        columnRole.isAcceptableOrUnknown(data['column_role']!, _columnRoleMeta),
      );
    } else if (isInserting) {
      context.missing(_columnRoleMeta);
    }
    if (data.containsKey('not_applicable')) {
      context.handle(
        _notApplicableMeta,
        notApplicable.isAcceptableOrUnknown(
          data['not_applicable']!,
          _notApplicableMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ReportMeter map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ReportMeter(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_id'],
      )!,
      meterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}meter_id'],
      ),
      columnRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}column_role'],
      )!,
      notApplicable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}not_applicable'],
      )!,
    );
  }

  @override
  $ReportMetersTable createAlias(String alias) {
    return $ReportMetersTable(attachedDatabase, alias);
  }
}

class ReportMeter extends DataClass implements Insertable<ReportMeter> {
  final int id;
  final int reportId;
  final int? meterId;

  /// removed / amr / existing / billing / backup / backup_removed
  final String columnRole;
  final bool notApplicable;
  const ReportMeter({
    required this.id,
    required this.reportId,
    this.meterId,
    required this.columnRole,
    required this.notApplicable,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['report_id'] = Variable<int>(reportId);
    if (!nullToAbsent || meterId != null) {
      map['meter_id'] = Variable<int>(meterId);
    }
    map['column_role'] = Variable<String>(columnRole);
    map['not_applicable'] = Variable<bool>(notApplicable);
    return map;
  }

  ReportMetersCompanion toCompanion(bool nullToAbsent) {
    return ReportMetersCompanion(
      id: Value(id),
      reportId: Value(reportId),
      meterId: meterId == null && nullToAbsent
          ? const Value.absent()
          : Value(meterId),
      columnRole: Value(columnRole),
      notApplicable: Value(notApplicable),
    );
  }

  factory ReportMeter.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ReportMeter(
      id: serializer.fromJson<int>(json['id']),
      reportId: serializer.fromJson<int>(json['reportId']),
      meterId: serializer.fromJson<int?>(json['meterId']),
      columnRole: serializer.fromJson<String>(json['columnRole']),
      notApplicable: serializer.fromJson<bool>(json['notApplicable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reportId': serializer.toJson<int>(reportId),
      'meterId': serializer.toJson<int?>(meterId),
      'columnRole': serializer.toJson<String>(columnRole),
      'notApplicable': serializer.toJson<bool>(notApplicable),
    };
  }

  ReportMeter copyWith({
    int? id,
    int? reportId,
    Value<int?> meterId = const Value.absent(),
    String? columnRole,
    bool? notApplicable,
  }) => ReportMeter(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    meterId: meterId.present ? meterId.value : this.meterId,
    columnRole: columnRole ?? this.columnRole,
    notApplicable: notApplicable ?? this.notApplicable,
  );
  ReportMeter copyWithCompanion(ReportMetersCompanion data) {
    return ReportMeter(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      meterId: data.meterId.present ? data.meterId.value : this.meterId,
      columnRole: data.columnRole.present
          ? data.columnRole.value
          : this.columnRole,
      notApplicable: data.notApplicable.present
          ? data.notApplicable.value
          : this.notApplicable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ReportMeter(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('meterId: $meterId, ')
          ..write('columnRole: $columnRole, ')
          ..write('notApplicable: $notApplicable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reportId, meterId, columnRole, notApplicable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ReportMeter &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.meterId == this.meterId &&
          other.columnRole == this.columnRole &&
          other.notApplicable == this.notApplicable);
}

class ReportMetersCompanion extends UpdateCompanion<ReportMeter> {
  final Value<int> id;
  final Value<int> reportId;
  final Value<int?> meterId;
  final Value<String> columnRole;
  final Value<bool> notApplicable;
  const ReportMetersCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.meterId = const Value.absent(),
    this.columnRole = const Value.absent(),
    this.notApplicable = const Value.absent(),
  });
  ReportMetersCompanion.insert({
    this.id = const Value.absent(),
    required int reportId,
    this.meterId = const Value.absent(),
    required String columnRole,
    this.notApplicable = const Value.absent(),
  }) : reportId = Value(reportId),
       columnRole = Value(columnRole);
  static Insertable<ReportMeter> custom({
    Expression<int>? id,
    Expression<int>? reportId,
    Expression<int>? meterId,
    Expression<String>? columnRole,
    Expression<bool>? notApplicable,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (meterId != null) 'meter_id': meterId,
      if (columnRole != null) 'column_role': columnRole,
      if (notApplicable != null) 'not_applicable': notApplicable,
    });
  }

  ReportMetersCompanion copyWith({
    Value<int>? id,
    Value<int>? reportId,
    Value<int?>? meterId,
    Value<String>? columnRole,
    Value<bool>? notApplicable,
  }) {
    return ReportMetersCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      meterId: meterId ?? this.meterId,
      columnRole: columnRole ?? this.columnRole,
      notApplicable: notApplicable ?? this.notApplicable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<int>(reportId.value);
    }
    if (meterId.present) {
      map['meter_id'] = Variable<int>(meterId.value);
    }
    if (columnRole.present) {
      map['column_role'] = Variable<String>(columnRole.value);
    }
    if (notApplicable.present) {
      map['not_applicable'] = Variable<bool>(notApplicable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReportMetersCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('meterId: $meterId, ')
          ..write('columnRole: $columnRole, ')
          ..write('notApplicable: $notApplicable')
          ..write(')'))
        .toString();
  }
}

class $ReadingsTable extends Readings with TableInfo<$ReadingsTable, Reading> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReadingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<int> reportId = GeneratedColumn<int>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _reportMeterIdMeta = const VerificationMeta(
    'reportMeterId',
  );
  @override
  late final GeneratedColumn<int> reportMeterId = GeneratedColumn<int>(
    'report_meter_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES report_meters (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _paramCodeMeta = const VerificationMeta(
    'paramCode',
  );
  @override
  late final GeneratedColumn<String> paramCode = GeneratedColumn<String>(
    'param_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueTextMeta = const VerificationMeta(
    'valueText',
  );
  @override
  late final GeneratedColumn<String> valueText = GeneratedColumn<String>(
    'value_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    reportMeterId,
    paramCode,
    valueText,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'readings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reading> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('report_meter_id')) {
      context.handle(
        _reportMeterIdMeta,
        reportMeterId.isAcceptableOrUnknown(
          data['report_meter_id']!,
          _reportMeterIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_reportMeterIdMeta);
    }
    if (data.containsKey('param_code')) {
      context.handle(
        _paramCodeMeta,
        paramCode.isAcceptableOrUnknown(data['param_code']!, _paramCodeMeta),
      );
    } else if (isInserting) {
      context.missing(_paramCodeMeta);
    }
    if (data.containsKey('value_text')) {
      context.handle(
        _valueTextMeta,
        valueText.isAcceptableOrUnknown(data['value_text']!, _valueTextMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reading map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reading(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_id'],
      )!,
      reportMeterId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_meter_id'],
      )!,
      paramCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}param_code'],
      )!,
      valueText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value_text'],
      )!,
    );
  }

  @override
  $ReadingsTable createAlias(String alias) {
    return $ReadingsTable(attachedDatabase, alias);
  }
}

class Reading extends DataClass implements Insertable<Reading> {
  final int id;
  final int reportId;
  final int reportMeterId;
  final String paramCode;
  final String valueText;
  const Reading({
    required this.id,
    required this.reportId,
    required this.reportMeterId,
    required this.paramCode,
    required this.valueText,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['report_id'] = Variable<int>(reportId);
    map['report_meter_id'] = Variable<int>(reportMeterId);
    map['param_code'] = Variable<String>(paramCode);
    map['value_text'] = Variable<String>(valueText);
    return map;
  }

  ReadingsCompanion toCompanion(bool nullToAbsent) {
    return ReadingsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      reportMeterId: Value(reportMeterId),
      paramCode: Value(paramCode),
      valueText: Value(valueText),
    );
  }

  factory Reading.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reading(
      id: serializer.fromJson<int>(json['id']),
      reportId: serializer.fromJson<int>(json['reportId']),
      reportMeterId: serializer.fromJson<int>(json['reportMeterId']),
      paramCode: serializer.fromJson<String>(json['paramCode']),
      valueText: serializer.fromJson<String>(json['valueText']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reportId': serializer.toJson<int>(reportId),
      'reportMeterId': serializer.toJson<int>(reportMeterId),
      'paramCode': serializer.toJson<String>(paramCode),
      'valueText': serializer.toJson<String>(valueText),
    };
  }

  Reading copyWith({
    int? id,
    int? reportId,
    int? reportMeterId,
    String? paramCode,
    String? valueText,
  }) => Reading(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    reportMeterId: reportMeterId ?? this.reportMeterId,
    paramCode: paramCode ?? this.paramCode,
    valueText: valueText ?? this.valueText,
  );
  Reading copyWithCompanion(ReadingsCompanion data) {
    return Reading(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      reportMeterId: data.reportMeterId.present
          ? data.reportMeterId.value
          : this.reportMeterId,
      paramCode: data.paramCode.present ? data.paramCode.value : this.paramCode,
      valueText: data.valueText.present ? data.valueText.value : this.valueText,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reading(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('reportMeterId: $reportMeterId, ')
          ..write('paramCode: $paramCode, ')
          ..write('valueText: $valueText')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reportId, reportMeterId, paramCode, valueText);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reading &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.reportMeterId == this.reportMeterId &&
          other.paramCode == this.paramCode &&
          other.valueText == this.valueText);
}

class ReadingsCompanion extends UpdateCompanion<Reading> {
  final Value<int> id;
  final Value<int> reportId;
  final Value<int> reportMeterId;
  final Value<String> paramCode;
  final Value<String> valueText;
  const ReadingsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.reportMeterId = const Value.absent(),
    this.paramCode = const Value.absent(),
    this.valueText = const Value.absent(),
  });
  ReadingsCompanion.insert({
    this.id = const Value.absent(),
    required int reportId,
    required int reportMeterId,
    required String paramCode,
    this.valueText = const Value.absent(),
  }) : reportId = Value(reportId),
       reportMeterId = Value(reportMeterId),
       paramCode = Value(paramCode);
  static Insertable<Reading> custom({
    Expression<int>? id,
    Expression<int>? reportId,
    Expression<int>? reportMeterId,
    Expression<String>? paramCode,
    Expression<String>? valueText,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (reportMeterId != null) 'report_meter_id': reportMeterId,
      if (paramCode != null) 'param_code': paramCode,
      if (valueText != null) 'value_text': valueText,
    });
  }

  ReadingsCompanion copyWith({
    Value<int>? id,
    Value<int>? reportId,
    Value<int>? reportMeterId,
    Value<String>? paramCode,
    Value<String>? valueText,
  }) {
    return ReadingsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      reportMeterId: reportMeterId ?? this.reportMeterId,
      paramCode: paramCode ?? this.paramCode,
      valueText: valueText ?? this.valueText,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<int>(reportId.value);
    }
    if (reportMeterId.present) {
      map['report_meter_id'] = Variable<int>(reportMeterId.value);
    }
    if (paramCode.present) {
      map['param_code'] = Variable<String>(paramCode.value);
    }
    if (valueText.present) {
      map['value_text'] = Variable<String>(valueText.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReadingsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('reportMeterId: $reportMeterId, ')
          ..write('paramCode: $paramCode, ')
          ..write('valueText: $valueText')
          ..write(')'))
        .toString();
  }
}

class $PhaseLoadsTable extends PhaseLoads
    with TableInfo<$PhaseLoadsTable, PhaseLoad> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PhaseLoadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<int> reportId = GeneratedColumn<int>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _sideMeta = const VerificationMeta('side');
  @override
  late final GeneratedColumn<String> side = GeneratedColumn<String>(
    'side',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phaseMeta = const VerificationMeta('phase');
  @override
  late final GeneratedColumn<String> phase = GeneratedColumn<String>(
    'phase',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _voltsMeta = const VerificationMeta('volts');
  @override
  late final GeneratedColumn<String> volts = GeneratedColumn<String>(
    'volts',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ampsMeta = const VerificationMeta('amps');
  @override
  late final GeneratedColumn<String> amps = GeneratedColumn<String>(
    'amps',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _kwOverrideMeta = const VerificationMeta(
    'kwOverride',
  );
  @override
  late final GeneratedColumn<String> kwOverride = GeneratedColumn<String>(
    'kw_override',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _pfMeta = const VerificationMeta('pf');
  @override
  late final GeneratedColumn<String> pf = GeneratedColumn<String>(
    'pf',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    side,
    phase,
    volts,
    amps,
    kwOverride,
    pf,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'phase_loads';
  @override
  VerificationContext validateIntegrity(
    Insertable<PhaseLoad> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('side')) {
      context.handle(
        _sideMeta,
        side.isAcceptableOrUnknown(data['side']!, _sideMeta),
      );
    } else if (isInserting) {
      context.missing(_sideMeta);
    }
    if (data.containsKey('phase')) {
      context.handle(
        _phaseMeta,
        phase.isAcceptableOrUnknown(data['phase']!, _phaseMeta),
      );
    } else if (isInserting) {
      context.missing(_phaseMeta);
    }
    if (data.containsKey('volts')) {
      context.handle(
        _voltsMeta,
        volts.isAcceptableOrUnknown(data['volts']!, _voltsMeta),
      );
    }
    if (data.containsKey('amps')) {
      context.handle(
        _ampsMeta,
        amps.isAcceptableOrUnknown(data['amps']!, _ampsMeta),
      );
    }
    if (data.containsKey('kw_override')) {
      context.handle(
        _kwOverrideMeta,
        kwOverride.isAcceptableOrUnknown(data['kw_override']!, _kwOverrideMeta),
      );
    }
    if (data.containsKey('pf')) {
      context.handle(_pfMeta, pf.isAcceptableOrUnknown(data['pf']!, _pfMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PhaseLoad map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PhaseLoad(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_id'],
      )!,
      side: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}side'],
      )!,
      phase: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phase'],
      )!,
      volts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}volts'],
      )!,
      amps: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amps'],
      )!,
      kwOverride: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}kw_override'],
      )!,
      pf: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pf'],
      )!,
    );
  }

  @override
  $PhaseLoadsTable createAlias(String alias) {
    return $PhaseLoadsTable(attachedDatabase, alias);
  }
}

class PhaseLoad extends DataClass implements Insertable<PhaseLoad> {
  final int id;
  final int reportId;

  /// import / export
  final String side;

  /// R / Y / B
  final String phase;
  final String volts;
  final String amps;
  final String kwOverride;
  final String pf;
  const PhaseLoad({
    required this.id,
    required this.reportId,
    required this.side,
    required this.phase,
    required this.volts,
    required this.amps,
    required this.kwOverride,
    required this.pf,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['report_id'] = Variable<int>(reportId);
    map['side'] = Variable<String>(side);
    map['phase'] = Variable<String>(phase);
    map['volts'] = Variable<String>(volts);
    map['amps'] = Variable<String>(amps);
    map['kw_override'] = Variable<String>(kwOverride);
    map['pf'] = Variable<String>(pf);
    return map;
  }

  PhaseLoadsCompanion toCompanion(bool nullToAbsent) {
    return PhaseLoadsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      side: Value(side),
      phase: Value(phase),
      volts: Value(volts),
      amps: Value(amps),
      kwOverride: Value(kwOverride),
      pf: Value(pf),
    );
  }

  factory PhaseLoad.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PhaseLoad(
      id: serializer.fromJson<int>(json['id']),
      reportId: serializer.fromJson<int>(json['reportId']),
      side: serializer.fromJson<String>(json['side']),
      phase: serializer.fromJson<String>(json['phase']),
      volts: serializer.fromJson<String>(json['volts']),
      amps: serializer.fromJson<String>(json['amps']),
      kwOverride: serializer.fromJson<String>(json['kwOverride']),
      pf: serializer.fromJson<String>(json['pf']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reportId': serializer.toJson<int>(reportId),
      'side': serializer.toJson<String>(side),
      'phase': serializer.toJson<String>(phase),
      'volts': serializer.toJson<String>(volts),
      'amps': serializer.toJson<String>(amps),
      'kwOverride': serializer.toJson<String>(kwOverride),
      'pf': serializer.toJson<String>(pf),
    };
  }

  PhaseLoad copyWith({
    int? id,
    int? reportId,
    String? side,
    String? phase,
    String? volts,
    String? amps,
    String? kwOverride,
    String? pf,
  }) => PhaseLoad(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    side: side ?? this.side,
    phase: phase ?? this.phase,
    volts: volts ?? this.volts,
    amps: amps ?? this.amps,
    kwOverride: kwOverride ?? this.kwOverride,
    pf: pf ?? this.pf,
  );
  PhaseLoad copyWithCompanion(PhaseLoadsCompanion data) {
    return PhaseLoad(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      side: data.side.present ? data.side.value : this.side,
      phase: data.phase.present ? data.phase.value : this.phase,
      volts: data.volts.present ? data.volts.value : this.volts,
      amps: data.amps.present ? data.amps.value : this.amps,
      kwOverride: data.kwOverride.present
          ? data.kwOverride.value
          : this.kwOverride,
      pf: data.pf.present ? data.pf.value : this.pf,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PhaseLoad(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('side: $side, ')
          ..write('phase: $phase, ')
          ..write('volts: $volts, ')
          ..write('amps: $amps, ')
          ..write('kwOverride: $kwOverride, ')
          ..write('pf: $pf')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reportId, side, phase, volts, amps, kwOverride, pf);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhaseLoad &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.side == this.side &&
          other.phase == this.phase &&
          other.volts == this.volts &&
          other.amps == this.amps &&
          other.kwOverride == this.kwOverride &&
          other.pf == this.pf);
}

class PhaseLoadsCompanion extends UpdateCompanion<PhaseLoad> {
  final Value<int> id;
  final Value<int> reportId;
  final Value<String> side;
  final Value<String> phase;
  final Value<String> volts;
  final Value<String> amps;
  final Value<String> kwOverride;
  final Value<String> pf;
  const PhaseLoadsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.side = const Value.absent(),
    this.phase = const Value.absent(),
    this.volts = const Value.absent(),
    this.amps = const Value.absent(),
    this.kwOverride = const Value.absent(),
    this.pf = const Value.absent(),
  });
  PhaseLoadsCompanion.insert({
    this.id = const Value.absent(),
    required int reportId,
    required String side,
    required String phase,
    this.volts = const Value.absent(),
    this.amps = const Value.absent(),
    this.kwOverride = const Value.absent(),
    this.pf = const Value.absent(),
  }) : reportId = Value(reportId),
       side = Value(side),
       phase = Value(phase);
  static Insertable<PhaseLoad> custom({
    Expression<int>? id,
    Expression<int>? reportId,
    Expression<String>? side,
    Expression<String>? phase,
    Expression<String>? volts,
    Expression<String>? amps,
    Expression<String>? kwOverride,
    Expression<String>? pf,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (side != null) 'side': side,
      if (phase != null) 'phase': phase,
      if (volts != null) 'volts': volts,
      if (amps != null) 'amps': amps,
      if (kwOverride != null) 'kw_override': kwOverride,
      if (pf != null) 'pf': pf,
    });
  }

  PhaseLoadsCompanion copyWith({
    Value<int>? id,
    Value<int>? reportId,
    Value<String>? side,
    Value<String>? phase,
    Value<String>? volts,
    Value<String>? amps,
    Value<String>? kwOverride,
    Value<String>? pf,
  }) {
    return PhaseLoadsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      side: side ?? this.side,
      phase: phase ?? this.phase,
      volts: volts ?? this.volts,
      amps: amps ?? this.amps,
      kwOverride: kwOverride ?? this.kwOverride,
      pf: pf ?? this.pf,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<int>(reportId.value);
    }
    if (side.present) {
      map['side'] = Variable<String>(side.value);
    }
    if (phase.present) {
      map['phase'] = Variable<String>(phase.value);
    }
    if (volts.present) {
      map['volts'] = Variable<String>(volts.value);
    }
    if (amps.present) {
      map['amps'] = Variable<String>(amps.value);
    }
    if (kwOverride.present) {
      map['kw_override'] = Variable<String>(kwOverride.value);
    }
    if (pf.present) {
      map['pf'] = Variable<String>(pf.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PhaseLoadsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('side: $side, ')
          ..write('phase: $phase, ')
          ..write('volts: $volts, ')
          ..write('amps: $amps, ')
          ..write('kwOverride: $kwOverride, ')
          ..write('pf: $pf')
          ..write(')'))
        .toString();
  }
}

class $SealsTable extends Seals with TableInfo<$SealsTable, Seal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SealsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _reportIdMeta = const VerificationMeta(
    'reportId',
  );
  @override
  late final GeneratedColumn<int> reportId = GeneratedColumn<int>(
    'report_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES reports (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _spotMeta = const VerificationMeta('spot');
  @override
  late final GeneratedColumn<String> spot = GeneratedColumn<String>(
    'spot',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _columnRoleMeta = const VerificationMeta(
    'columnRole',
  );
  @override
  late final GeneratedColumn<String> columnRole = GeneratedColumn<String>(
    'column_role',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mtSealMeta = const VerificationMeta('mtSeal');
  @override
  late final GeneratedColumn<String> mtSeal = GeneratedColumn<String>(
    'mt_seal',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _postalOrderMeta = const VerificationMeta(
    'postalOrder',
  );
  @override
  late final GeneratedColumn<String> postalOrder = GeneratedColumn<String>(
    'postal_order',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    reportId,
    spot,
    columnRole,
    mtSeal,
    postalOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'seals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Seal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('report_id')) {
      context.handle(
        _reportIdMeta,
        reportId.isAcceptableOrUnknown(data['report_id']!, _reportIdMeta),
      );
    } else if (isInserting) {
      context.missing(_reportIdMeta);
    }
    if (data.containsKey('spot')) {
      context.handle(
        _spotMeta,
        spot.isAcceptableOrUnknown(data['spot']!, _spotMeta),
      );
    } else if (isInserting) {
      context.missing(_spotMeta);
    }
    if (data.containsKey('column_role')) {
      context.handle(
        _columnRoleMeta,
        columnRole.isAcceptableOrUnknown(data['column_role']!, _columnRoleMeta),
      );
    } else if (isInserting) {
      context.missing(_columnRoleMeta);
    }
    if (data.containsKey('mt_seal')) {
      context.handle(
        _mtSealMeta,
        mtSeal.isAcceptableOrUnknown(data['mt_seal']!, _mtSealMeta),
      );
    }
    if (data.containsKey('postal_order')) {
      context.handle(
        _postalOrderMeta,
        postalOrder.isAcceptableOrUnknown(
          data['postal_order']!,
          _postalOrderMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Seal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Seal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      reportId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}report_id'],
      )!,
      spot: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}spot'],
      )!,
      columnRole: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}column_role'],
      )!,
      mtSeal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mt_seal'],
      )!,
      postalOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}postal_order'],
      )!,
    );
  }

  @override
  $SealsTable createAlias(String alias) {
    return $SealsTable(attachedDatabase, alias);
  }
}

class Seal extends DataClass implements Insertable<Seal> {
  final int id;
  final int reportId;

  /// TOU_MC, TOU_TC, MSB, MSB_2, MSB_GLASS, TFORMER
  final String spot;
  final String columnRole;
  final String mtSeal;
  final String postalOrder;
  const Seal({
    required this.id,
    required this.reportId,
    required this.spot,
    required this.columnRole,
    required this.mtSeal,
    required this.postalOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['report_id'] = Variable<int>(reportId);
    map['spot'] = Variable<String>(spot);
    map['column_role'] = Variable<String>(columnRole);
    map['mt_seal'] = Variable<String>(mtSeal);
    map['postal_order'] = Variable<String>(postalOrder);
    return map;
  }

  SealsCompanion toCompanion(bool nullToAbsent) {
    return SealsCompanion(
      id: Value(id),
      reportId: Value(reportId),
      spot: Value(spot),
      columnRole: Value(columnRole),
      mtSeal: Value(mtSeal),
      postalOrder: Value(postalOrder),
    );
  }

  factory Seal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Seal(
      id: serializer.fromJson<int>(json['id']),
      reportId: serializer.fromJson<int>(json['reportId']),
      spot: serializer.fromJson<String>(json['spot']),
      columnRole: serializer.fromJson<String>(json['columnRole']),
      mtSeal: serializer.fromJson<String>(json['mtSeal']),
      postalOrder: serializer.fromJson<String>(json['postalOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reportId': serializer.toJson<int>(reportId),
      'spot': serializer.toJson<String>(spot),
      'columnRole': serializer.toJson<String>(columnRole),
      'mtSeal': serializer.toJson<String>(mtSeal),
      'postalOrder': serializer.toJson<String>(postalOrder),
    };
  }

  Seal copyWith({
    int? id,
    int? reportId,
    String? spot,
    String? columnRole,
    String? mtSeal,
    String? postalOrder,
  }) => Seal(
    id: id ?? this.id,
    reportId: reportId ?? this.reportId,
    spot: spot ?? this.spot,
    columnRole: columnRole ?? this.columnRole,
    mtSeal: mtSeal ?? this.mtSeal,
    postalOrder: postalOrder ?? this.postalOrder,
  );
  Seal copyWithCompanion(SealsCompanion data) {
    return Seal(
      id: data.id.present ? data.id.value : this.id,
      reportId: data.reportId.present ? data.reportId.value : this.reportId,
      spot: data.spot.present ? data.spot.value : this.spot,
      columnRole: data.columnRole.present
          ? data.columnRole.value
          : this.columnRole,
      mtSeal: data.mtSeal.present ? data.mtSeal.value : this.mtSeal,
      postalOrder: data.postalOrder.present
          ? data.postalOrder.value
          : this.postalOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Seal(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('spot: $spot, ')
          ..write('columnRole: $columnRole, ')
          ..write('mtSeal: $mtSeal, ')
          ..write('postalOrder: $postalOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, reportId, spot, columnRole, mtSeal, postalOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Seal &&
          other.id == this.id &&
          other.reportId == this.reportId &&
          other.spot == this.spot &&
          other.columnRole == this.columnRole &&
          other.mtSeal == this.mtSeal &&
          other.postalOrder == this.postalOrder);
}

class SealsCompanion extends UpdateCompanion<Seal> {
  final Value<int> id;
  final Value<int> reportId;
  final Value<String> spot;
  final Value<String> columnRole;
  final Value<String> mtSeal;
  final Value<String> postalOrder;
  const SealsCompanion({
    this.id = const Value.absent(),
    this.reportId = const Value.absent(),
    this.spot = const Value.absent(),
    this.columnRole = const Value.absent(),
    this.mtSeal = const Value.absent(),
    this.postalOrder = const Value.absent(),
  });
  SealsCompanion.insert({
    this.id = const Value.absent(),
    required int reportId,
    required String spot,
    required String columnRole,
    this.mtSeal = const Value.absent(),
    this.postalOrder = const Value.absent(),
  }) : reportId = Value(reportId),
       spot = Value(spot),
       columnRole = Value(columnRole);
  static Insertable<Seal> custom({
    Expression<int>? id,
    Expression<int>? reportId,
    Expression<String>? spot,
    Expression<String>? columnRole,
    Expression<String>? mtSeal,
    Expression<String>? postalOrder,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reportId != null) 'report_id': reportId,
      if (spot != null) 'spot': spot,
      if (columnRole != null) 'column_role': columnRole,
      if (mtSeal != null) 'mt_seal': mtSeal,
      if (postalOrder != null) 'postal_order': postalOrder,
    });
  }

  SealsCompanion copyWith({
    Value<int>? id,
    Value<int>? reportId,
    Value<String>? spot,
    Value<String>? columnRole,
    Value<String>? mtSeal,
    Value<String>? postalOrder,
  }) {
    return SealsCompanion(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      spot: spot ?? this.spot,
      columnRole: columnRole ?? this.columnRole,
      mtSeal: mtSeal ?? this.mtSeal,
      postalOrder: postalOrder ?? this.postalOrder,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reportId.present) {
      map['report_id'] = Variable<int>(reportId.value);
    }
    if (spot.present) {
      map['spot'] = Variable<String>(spot.value);
    }
    if (columnRole.present) {
      map['column_role'] = Variable<String>(columnRole.value);
    }
    if (mtSeal.present) {
      map['mt_seal'] = Variable<String>(mtSeal.value);
    }
    if (postalOrder.present) {
      map['postal_order'] = Variable<String>(postalOrder.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SealsCompanion(')
          ..write('id: $id, ')
          ..write('reportId: $reportId, ')
          ..write('spot: $spot, ')
          ..write('columnRole: $columnRole, ')
          ..write('mtSeal: $mtSeal, ')
          ..write('postalOrder: $postalOrder')
          ..write(')'))
        .toString();
  }
}

class $SettingsTable extends Settings with TableInfo<$SettingsTable, Setting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<Setting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  Setting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Setting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $SettingsTable createAlias(String alias) {
    return $SettingsTable(attachedDatabase, alias);
  }
}

class Setting extends DataClass implements Insertable<Setting> {
  final String key;
  final String value;
  const Setting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  SettingsCompanion toCompanion(bool nullToAbsent) {
    return SettingsCompanion(key: Value(key), value: Value(value));
  }

  factory Setting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Setting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  Setting copyWith({String? key, String? value}) =>
      Setting(key: key ?? this.key, value: value ?? this.value);
  Setting copyWithCompanion(SettingsCompanion data) {
    return Setting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Setting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Setting && other.key == this.key && other.value == this.value);
}

class SettingsCompanion extends UpdateCompanion<Setting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const SettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SettingsCompanion.insert({
    required String key,
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : key = Value(key);
  static Insertable<Setting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return SettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ConsumersTable consumers = $ConsumersTable(this);
  late final $MetersTable meters = $MetersTable(this);
  late final $ReportsTable reports = $ReportsTable(this);
  late final $ReportMetersTable reportMeters = $ReportMetersTable(this);
  late final $ReadingsTable readings = $ReadingsTable(this);
  late final $PhaseLoadsTable phaseLoads = $PhaseLoadsTable(this);
  late final $SealsTable seals = $SealsTable(this);
  late final $SettingsTable settings = $SettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    consumers,
    meters,
    reports,
    reportMeters,
    readings,
    phaseLoads,
    seals,
    settings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'consumers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('meters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'consumers',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reports', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('report_meters', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'meters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('report_meters', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'report_meters',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('readings', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('phase_loads', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'reports',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('seals', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ConsumersTableCreateCompanionBuilder = ConsumersCompanion Function({
  Value<int> id,
  required String accountNo,
  Value<String> tariff,
  Value<String> name,
  Value<String> address,
  Value<String> subDivision,
  Value<String> opDivision,
  Value<String> sanctionedLoadKw,
  Value<String> connectedLoad,
  Value<String> industryKind,
  Value<String> transformerKva,
  Value<String> transformerMake,
  Value<String> transformerNo,
  Value<String> ctPrimary,
  Value<String> ctSecondary,
  Value<String> ctVaBurden,
  Value<String> mf,
  Value<String> cableSize,
  Value<String> msbType,
  Value<String> feederName,
  Value<String> applicationNo,
  Value<DateTime?> applicationDate,
  Value<String> sanctionRef,
  Value<DateTime?> sanctionDate,
  Value<String> scoMcoRcoNo,
  Value<DateTime?> scoDate,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ConsumersTableUpdateCompanionBuilder = ConsumersCompanion Function({
  Value<int> id,
  Value<String> accountNo,
  Value<String> tariff,
  Value<String> name,
  Value<String> address,
  Value<String> subDivision,
  Value<String> opDivision,
  Value<String> sanctionedLoadKw,
  Value<String> connectedLoad,
  Value<String> industryKind,
  Value<String> transformerKva,
  Value<String> transformerMake,
  Value<String> transformerNo,
  Value<String> ctPrimary,
  Value<String> ctSecondary,
  Value<String> ctVaBurden,
  Value<String> mf,
  Value<String> cableSize,
  Value<String> msbType,
  Value<String> feederName,
  Value<String> applicationNo,
  Value<DateTime?> applicationDate,
  Value<String> sanctionRef,
  Value<DateTime?> sanctionDate,
  Value<String> scoMcoRcoNo,
  Value<DateTime?> scoDate,
  Value<String> notes,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ConsumersTableReferences
    extends BaseReferences<_$AppDatabase, $ConsumersTable, ConsumerRow> {
  $$ConsumersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MetersTable, List<Meter>> _metersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.meters,
    aliasName: 'consumers__id__meters__consumer_id',
  );

  $$MetersTableProcessedTableManager get metersRefs {
    final manager = $$MetersTableTableManager(
      $_db,
      $_db.meters,
    ).filter((f) => f.consumerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_metersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReportsTable, List<Report>> _reportsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.reports,
    aliasName: 'consumers__id__reports__consumer_id',
  );

  $$ReportsTableProcessedTableManager get reportsRefs {
    final manager = $$ReportsTableTableManager(
      $_db,
      $_db.reports,
    ).filter((f) => f.consumerId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reportsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ConsumersTableFilterComposer
    extends Composer<_$AppDatabase, $ConsumersTable> {
  $$ConsumersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accountNo => $composableBuilder(
    column: $table.accountNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tariff => $composableBuilder(
    column: $table.tariff,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subDivision => $composableBuilder(
    column: $table.subDivision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get opDivision => $composableBuilder(
    column: $table.opDivision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sanctionedLoadKw => $composableBuilder(
    column: $table.sanctionedLoadKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get connectedLoad => $composableBuilder(
    column: $table.connectedLoad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get industryKind => $composableBuilder(
    column: $table.industryKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transformerKva => $composableBuilder(
    column: $table.transformerKva,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transformerMake => $composableBuilder(
    column: $table.transformerMake,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transformerNo => $composableBuilder(
    column: $table.transformerNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ctPrimary => $composableBuilder(
    column: $table.ctPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ctSecondary => $composableBuilder(
    column: $table.ctSecondary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ctVaBurden => $composableBuilder(
    column: $table.ctVaBurden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mf => $composableBuilder(
    column: $table.mf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cableSize => $composableBuilder(
    column: $table.cableSize,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get msbType => $composableBuilder(
    column: $table.msbType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get feederName => $composableBuilder(
    column: $table.feederName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get applicationNo => $composableBuilder(
    column: $table.applicationNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get applicationDate => $composableBuilder(
    column: $table.applicationDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sanctionRef => $composableBuilder(
    column: $table.sanctionRef,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get sanctionDate => $composableBuilder(
    column: $table.sanctionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scoMcoRcoNo => $composableBuilder(
    column: $table.scoMcoRcoNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scoDate => $composableBuilder(
    column: $table.scoDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> metersRefs(
    Expression<bool> Function($$MetersTableFilterComposer f) f,
  ) {
    final $$MetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meters,
      getReferencedColumn: (t) => t.consumerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetersTableFilterComposer(
            $db: $db,
            $table: $db.meters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> reportsRefs(
    Expression<bool> Function($$ReportsTableFilterComposer f) f,
  ) {
    final $$ReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.consumerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableFilterComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConsumersTableOrderingComposer
    extends Composer<_$AppDatabase, $ConsumersTable> {
  $$ConsumersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accountNo => $composableBuilder(
    column: $table.accountNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tariff => $composableBuilder(
    column: $table.tariff,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get address => $composableBuilder(
    column: $table.address,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subDivision => $composableBuilder(
    column: $table.subDivision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get opDivision => $composableBuilder(
    column: $table.opDivision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sanctionedLoadKw => $composableBuilder(
    column: $table.sanctionedLoadKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get connectedLoad => $composableBuilder(
    column: $table.connectedLoad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get industryKind => $composableBuilder(
    column: $table.industryKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transformerKva => $composableBuilder(
    column: $table.transformerKva,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transformerMake => $composableBuilder(
    column: $table.transformerMake,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transformerNo => $composableBuilder(
    column: $table.transformerNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ctPrimary => $composableBuilder(
    column: $table.ctPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ctSecondary => $composableBuilder(
    column: $table.ctSecondary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ctVaBurden => $composableBuilder(
    column: $table.ctVaBurden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mf => $composableBuilder(
    column: $table.mf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cableSize => $composableBuilder(
    column: $table.cableSize,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get msbType => $composableBuilder(
    column: $table.msbType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get feederName => $composableBuilder(
    column: $table.feederName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get applicationNo => $composableBuilder(
    column: $table.applicationNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get applicationDate => $composableBuilder(
    column: $table.applicationDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sanctionRef => $composableBuilder(
    column: $table.sanctionRef,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get sanctionDate => $composableBuilder(
    column: $table.sanctionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scoMcoRcoNo => $composableBuilder(
    column: $table.scoMcoRcoNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scoDate => $composableBuilder(
    column: $table.scoDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ConsumersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ConsumersTable> {
  $$ConsumersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accountNo =>
      $composableBuilder(column: $table.accountNo, builder: (column) => column);

  GeneratedColumn<String> get tariff =>
      $composableBuilder(column: $table.tariff, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get address =>
      $composableBuilder(column: $table.address, builder: (column) => column);

  GeneratedColumn<String> get subDivision => $composableBuilder(
    column: $table.subDivision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get opDivision => $composableBuilder(
    column: $table.opDivision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sanctionedLoadKw => $composableBuilder(
    column: $table.sanctionedLoadKw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get connectedLoad => $composableBuilder(
    column: $table.connectedLoad,
    builder: (column) => column,
  );

  GeneratedColumn<String> get industryKind => $composableBuilder(
    column: $table.industryKind,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transformerKva => $composableBuilder(
    column: $table.transformerKva,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transformerMake => $composableBuilder(
    column: $table.transformerMake,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transformerNo => $composableBuilder(
    column: $table.transformerNo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ctPrimary =>
      $composableBuilder(column: $table.ctPrimary, builder: (column) => column);

  GeneratedColumn<String> get ctSecondary => $composableBuilder(
    column: $table.ctSecondary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ctVaBurden => $composableBuilder(
    column: $table.ctVaBurden,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mf =>
      $composableBuilder(column: $table.mf, builder: (column) => column);

  GeneratedColumn<String> get cableSize =>
      $composableBuilder(column: $table.cableSize, builder: (column) => column);

  GeneratedColumn<String> get msbType =>
      $composableBuilder(column: $table.msbType, builder: (column) => column);

  GeneratedColumn<String> get feederName => $composableBuilder(
    column: $table.feederName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get applicationNo => $composableBuilder(
    column: $table.applicationNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get applicationDate => $composableBuilder(
    column: $table.applicationDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sanctionRef => $composableBuilder(
    column: $table.sanctionRef,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get sanctionDate => $composableBuilder(
    column: $table.sanctionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get scoMcoRcoNo => $composableBuilder(
    column: $table.scoMcoRcoNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get scoDate =>
      $composableBuilder(column: $table.scoDate, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> metersRefs<T extends Object>(
    Expression<T> Function($$MetersTableAnnotationComposer a) f,
  ) {
    final $$MetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.meters,
      getReferencedColumn: (t) => t.consumerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetersTableAnnotationComposer(
            $db: $db,
            $table: $db.meters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> reportsRefs<T extends Object>(
    Expression<T> Function($$ReportsTableAnnotationComposer a) f,
  ) {
    final $$ReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.consumerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ConsumersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ConsumersTable,
          ConsumerRow,
          $$ConsumersTableFilterComposer,
          $$ConsumersTableOrderingComposer,
          $$ConsumersTableAnnotationComposer,
          $$ConsumersTableCreateCompanionBuilder,
          $$ConsumersTableUpdateCompanionBuilder,
          (ConsumerRow, $$ConsumersTableReferences),
          ConsumerRow,
          PrefetchHooks Function({bool metersRefs, bool reportsRefs})
        > {
  $$ConsumersTableTableManager(_$AppDatabase db, $ConsumersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ConsumersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ConsumersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ConsumersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> accountNo = const Value.absent(),
                Value<String> tariff = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> subDivision = const Value.absent(),
                Value<String> opDivision = const Value.absent(),
                Value<String> sanctionedLoadKw = const Value.absent(),
                Value<String> connectedLoad = const Value.absent(),
                Value<String> industryKind = const Value.absent(),
                Value<String> transformerKva = const Value.absent(),
                Value<String> transformerMake = const Value.absent(),
                Value<String> transformerNo = const Value.absent(),
                Value<String> ctPrimary = const Value.absent(),
                Value<String> ctSecondary = const Value.absent(),
                Value<String> ctVaBurden = const Value.absent(),
                Value<String> mf = const Value.absent(),
                Value<String> cableSize = const Value.absent(),
                Value<String> msbType = const Value.absent(),
                Value<String> feederName = const Value.absent(),
                Value<String> applicationNo = const Value.absent(),
                Value<DateTime?> applicationDate = const Value.absent(),
                Value<String> sanctionRef = const Value.absent(),
                Value<DateTime?> sanctionDate = const Value.absent(),
                Value<String> scoMcoRcoNo = const Value.absent(),
                Value<DateTime?> scoDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ConsumersCompanion(
                id: id,
                accountNo: accountNo,
                tariff: tariff,
                name: name,
                address: address,
                subDivision: subDivision,
                opDivision: opDivision,
                sanctionedLoadKw: sanctionedLoadKw,
                connectedLoad: connectedLoad,
                industryKind: industryKind,
                transformerKva: transformerKva,
                transformerMake: transformerMake,
                transformerNo: transformerNo,
                ctPrimary: ctPrimary,
                ctSecondary: ctSecondary,
                ctVaBurden: ctVaBurden,
                mf: mf,
                cableSize: cableSize,
                msbType: msbType,
                feederName: feederName,
                applicationNo: applicationNo,
                applicationDate: applicationDate,
                sanctionRef: sanctionRef,
                sanctionDate: sanctionDate,
                scoMcoRcoNo: scoMcoRcoNo,
                scoDate: scoDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String accountNo,
                Value<String> tariff = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> address = const Value.absent(),
                Value<String> subDivision = const Value.absent(),
                Value<String> opDivision = const Value.absent(),
                Value<String> sanctionedLoadKw = const Value.absent(),
                Value<String> connectedLoad = const Value.absent(),
                Value<String> industryKind = const Value.absent(),
                Value<String> transformerKva = const Value.absent(),
                Value<String> transformerMake = const Value.absent(),
                Value<String> transformerNo = const Value.absent(),
                Value<String> ctPrimary = const Value.absent(),
                Value<String> ctSecondary = const Value.absent(),
                Value<String> ctVaBurden = const Value.absent(),
                Value<String> mf = const Value.absent(),
                Value<String> cableSize = const Value.absent(),
                Value<String> msbType = const Value.absent(),
                Value<String> feederName = const Value.absent(),
                Value<String> applicationNo = const Value.absent(),
                Value<DateTime?> applicationDate = const Value.absent(),
                Value<String> sanctionRef = const Value.absent(),
                Value<DateTime?> sanctionDate = const Value.absent(),
                Value<String> scoMcoRcoNo = const Value.absent(),
                Value<DateTime?> scoDate = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ConsumersCompanion.insert(
                id: id,
                accountNo: accountNo,
                tariff: tariff,
                name: name,
                address: address,
                subDivision: subDivision,
                opDivision: opDivision,
                sanctionedLoadKw: sanctionedLoadKw,
                connectedLoad: connectedLoad,
                industryKind: industryKind,
                transformerKva: transformerKva,
                transformerMake: transformerMake,
                transformerNo: transformerNo,
                ctPrimary: ctPrimary,
                ctSecondary: ctSecondary,
                ctVaBurden: ctVaBurden,
                mf: mf,
                cableSize: cableSize,
                msbType: msbType,
                feederName: feederName,
                applicationNo: applicationNo,
                applicationDate: applicationDate,
                sanctionRef: sanctionRef,
                sanctionDate: sanctionDate,
                scoMcoRcoNo: scoMcoRcoNo,
                scoDate: scoDate,
                notes: notes,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ConsumersTable, ConsumerRow>(table),
                  $$ConsumersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({metersRefs = false, reportsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (metersRefs) db.meters,
                if (reportsRefs) db.reports,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (metersRefs)
                    await $_getPrefetchedDataByColumns<
                      ConsumerRow,
                      $ConsumersTable,
                      Meter,
                      $MetersTable
                    >(
                      currentTable: table,
                      referencedTable: $$ConsumersTableReferences
                          ._metersRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ConsumersTableReferences(db, table, p0).metersRefs,
                      currentColumn: 'id',
                      referencedColumn: 'consumer_id',
                      typedResults: items,
                    ),
                  if (reportsRefs)
                    await $_getPrefetchedDataByColumns<
                      ConsumerRow,
                      $ConsumersTable,
                      Report,
                      $ReportsTable
                    >(
                      currentTable: table,
                      referencedTable: $$ConsumersTableReferences
                          ._reportsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ConsumersTableReferences(db, table, p0).reportsRefs,
                      currentColumn: 'id',
                      referencedColumn: 'consumer_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ConsumersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ConsumersTable,
      ConsumerRow,
      $$ConsumersTableFilterComposer,
      $$ConsumersTableOrderingComposer,
      $$ConsumersTableAnnotationComposer,
      $$ConsumersTableCreateCompanionBuilder,
      $$ConsumersTableUpdateCompanionBuilder,
      (ConsumerRow, $$ConsumersTableReferences),
      ConsumerRow,
      PrefetchHooks Function({bool metersRefs, bool reportsRefs})
    >;
typedef $$MetersTableCreateCompanionBuilder = MetersCompanion Function({
  Value<int> id,
  required int consumerId,
  required String mfgNo,
  Value<String> make,
  Value<String> meterKind,
  Value<String> amps,
  Value<String> volts,
  Value<String> meterConstant,
  Value<String> mf,
  Value<String> simNo,
  Value<String> commId,
  Value<String> status,
  Value<DateTime?> installedOn,
  Value<DateTime?> removedOn,
  Value<DateTime> createdAt,
});
typedef $$MetersTableUpdateCompanionBuilder = MetersCompanion Function({
  Value<int> id,
  Value<int> consumerId,
  Value<String> mfgNo,
  Value<String> make,
  Value<String> meterKind,
  Value<String> amps,
  Value<String> volts,
  Value<String> meterConstant,
  Value<String> mf,
  Value<String> simNo,
  Value<String> commId,
  Value<String> status,
  Value<DateTime?> installedOn,
  Value<DateTime?> removedOn,
  Value<DateTime> createdAt,
});

final class $$MetersTableReferences
    extends BaseReferences<_$AppDatabase, $MetersTable, Meter> {
  $$MetersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConsumersTable _consumerIdTable(_$AppDatabase db) =>
      db.consumers.createAlias('meters__consumer_id__consumers__id');

  $$ConsumersTableProcessedTableManager get consumerId {
    final $_column = $_itemColumn<int>('consumer_id')!;

    final manager = $$ConsumersTableTableManager(
      $_db,
      $_db.consumers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_consumerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReportMetersTable, List<ReportMeter>>
  _reportMetersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reportMeters,
    aliasName: 'meters__id__report_meters__meter_id',
  );

  $$ReportMetersTableProcessedTableManager get reportMetersRefs {
    final manager = $$ReportMetersTableTableManager(
      $_db,
      $_db.reportMeters,
    ).filter((f) => f.meterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reportMetersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MetersTableFilterComposer
    extends Composer<_$AppDatabase, $MetersTable> {
  $$MetersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mfgNo => $composableBuilder(
    column: $table.mfgNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meterKind => $composableBuilder(
    column: $table.meterKind,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amps => $composableBuilder(
    column: $table.amps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get volts => $composableBuilder(
    column: $table.volts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get meterConstant => $composableBuilder(
    column: $table.meterConstant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mf => $composableBuilder(
    column: $table.mf,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get simNo => $composableBuilder(
    column: $table.simNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commId => $composableBuilder(
    column: $table.commId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get installedOn => $composableBuilder(
    column: $table.installedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get removedOn => $composableBuilder(
    column: $table.removedOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ConsumersTableFilterComposer get consumerId {
    final $$ConsumersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.consumerId,
      referencedTable: $db.consumers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumersTableFilterComposer(
            $db: $db,
            $table: $db.consumers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reportMetersRefs(
    Expression<bool> Function($$ReportMetersTableFilterComposer f) f,
  ) {
    final $$ReportMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.meterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableFilterComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MetersTableOrderingComposer
    extends Composer<_$AppDatabase, $MetersTable> {
  $$MetersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mfgNo => $composableBuilder(
    column: $table.mfgNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meterKind => $composableBuilder(
    column: $table.meterKind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amps => $composableBuilder(
    column: $table.amps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get volts => $composableBuilder(
    column: $table.volts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get meterConstant => $composableBuilder(
    column: $table.meterConstant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mf => $composableBuilder(
    column: $table.mf,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get simNo => $composableBuilder(
    column: $table.simNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commId => $composableBuilder(
    column: $table.commId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get installedOn => $composableBuilder(
    column: $table.installedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get removedOn => $composableBuilder(
    column: $table.removedOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConsumersTableOrderingComposer get consumerId {
    final $$ConsumersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.consumerId,
      referencedTable: $db.consumers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumersTableOrderingComposer(
            $db: $db,
            $table: $db.consumers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MetersTableAnnotationComposer
    extends Composer<_$AppDatabase, $MetersTable> {
  $$MetersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get mfgNo =>
      $composableBuilder(column: $table.mfgNo, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get meterKind =>
      $composableBuilder(column: $table.meterKind, builder: (column) => column);

  GeneratedColumn<String> get amps =>
      $composableBuilder(column: $table.amps, builder: (column) => column);

  GeneratedColumn<String> get volts =>
      $composableBuilder(column: $table.volts, builder: (column) => column);

  GeneratedColumn<String> get meterConstant => $composableBuilder(
    column: $table.meterConstant,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mf =>
      $composableBuilder(column: $table.mf, builder: (column) => column);

  GeneratedColumn<String> get simNo =>
      $composableBuilder(column: $table.simNo, builder: (column) => column);

  GeneratedColumn<String> get commId =>
      $composableBuilder(column: $table.commId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get installedOn => $composableBuilder(
    column: $table.installedOn,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get removedOn =>
      $composableBuilder(column: $table.removedOn, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$ConsumersTableAnnotationComposer get consumerId {
    final $$ConsumersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.consumerId,
      referencedTable: $db.consumers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumersTableAnnotationComposer(
            $db: $db,
            $table: $db.consumers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reportMetersRefs<T extends Object>(
    Expression<T> Function($$ReportMetersTableAnnotationComposer a) f,
  ) {
    final $$ReportMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.meterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MetersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MetersTable,
          Meter,
          $$MetersTableFilterComposer,
          $$MetersTableOrderingComposer,
          $$MetersTableAnnotationComposer,
          $$MetersTableCreateCompanionBuilder,
          $$MetersTableUpdateCompanionBuilder,
          (Meter, $$MetersTableReferences),
          Meter,
          PrefetchHooks Function({bool consumerId, bool reportMetersRefs})
        > {
  $$MetersTableTableManager(_$AppDatabase db, $MetersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MetersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MetersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MetersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> consumerId = const Value.absent(),
                Value<String> mfgNo = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> meterKind = const Value.absent(),
                Value<String> amps = const Value.absent(),
                Value<String> volts = const Value.absent(),
                Value<String> meterConstant = const Value.absent(),
                Value<String> mf = const Value.absent(),
                Value<String> simNo = const Value.absent(),
                Value<String> commId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> installedOn = const Value.absent(),
                Value<DateTime?> removedOn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MetersCompanion(
                id: id,
                consumerId: consumerId,
                mfgNo: mfgNo,
                make: make,
                meterKind: meterKind,
                amps: amps,
                volts: volts,
                meterConstant: meterConstant,
                mf: mf,
                simNo: simNo,
                commId: commId,
                status: status,
                installedOn: installedOn,
                removedOn: removedOn,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int consumerId,
                required String mfgNo,
                Value<String> make = const Value.absent(),
                Value<String> meterKind = const Value.absent(),
                Value<String> amps = const Value.absent(),
                Value<String> volts = const Value.absent(),
                Value<String> meterConstant = const Value.absent(),
                Value<String> mf = const Value.absent(),
                Value<String> simNo = const Value.absent(),
                Value<String> commId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime?> installedOn = const Value.absent(),
                Value<DateTime?> removedOn = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MetersCompanion.insert(
                id: id,
                consumerId: consumerId,
                mfgNo: mfgNo,
                make: make,
                meterKind: meterKind,
                amps: amps,
                volts: volts,
                meterConstant: meterConstant,
                mf: mf,
                simNo: simNo,
                commId: commId,
                status: status,
                installedOn: installedOn,
                removedOn: removedOn,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MetersTable, Meter>(table),
                  $$MetersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({consumerId = false, reportMetersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reportMetersRefs) db.reportMeters,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (consumerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.consumerId,
                            referencedTable: $$MetersTableReferences
                                ._consumerIdTable(db),
                            referencedColumn: $$MetersTableReferences
                                ._consumerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reportMetersRefs)
                        await $_getPrefetchedDataByColumns<
                          Meter,
                          $MetersTable,
                          ReportMeter,
                          $ReportMetersTable
                        >(
                          currentTable: table,
                          referencedTable: $$MetersTableReferences
                              ._reportMetersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MetersTableReferences(
                                db,
                                table,
                                p0,
                              ).reportMetersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'meter_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MetersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MetersTable,
      Meter,
      $$MetersTableFilterComposer,
      $$MetersTableOrderingComposer,
      $$MetersTableAnnotationComposer,
      $$MetersTableCreateCompanionBuilder,
      $$MetersTableUpdateCompanionBuilder,
      (Meter, $$MetersTableReferences),
      Meter,
      PrefetchHooks Function({bool consumerId, bool reportMetersRefs})
    >;
typedef $$ReportsTableCreateCompanionBuilder = ReportsCompanion Function({
  Value<int> id,
  required int consumerId,
  required String reportType,
  Value<String> status,
  Value<String> memoNo,
  Value<DateTime?> memoDate,
  Value<String> toSubDivision,
  Value<String> refType,
  Value<String> refNo,
  Value<DateTime?> refDate,
  Value<DateTime?> visitDate,
  Value<String> teamText,
  Value<String> sectionAJson,
  Value<String> msbStatus,
  Value<String> postalOrdersText,
  Value<String> checkedLoadKw,
  Value<String> loadType,
  Value<String> exportLoadText,
  Value<String> accuracyText,
  Value<String> transformerLtBushes,
  Value<String> remarks,
  Value<String> storeChallanNo,
  Value<DateTime?> storeChallanDate,
  Value<String> newMeterCount,
  Value<String> ctCount,
  Value<String> signerExenOp,
  Value<String> signerSdoOp,
  Value<String> signer3,
  Value<String> signer4,
  Value<String> checkLoadOverride,
  Value<String> percentErrorOverride,
  Value<String> withinLimitOverride,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});
typedef $$ReportsTableUpdateCompanionBuilder = ReportsCompanion Function({
  Value<int> id,
  Value<int> consumerId,
  Value<String> reportType,
  Value<String> status,
  Value<String> memoNo,
  Value<DateTime?> memoDate,
  Value<String> toSubDivision,
  Value<String> refType,
  Value<String> refNo,
  Value<DateTime?> refDate,
  Value<DateTime?> visitDate,
  Value<String> teamText,
  Value<String> sectionAJson,
  Value<String> msbStatus,
  Value<String> postalOrdersText,
  Value<String> checkedLoadKw,
  Value<String> loadType,
  Value<String> exportLoadText,
  Value<String> accuracyText,
  Value<String> transformerLtBushes,
  Value<String> remarks,
  Value<String> storeChallanNo,
  Value<DateTime?> storeChallanDate,
  Value<String> newMeterCount,
  Value<String> ctCount,
  Value<String> signerExenOp,
  Value<String> signerSdoOp,
  Value<String> signer3,
  Value<String> signer4,
  Value<String> checkLoadOverride,
  Value<String> percentErrorOverride,
  Value<String> withinLimitOverride,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
});

final class $$ReportsTableReferences
    extends BaseReferences<_$AppDatabase, $ReportsTable, Report> {
  $$ReportsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ConsumersTable _consumerIdTable(_$AppDatabase db) =>
      db.consumers.createAlias('reports__consumer_id__consumers__id');

  $$ConsumersTableProcessedTableManager get consumerId {
    final $_column = $_itemColumn<int>('consumer_id')!;

    final manager = $$ConsumersTableTableManager(
      $_db,
      $_db.consumers,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_consumerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReportMetersTable, List<ReportMeter>>
  _reportMetersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reportMeters,
    aliasName: 'reports__id__report_meters__report_id',
  );

  $$ReportMetersTableProcessedTableManager get reportMetersRefs {
    final manager = $$ReportMetersTableTableManager(
      $_db,
      $_db.reportMeters,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_reportMetersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$ReadingsTable, List<Reading>> _readingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.readings,
    aliasName: 'reports__id__readings__report_id',
  );

  $$ReadingsTableProcessedTableManager get readingsRefs {
    final manager = $$ReadingsTableTableManager(
      $_db,
      $_db.readings,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_readingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PhaseLoadsTable, List<PhaseLoad>>
  _phaseLoadsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.phaseLoads,
    aliasName: 'reports__id__phase_loads__report_id',
  );

  $$PhaseLoadsTableProcessedTableManager get phaseLoadsRefs {
    final manager = $$PhaseLoadsTableTableManager(
      $_db,
      $_db.phaseLoads,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_phaseLoadsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$SealsTable, List<Seal>> _sealsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.seals,
    aliasName: 'reports__id__seals__report_id',
  );

  $$SealsTableProcessedTableManager get sealsRefs {
    final manager = $$SealsTableTableManager(
      $_db,
      $_db.seals,
    ).filter((f) => f.reportId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_sealsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReportsTableFilterComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reportType => $composableBuilder(
    column: $table.reportType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memoNo => $composableBuilder(
    column: $table.memoNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get memoDate => $composableBuilder(
    column: $table.memoDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get toSubDivision => $composableBuilder(
    column: $table.toSubDivision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refType => $composableBuilder(
    column: $table.refType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get refNo => $composableBuilder(
    column: $table.refNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get refDate => $composableBuilder(
    column: $table.refDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get visitDate => $composableBuilder(
    column: $table.visitDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get teamText => $composableBuilder(
    column: $table.teamText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sectionAJson => $composableBuilder(
    column: $table.sectionAJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get msbStatus => $composableBuilder(
    column: $table.msbStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalOrdersText => $composableBuilder(
    column: $table.postalOrdersText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkedLoadKw => $composableBuilder(
    column: $table.checkedLoadKw,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get loadType => $composableBuilder(
    column: $table.loadType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get exportLoadText => $composableBuilder(
    column: $table.exportLoadText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accuracyText => $composableBuilder(
    column: $table.accuracyText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get transformerLtBushes => $composableBuilder(
    column: $table.transformerLtBushes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get storeChallanNo => $composableBuilder(
    column: $table.storeChallanNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get storeChallanDate => $composableBuilder(
    column: $table.storeChallanDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newMeterCount => $composableBuilder(
    column: $table.newMeterCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ctCount => $composableBuilder(
    column: $table.ctCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signerExenOp => $composableBuilder(
    column: $table.signerExenOp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signerSdoOp => $composableBuilder(
    column: $table.signerSdoOp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signer3 => $composableBuilder(
    column: $table.signer3,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get signer4 => $composableBuilder(
    column: $table.signer4,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get checkLoadOverride => $composableBuilder(
    column: $table.checkLoadOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get percentErrorOverride => $composableBuilder(
    column: $table.percentErrorOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get withinLimitOverride => $composableBuilder(
    column: $table.withinLimitOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$ConsumersTableFilterComposer get consumerId {
    final $$ConsumersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.consumerId,
      referencedTable: $db.consumers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumersTableFilterComposer(
            $db: $db,
            $table: $db.consumers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> reportMetersRefs(
    Expression<bool> Function($$ReportMetersTableFilterComposer f) f,
  ) {
    final $$ReportMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableFilterComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> readingsRefs(
    Expression<bool> Function($$ReadingsTableFilterComposer f) f,
  ) {
    final $$ReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readings,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingsTableFilterComposer(
            $db: $db,
            $table: $db.readings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> phaseLoadsRefs(
    Expression<bool> Function($$PhaseLoadsTableFilterComposer f) f,
  ) {
    final $$PhaseLoadsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseLoads,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseLoadsTableFilterComposer(
            $db: $db,
            $table: $db.phaseLoads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> sealsRefs(
    Expression<bool> Function($$SealsTableFilterComposer f) f,
  ) {
    final $$SealsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seals,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SealsTableFilterComposer(
            $db: $db,
            $table: $db.seals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReportsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reportType => $composableBuilder(
    column: $table.reportType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memoNo => $composableBuilder(
    column: $table.memoNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get memoDate => $composableBuilder(
    column: $table.memoDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get toSubDivision => $composableBuilder(
    column: $table.toSubDivision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refType => $composableBuilder(
    column: $table.refType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get refNo => $composableBuilder(
    column: $table.refNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get refDate => $composableBuilder(
    column: $table.refDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get visitDate => $composableBuilder(
    column: $table.visitDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get teamText => $composableBuilder(
    column: $table.teamText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sectionAJson => $composableBuilder(
    column: $table.sectionAJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get msbStatus => $composableBuilder(
    column: $table.msbStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalOrdersText => $composableBuilder(
    column: $table.postalOrdersText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkedLoadKw => $composableBuilder(
    column: $table.checkedLoadKw,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get loadType => $composableBuilder(
    column: $table.loadType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get exportLoadText => $composableBuilder(
    column: $table.exportLoadText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accuracyText => $composableBuilder(
    column: $table.accuracyText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get transformerLtBushes => $composableBuilder(
    column: $table.transformerLtBushes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remarks => $composableBuilder(
    column: $table.remarks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storeChallanNo => $composableBuilder(
    column: $table.storeChallanNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get storeChallanDate => $composableBuilder(
    column: $table.storeChallanDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newMeterCount => $composableBuilder(
    column: $table.newMeterCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ctCount => $composableBuilder(
    column: $table.ctCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signerExenOp => $composableBuilder(
    column: $table.signerExenOp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signerSdoOp => $composableBuilder(
    column: $table.signerSdoOp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signer3 => $composableBuilder(
    column: $table.signer3,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get signer4 => $composableBuilder(
    column: $table.signer4,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get checkLoadOverride => $composableBuilder(
    column: $table.checkLoadOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get percentErrorOverride => $composableBuilder(
    column: $table.percentErrorOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get withinLimitOverride => $composableBuilder(
    column: $table.withinLimitOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$ConsumersTableOrderingComposer get consumerId {
    final $$ConsumersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.consumerId,
      referencedTable: $db.consumers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumersTableOrderingComposer(
            $db: $db,
            $table: $db.consumers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportsTable> {
  $$ReportsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get reportType => $composableBuilder(
    column: $table.reportType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get memoNo =>
      $composableBuilder(column: $table.memoNo, builder: (column) => column);

  GeneratedColumn<DateTime> get memoDate =>
      $composableBuilder(column: $table.memoDate, builder: (column) => column);

  GeneratedColumn<String> get toSubDivision => $composableBuilder(
    column: $table.toSubDivision,
    builder: (column) => column,
  );

  GeneratedColumn<String> get refType =>
      $composableBuilder(column: $table.refType, builder: (column) => column);

  GeneratedColumn<String> get refNo =>
      $composableBuilder(column: $table.refNo, builder: (column) => column);

  GeneratedColumn<DateTime> get refDate =>
      $composableBuilder(column: $table.refDate, builder: (column) => column);

  GeneratedColumn<DateTime> get visitDate =>
      $composableBuilder(column: $table.visitDate, builder: (column) => column);

  GeneratedColumn<String> get teamText =>
      $composableBuilder(column: $table.teamText, builder: (column) => column);

  GeneratedColumn<String> get sectionAJson => $composableBuilder(
    column: $table.sectionAJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get msbStatus =>
      $composableBuilder(column: $table.msbStatus, builder: (column) => column);

  GeneratedColumn<String> get postalOrdersText => $composableBuilder(
    column: $table.postalOrdersText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get checkedLoadKw => $composableBuilder(
    column: $table.checkedLoadKw,
    builder: (column) => column,
  );

  GeneratedColumn<String> get loadType =>
      $composableBuilder(column: $table.loadType, builder: (column) => column);

  GeneratedColumn<String> get exportLoadText => $composableBuilder(
    column: $table.exportLoadText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get accuracyText => $composableBuilder(
    column: $table.accuracyText,
    builder: (column) => column,
  );

  GeneratedColumn<String> get transformerLtBushes => $composableBuilder(
    column: $table.transformerLtBushes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get remarks =>
      $composableBuilder(column: $table.remarks, builder: (column) => column);

  GeneratedColumn<String> get storeChallanNo => $composableBuilder(
    column: $table.storeChallanNo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get storeChallanDate => $composableBuilder(
    column: $table.storeChallanDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get newMeterCount => $composableBuilder(
    column: $table.newMeterCount,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ctCount =>
      $composableBuilder(column: $table.ctCount, builder: (column) => column);

  GeneratedColumn<String> get signerExenOp => $composableBuilder(
    column: $table.signerExenOp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signerSdoOp => $composableBuilder(
    column: $table.signerSdoOp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get signer3 =>
      $composableBuilder(column: $table.signer3, builder: (column) => column);

  GeneratedColumn<String> get signer4 =>
      $composableBuilder(column: $table.signer4, builder: (column) => column);

  GeneratedColumn<String> get checkLoadOverride => $composableBuilder(
    column: $table.checkLoadOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get percentErrorOverride => $composableBuilder(
    column: $table.percentErrorOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get withinLimitOverride => $composableBuilder(
    column: $table.withinLimitOverride,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$ConsumersTableAnnotationComposer get consumerId {
    final $$ConsumersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.consumerId,
      referencedTable: $db.consumers,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ConsumersTableAnnotationComposer(
            $db: $db,
            $table: $db.consumers,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> reportMetersRefs<T extends Object>(
    Expression<T> Function($$ReportMetersTableAnnotationComposer a) f,
  ) {
    final $$ReportMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> readingsRefs<T extends Object>(
    Expression<T> Function($$ReadingsTableAnnotationComposer a) f,
  ) {
    final $$ReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readings,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.readings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> phaseLoadsRefs<T extends Object>(
    Expression<T> Function($$PhaseLoadsTableAnnotationComposer a) f,
  ) {
    final $$PhaseLoadsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.phaseLoads,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PhaseLoadsTableAnnotationComposer(
            $db: $db,
            $table: $db.phaseLoads,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> sealsRefs<T extends Object>(
    Expression<T> Function($$SealsTableAnnotationComposer a) f,
  ) {
    final $$SealsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.seals,
      getReferencedColumn: (t) => t.reportId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$SealsTableAnnotationComposer(
            $db: $db,
            $table: $db.seals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReportsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportsTable,
          Report,
          $$ReportsTableFilterComposer,
          $$ReportsTableOrderingComposer,
          $$ReportsTableAnnotationComposer,
          $$ReportsTableCreateCompanionBuilder,
          $$ReportsTableUpdateCompanionBuilder,
          (Report, $$ReportsTableReferences),
          Report,
          PrefetchHooks Function({
            bool consumerId,
            bool reportMetersRefs,
            bool readingsRefs,
            bool phaseLoadsRefs,
            bool sealsRefs,
          })
        > {
  $$ReportsTableTableManager(_$AppDatabase db, $ReportsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> consumerId = const Value.absent(),
                Value<String> reportType = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String> memoNo = const Value.absent(),
                Value<DateTime?> memoDate = const Value.absent(),
                Value<String> toSubDivision = const Value.absent(),
                Value<String> refType = const Value.absent(),
                Value<String> refNo = const Value.absent(),
                Value<DateTime?> refDate = const Value.absent(),
                Value<DateTime?> visitDate = const Value.absent(),
                Value<String> teamText = const Value.absent(),
                Value<String> sectionAJson = const Value.absent(),
                Value<String> msbStatus = const Value.absent(),
                Value<String> postalOrdersText = const Value.absent(),
                Value<String> checkedLoadKw = const Value.absent(),
                Value<String> loadType = const Value.absent(),
                Value<String> exportLoadText = const Value.absent(),
                Value<String> accuracyText = const Value.absent(),
                Value<String> transformerLtBushes = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String> storeChallanNo = const Value.absent(),
                Value<DateTime?> storeChallanDate = const Value.absent(),
                Value<String> newMeterCount = const Value.absent(),
                Value<String> ctCount = const Value.absent(),
                Value<String> signerExenOp = const Value.absent(),
                Value<String> signerSdoOp = const Value.absent(),
                Value<String> signer3 = const Value.absent(),
                Value<String> signer4 = const Value.absent(),
                Value<String> checkLoadOverride = const Value.absent(),
                Value<String> percentErrorOverride = const Value.absent(),
                Value<String> withinLimitOverride = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReportsCompanion(
                id: id,
                consumerId: consumerId,
                reportType: reportType,
                status: status,
                memoNo: memoNo,
                memoDate: memoDate,
                toSubDivision: toSubDivision,
                refType: refType,
                refNo: refNo,
                refDate: refDate,
                visitDate: visitDate,
                teamText: teamText,
                sectionAJson: sectionAJson,
                msbStatus: msbStatus,
                postalOrdersText: postalOrdersText,
                checkedLoadKw: checkedLoadKw,
                loadType: loadType,
                exportLoadText: exportLoadText,
                accuracyText: accuracyText,
                transformerLtBushes: transformerLtBushes,
                remarks: remarks,
                storeChallanNo: storeChallanNo,
                storeChallanDate: storeChallanDate,
                newMeterCount: newMeterCount,
                ctCount: ctCount,
                signerExenOp: signerExenOp,
                signerSdoOp: signerSdoOp,
                signer3: signer3,
                signer4: signer4,
                checkLoadOverride: checkLoadOverride,
                percentErrorOverride: percentErrorOverride,
                withinLimitOverride: withinLimitOverride,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int consumerId,
                required String reportType,
                Value<String> status = const Value.absent(),
                Value<String> memoNo = const Value.absent(),
                Value<DateTime?> memoDate = const Value.absent(),
                Value<String> toSubDivision = const Value.absent(),
                Value<String> refType = const Value.absent(),
                Value<String> refNo = const Value.absent(),
                Value<DateTime?> refDate = const Value.absent(),
                Value<DateTime?> visitDate = const Value.absent(),
                Value<String> teamText = const Value.absent(),
                Value<String> sectionAJson = const Value.absent(),
                Value<String> msbStatus = const Value.absent(),
                Value<String> postalOrdersText = const Value.absent(),
                Value<String> checkedLoadKw = const Value.absent(),
                Value<String> loadType = const Value.absent(),
                Value<String> exportLoadText = const Value.absent(),
                Value<String> accuracyText = const Value.absent(),
                Value<String> transformerLtBushes = const Value.absent(),
                Value<String> remarks = const Value.absent(),
                Value<String> storeChallanNo = const Value.absent(),
                Value<DateTime?> storeChallanDate = const Value.absent(),
                Value<String> newMeterCount = const Value.absent(),
                Value<String> ctCount = const Value.absent(),
                Value<String> signerExenOp = const Value.absent(),
                Value<String> signerSdoOp = const Value.absent(),
                Value<String> signer3 = const Value.absent(),
                Value<String> signer4 = const Value.absent(),
                Value<String> checkLoadOverride = const Value.absent(),
                Value<String> percentErrorOverride = const Value.absent(),
                Value<String> withinLimitOverride = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => ReportsCompanion.insert(
                id: id,
                consumerId: consumerId,
                reportType: reportType,
                status: status,
                memoNo: memoNo,
                memoDate: memoDate,
                toSubDivision: toSubDivision,
                refType: refType,
                refNo: refNo,
                refDate: refDate,
                visitDate: visitDate,
                teamText: teamText,
                sectionAJson: sectionAJson,
                msbStatus: msbStatus,
                postalOrdersText: postalOrdersText,
                checkedLoadKw: checkedLoadKw,
                loadType: loadType,
                exportLoadText: exportLoadText,
                accuracyText: accuracyText,
                transformerLtBushes: transformerLtBushes,
                remarks: remarks,
                storeChallanNo: storeChallanNo,
                storeChallanDate: storeChallanDate,
                newMeterCount: newMeterCount,
                ctCount: ctCount,
                signerExenOp: signerExenOp,
                signerSdoOp: signerSdoOp,
                signer3: signer3,
                signer4: signer4,
                checkLoadOverride: checkLoadOverride,
                percentErrorOverride: percentErrorOverride,
                withinLimitOverride: withinLimitOverride,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReportsTable, Report>(table),
                  $$ReportsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                consumerId = false,
                reportMetersRefs = false,
                readingsRefs = false,
                phaseLoadsRefs = false,
                sealsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (reportMetersRefs) db.reportMeters,
                    if (readingsRefs) db.readings,
                    if (phaseLoadsRefs) db.phaseLoads,
                    if (sealsRefs) db.seals,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (consumerId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.consumerId,
                            referencedTable: $$ReportsTableReferences
                                ._consumerIdTable(db),
                            referencedColumn: $$ReportsTableReferences
                                ._consumerIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (reportMetersRefs)
                        await $_getPrefetchedDataByColumns<
                          Report,
                          $ReportsTable,
                          ReportMeter,
                          $ReportMetersTable
                        >(
                          currentTable: table,
                          referencedTable: $$ReportsTableReferences
                              ._reportMetersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReportsTableReferences(
                                db,
                                table,
                                p0,
                              ).reportMetersRefs,
                          currentColumn: 'id',
                          referencedColumn: 'report_id',
                          typedResults: items,
                        ),
                      if (readingsRefs)
                        await $_getPrefetchedDataByColumns<
                          Report,
                          $ReportsTable,
                          Reading,
                          $ReadingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ReportsTableReferences
                              ._readingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReportsTableReferences(
                                db,
                                table,
                                p0,
                              ).readingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'report_id',
                          typedResults: items,
                        ),
                      if (phaseLoadsRefs)
                        await $_getPrefetchedDataByColumns<
                          Report,
                          $ReportsTable,
                          PhaseLoad,
                          $PhaseLoadsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ReportsTableReferences
                              ._phaseLoadsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReportsTableReferences(
                                db,
                                table,
                                p0,
                              ).phaseLoadsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'report_id',
                          typedResults: items,
                        ),
                      if (sealsRefs)
                        await $_getPrefetchedDataByColumns<
                          Report,
                          $ReportsTable,
                          Seal,
                          $SealsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ReportsTableReferences
                              ._sealsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReportsTableReferences(db, table, p0).sealsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'report_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ReportsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportsTable,
      Report,
      $$ReportsTableFilterComposer,
      $$ReportsTableOrderingComposer,
      $$ReportsTableAnnotationComposer,
      $$ReportsTableCreateCompanionBuilder,
      $$ReportsTableUpdateCompanionBuilder,
      (Report, $$ReportsTableReferences),
      Report,
      PrefetchHooks Function({
        bool consumerId,
        bool reportMetersRefs,
        bool readingsRefs,
        bool phaseLoadsRefs,
        bool sealsRefs,
      })
    >;
typedef $$ReportMetersTableCreateCompanionBuilder =
    ReportMetersCompanion Function({
      Value<int> id,
      required int reportId,
      Value<int?> meterId,
      required String columnRole,
      Value<bool> notApplicable,
    });
typedef $$ReportMetersTableUpdateCompanionBuilder =
    ReportMetersCompanion Function({
      Value<int> id,
      Value<int> reportId,
      Value<int?> meterId,
      Value<String> columnRole,
      Value<bool> notApplicable,
    });

final class $$ReportMetersTableReferences
    extends BaseReferences<_$AppDatabase, $ReportMetersTable, ReportMeter> {
  $$ReportMetersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReportsTable _reportIdTable(_$AppDatabase db) =>
      db.reports.createAlias('report_meters__report_id__reports__id');

  $$ReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<int>('report_id')!;

    final manager = $$ReportsTableTableManager(
      $_db,
      $_db.reports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $MetersTable _meterIdTable(_$AppDatabase db) =>
      db.meters.createAlias('report_meters__meter_id__meters__id');

  $$MetersTableProcessedTableManager? get meterId {
    final $_column = $_itemColumn<int>('meter_id');
    if ($_column == null) return null;
    final manager = $$MetersTableTableManager(
      $_db,
      $_db.meters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_meterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ReadingsTable, List<Reading>> _readingsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.readings,
    aliasName: 'report_meters__id__readings__report_meter_id',
  );

  $$ReadingsTableProcessedTableManager get readingsRefs {
    final manager = $$ReadingsTableTableManager(
      $_db,
      $_db.readings,
    ).filter((f) => f.reportMeterId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_readingsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ReportMetersTableFilterComposer
    extends Composer<_$AppDatabase, $ReportMetersTable> {
  $$ReportMetersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get columnRole => $composableBuilder(
    column: $table.columnRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notApplicable => $composableBuilder(
    column: $table.notApplicable,
    builder: (column) => ColumnFilters(column),
  );

  $$ReportsTableFilterComposer get reportId {
    final $$ReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableFilterComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetersTableFilterComposer get meterId {
    final $$MetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meterId,
      referencedTable: $db.meters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetersTableFilterComposer(
            $db: $db,
            $table: $db.meters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> readingsRefs(
    Expression<bool> Function($$ReadingsTableFilterComposer f) f,
  ) {
    final $$ReadingsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readings,
      getReferencedColumn: (t) => t.reportMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingsTableFilterComposer(
            $db: $db,
            $table: $db.readings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReportMetersTableOrderingComposer
    extends Composer<_$AppDatabase, $ReportMetersTable> {
  $$ReportMetersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get columnRole => $composableBuilder(
    column: $table.columnRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notApplicable => $composableBuilder(
    column: $table.notApplicable,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReportsTableOrderingComposer get reportId {
    final $$ReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableOrderingComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetersTableOrderingComposer get meterId {
    final $$MetersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meterId,
      referencedTable: $db.meters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetersTableOrderingComposer(
            $db: $db,
            $table: $db.meters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReportMetersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReportMetersTable> {
  $$ReportMetersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get columnRole => $composableBuilder(
    column: $table.columnRole,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get notApplicable => $composableBuilder(
    column: $table.notApplicable,
    builder: (column) => column,
  );

  $$ReportsTableAnnotationComposer get reportId {
    final $$ReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$MetersTableAnnotationComposer get meterId {
    final $$MetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.meterId,
      referencedTable: $db.meters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MetersTableAnnotationComposer(
            $db: $db,
            $table: $db.meters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> readingsRefs<T extends Object>(
    Expression<T> Function($$ReadingsTableAnnotationComposer a) f,
  ) {
    final $$ReadingsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.readings,
      getReferencedColumn: (t) => t.reportMeterId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReadingsTableAnnotationComposer(
            $db: $db,
            $table: $db.readings,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ReportMetersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReportMetersTable,
          ReportMeter,
          $$ReportMetersTableFilterComposer,
          $$ReportMetersTableOrderingComposer,
          $$ReportMetersTableAnnotationComposer,
          $$ReportMetersTableCreateCompanionBuilder,
          $$ReportMetersTableUpdateCompanionBuilder,
          (ReportMeter, $$ReportMetersTableReferences),
          ReportMeter,
          PrefetchHooks Function({
            bool reportId,
            bool meterId,
            bool readingsRefs,
          })
        > {
  $$ReportMetersTableTableManager(_$AppDatabase db, $ReportMetersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReportMetersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReportMetersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReportMetersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> reportId = const Value.absent(),
                Value<int?> meterId = const Value.absent(),
                Value<String> columnRole = const Value.absent(),
                Value<bool> notApplicable = const Value.absent(),
              }) => ReportMetersCompanion(
                id: id,
                reportId: reportId,
                meterId: meterId,
                columnRole: columnRole,
                notApplicable: notApplicable,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int reportId,
                Value<int?> meterId = const Value.absent(),
                required String columnRole,
                Value<bool> notApplicable = const Value.absent(),
              }) => ReportMetersCompanion.insert(
                id: id,
                reportId: reportId,
                meterId: meterId,
                columnRole: columnRole,
                notApplicable: notApplicable,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReportMetersTable, ReportMeter>(table),
                  $$ReportMetersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({reportId = false, meterId = false, readingsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [if (readingsRefs) db.readings],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (reportId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.reportId,
                            referencedTable: $$ReportMetersTableReferences
                                ._reportIdTable(db),
                            referencedColumn: $$ReportMetersTableReferences
                                ._reportIdTable(db)
                                .id,
                          ) as T;
                        }
                        if (meterId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.meterId,
                            referencedTable: $$ReportMetersTableReferences
                                ._meterIdTable(db),
                            referencedColumn: $$ReportMetersTableReferences
                                ._meterIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (readingsRefs)
                        await $_getPrefetchedDataByColumns<
                          ReportMeter,
                          $ReportMetersTable,
                          Reading,
                          $ReadingsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ReportMetersTableReferences
                              ._readingsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ReportMetersTableReferences(
                                db,
                                table,
                                p0,
                              ).readingsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'report_meter_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ReportMetersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReportMetersTable,
      ReportMeter,
      $$ReportMetersTableFilterComposer,
      $$ReportMetersTableOrderingComposer,
      $$ReportMetersTableAnnotationComposer,
      $$ReportMetersTableCreateCompanionBuilder,
      $$ReportMetersTableUpdateCompanionBuilder,
      (ReportMeter, $$ReportMetersTableReferences),
      ReportMeter,
      PrefetchHooks Function({bool reportId, bool meterId, bool readingsRefs})
    >;
typedef $$ReadingsTableCreateCompanionBuilder = ReadingsCompanion Function({
  Value<int> id,
  required int reportId,
  required int reportMeterId,
  required String paramCode,
  Value<String> valueText,
});
typedef $$ReadingsTableUpdateCompanionBuilder = ReadingsCompanion Function({
  Value<int> id,
  Value<int> reportId,
  Value<int> reportMeterId,
  Value<String> paramCode,
  Value<String> valueText,
});

final class $$ReadingsTableReferences
    extends BaseReferences<_$AppDatabase, $ReadingsTable, Reading> {
  $$ReadingsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReportsTable _reportIdTable(_$AppDatabase db) =>
      db.reports.createAlias('readings__report_id__reports__id');

  $$ReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<int>('report_id')!;

    final manager = $$ReportsTableTableManager(
      $_db,
      $_db.reports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ReportMetersTable _reportMeterIdTable(_$AppDatabase db) => db
      .reportMeters
      .createAlias('readings__report_meter_id__report_meters__id');

  $$ReportMetersTableProcessedTableManager get reportMeterId {
    final $_column = $_itemColumn<int>('report_meter_id')!;

    final manager = $$ReportMetersTableTableManager(
      $_db,
      $_db.reportMeters,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportMeterIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ReadingsTableFilterComposer
    extends Composer<_$AppDatabase, $ReadingsTable> {
  $$ReadingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paramCode => $composableBuilder(
    column: $table.paramCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valueText => $composableBuilder(
    column: $table.valueText,
    builder: (column) => ColumnFilters(column),
  );

  $$ReportsTableFilterComposer get reportId {
    final $$ReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableFilterComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReportMetersTableFilterComposer get reportMeterId {
    final $$ReportMetersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportMeterId,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableFilterComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingsTableOrderingComposer
    extends Composer<_$AppDatabase, $ReadingsTable> {
  $$ReadingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paramCode => $composableBuilder(
    column: $table.paramCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valueText => $composableBuilder(
    column: $table.valueText,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReportsTableOrderingComposer get reportId {
    final $$ReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableOrderingComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReportMetersTableOrderingComposer get reportMeterId {
    final $$ReportMetersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportMeterId,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableOrderingComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReadingsTable> {
  $$ReadingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get paramCode =>
      $composableBuilder(column: $table.paramCode, builder: (column) => column);

  GeneratedColumn<String> get valueText =>
      $composableBuilder(column: $table.valueText, builder: (column) => column);

  $$ReportsTableAnnotationComposer get reportId {
    final $$ReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ReportMetersTableAnnotationComposer get reportMeterId {
    final $$ReportMetersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportMeterId,
      referencedTable: $db.reportMeters,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportMetersTableAnnotationComposer(
            $db: $db,
            $table: $db.reportMeters,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ReadingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReadingsTable,
          Reading,
          $$ReadingsTableFilterComposer,
          $$ReadingsTableOrderingComposer,
          $$ReadingsTableAnnotationComposer,
          $$ReadingsTableCreateCompanionBuilder,
          $$ReadingsTableUpdateCompanionBuilder,
          (Reading, $$ReadingsTableReferences),
          Reading,
          PrefetchHooks Function({bool reportId, bool reportMeterId})
        > {
  $$ReadingsTableTableManager(_$AppDatabase db, $ReadingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReadingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReadingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReadingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> reportId = const Value.absent(),
                Value<int> reportMeterId = const Value.absent(),
                Value<String> paramCode = const Value.absent(),
                Value<String> valueText = const Value.absent(),
              }) => ReadingsCompanion(
                id: id,
                reportId: reportId,
                reportMeterId: reportMeterId,
                paramCode: paramCode,
                valueText: valueText,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int reportId,
                required int reportMeterId,
                required String paramCode,
                Value<String> valueText = const Value.absent(),
              }) => ReadingsCompanion.insert(
                id: id,
                reportId: reportId,
                reportMeterId: reportMeterId,
                paramCode: paramCode,
                valueText: valueText,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ReadingsTable, Reading>(table),
                  $$ReadingsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reportId = false, reportMeterId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reportId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.reportId,
                        referencedTable: $$ReadingsTableReferences
                            ._reportIdTable(db),
                        referencedColumn: $$ReadingsTableReferences
                            ._reportIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (reportMeterId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.reportMeterId,
                        referencedTable: $$ReadingsTableReferences
                            ._reportMeterIdTable(db),
                        referencedColumn: $$ReadingsTableReferences
                            ._reportMeterIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ReadingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReadingsTable,
      Reading,
      $$ReadingsTableFilterComposer,
      $$ReadingsTableOrderingComposer,
      $$ReadingsTableAnnotationComposer,
      $$ReadingsTableCreateCompanionBuilder,
      $$ReadingsTableUpdateCompanionBuilder,
      (Reading, $$ReadingsTableReferences),
      Reading,
      PrefetchHooks Function({bool reportId, bool reportMeterId})
    >;
typedef $$PhaseLoadsTableCreateCompanionBuilder = PhaseLoadsCompanion Function({
  Value<int> id,
  required int reportId,
  required String side,
  required String phase,
  Value<String> volts,
  Value<String> amps,
  Value<String> kwOverride,
  Value<String> pf,
});
typedef $$PhaseLoadsTableUpdateCompanionBuilder = PhaseLoadsCompanion Function({
  Value<int> id,
  Value<int> reportId,
  Value<String> side,
  Value<String> phase,
  Value<String> volts,
  Value<String> amps,
  Value<String> kwOverride,
  Value<String> pf,
});

final class $$PhaseLoadsTableReferences
    extends BaseReferences<_$AppDatabase, $PhaseLoadsTable, PhaseLoad> {
  $$PhaseLoadsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReportsTable _reportIdTable(_$AppDatabase db) =>
      db.reports.createAlias('phase_loads__report_id__reports__id');

  $$ReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<int>('report_id')!;

    final manager = $$ReportsTableTableManager(
      $_db,
      $_db.reports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PhaseLoadsTableFilterComposer
    extends Composer<_$AppDatabase, $PhaseLoadsTable> {
  $$PhaseLoadsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get volts => $composableBuilder(
    column: $table.volts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amps => $composableBuilder(
    column: $table.amps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get kwOverride => $composableBuilder(
    column: $table.kwOverride,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pf => $composableBuilder(
    column: $table.pf,
    builder: (column) => ColumnFilters(column),
  );

  $$ReportsTableFilterComposer get reportId {
    final $$ReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableFilterComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhaseLoadsTableOrderingComposer
    extends Composer<_$AppDatabase, $PhaseLoadsTable> {
  $$PhaseLoadsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get side => $composableBuilder(
    column: $table.side,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phase => $composableBuilder(
    column: $table.phase,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get volts => $composableBuilder(
    column: $table.volts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amps => $composableBuilder(
    column: $table.amps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kwOverride => $composableBuilder(
    column: $table.kwOverride,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pf => $composableBuilder(
    column: $table.pf,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReportsTableOrderingComposer get reportId {
    final $$ReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableOrderingComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhaseLoadsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PhaseLoadsTable> {
  $$PhaseLoadsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get side =>
      $composableBuilder(column: $table.side, builder: (column) => column);

  GeneratedColumn<String> get phase =>
      $composableBuilder(column: $table.phase, builder: (column) => column);

  GeneratedColumn<String> get volts =>
      $composableBuilder(column: $table.volts, builder: (column) => column);

  GeneratedColumn<String> get amps =>
      $composableBuilder(column: $table.amps, builder: (column) => column);

  GeneratedColumn<String> get kwOverride => $composableBuilder(
    column: $table.kwOverride,
    builder: (column) => column,
  );

  GeneratedColumn<String> get pf =>
      $composableBuilder(column: $table.pf, builder: (column) => column);

  $$ReportsTableAnnotationComposer get reportId {
    final $$ReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PhaseLoadsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PhaseLoadsTable,
          PhaseLoad,
          $$PhaseLoadsTableFilterComposer,
          $$PhaseLoadsTableOrderingComposer,
          $$PhaseLoadsTableAnnotationComposer,
          $$PhaseLoadsTableCreateCompanionBuilder,
          $$PhaseLoadsTableUpdateCompanionBuilder,
          (PhaseLoad, $$PhaseLoadsTableReferences),
          PhaseLoad,
          PrefetchHooks Function({bool reportId})
        > {
  $$PhaseLoadsTableTableManager(_$AppDatabase db, $PhaseLoadsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PhaseLoadsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PhaseLoadsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PhaseLoadsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> reportId = const Value.absent(),
                Value<String> side = const Value.absent(),
                Value<String> phase = const Value.absent(),
                Value<String> volts = const Value.absent(),
                Value<String> amps = const Value.absent(),
                Value<String> kwOverride = const Value.absent(),
                Value<String> pf = const Value.absent(),
              }) => PhaseLoadsCompanion(
                id: id,
                reportId: reportId,
                side: side,
                phase: phase,
                volts: volts,
                amps: amps,
                kwOverride: kwOverride,
                pf: pf,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int reportId,
                required String side,
                required String phase,
                Value<String> volts = const Value.absent(),
                Value<String> amps = const Value.absent(),
                Value<String> kwOverride = const Value.absent(),
                Value<String> pf = const Value.absent(),
              }) => PhaseLoadsCompanion.insert(
                id: id,
                reportId: reportId,
                side: side,
                phase: phase,
                volts: volts,
                amps: amps,
                kwOverride: kwOverride,
                pf: pf,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PhaseLoadsTable, PhaseLoad>(table),
                  $$PhaseLoadsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reportId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reportId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.reportId,
                        referencedTable: $$PhaseLoadsTableReferences
                            ._reportIdTable(db),
                        referencedColumn: $$PhaseLoadsTableReferences
                            ._reportIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PhaseLoadsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PhaseLoadsTable,
      PhaseLoad,
      $$PhaseLoadsTableFilterComposer,
      $$PhaseLoadsTableOrderingComposer,
      $$PhaseLoadsTableAnnotationComposer,
      $$PhaseLoadsTableCreateCompanionBuilder,
      $$PhaseLoadsTableUpdateCompanionBuilder,
      (PhaseLoad, $$PhaseLoadsTableReferences),
      PhaseLoad,
      PrefetchHooks Function({bool reportId})
    >;
typedef $$SealsTableCreateCompanionBuilder = SealsCompanion Function({
  Value<int> id,
  required int reportId,
  required String spot,
  required String columnRole,
  Value<String> mtSeal,
  Value<String> postalOrder,
});
typedef $$SealsTableUpdateCompanionBuilder = SealsCompanion Function({
  Value<int> id,
  Value<int> reportId,
  Value<String> spot,
  Value<String> columnRole,
  Value<String> mtSeal,
  Value<String> postalOrder,
});

final class $$SealsTableReferences
    extends BaseReferences<_$AppDatabase, $SealsTable, Seal> {
  $$SealsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ReportsTable _reportIdTable(_$AppDatabase db) =>
      db.reports.createAlias('seals__report_id__reports__id');

  $$ReportsTableProcessedTableManager get reportId {
    final $_column = $_itemColumn<int>('report_id')!;

    final manager = $$ReportsTableTableManager(
      $_db,
      $_db.reports,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_reportIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$SealsTableFilterComposer extends Composer<_$AppDatabase, $SealsTable> {
  $$SealsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get spot => $composableBuilder(
    column: $table.spot,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get columnRole => $composableBuilder(
    column: $table.columnRole,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mtSeal => $composableBuilder(
    column: $table.mtSeal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get postalOrder => $composableBuilder(
    column: $table.postalOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$ReportsTableFilterComposer get reportId {
    final $$ReportsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableFilterComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SealsTableOrderingComposer
    extends Composer<_$AppDatabase, $SealsTable> {
  $$SealsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get spot => $composableBuilder(
    column: $table.spot,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get columnRole => $composableBuilder(
    column: $table.columnRole,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mtSeal => $composableBuilder(
    column: $table.mtSeal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get postalOrder => $composableBuilder(
    column: $table.postalOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$ReportsTableOrderingComposer get reportId {
    final $$ReportsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableOrderingComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SealsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SealsTable> {
  $$SealsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get spot =>
      $composableBuilder(column: $table.spot, builder: (column) => column);

  GeneratedColumn<String> get columnRole => $composableBuilder(
    column: $table.columnRole,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mtSeal =>
      $composableBuilder(column: $table.mtSeal, builder: (column) => column);

  GeneratedColumn<String> get postalOrder => $composableBuilder(
    column: $table.postalOrder,
    builder: (column) => column,
  );

  $$ReportsTableAnnotationComposer get reportId {
    final $$ReportsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.reportId,
      referencedTable: $db.reports,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ReportsTableAnnotationComposer(
            $db: $db,
            $table: $db.reports,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$SealsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SealsTable,
          Seal,
          $$SealsTableFilterComposer,
          $$SealsTableOrderingComposer,
          $$SealsTableAnnotationComposer,
          $$SealsTableCreateCompanionBuilder,
          $$SealsTableUpdateCompanionBuilder,
          (Seal, $$SealsTableReferences),
          Seal,
          PrefetchHooks Function({bool reportId})
        > {
  $$SealsTableTableManager(_$AppDatabase db, $SealsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SealsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SealsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SealsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> reportId = const Value.absent(),
                Value<String> spot = const Value.absent(),
                Value<String> columnRole = const Value.absent(),
                Value<String> mtSeal = const Value.absent(),
                Value<String> postalOrder = const Value.absent(),
              }) => SealsCompanion(
                id: id,
                reportId: reportId,
                spot: spot,
                columnRole: columnRole,
                mtSeal: mtSeal,
                postalOrder: postalOrder,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int reportId,
                required String spot,
                required String columnRole,
                Value<String> mtSeal = const Value.absent(),
                Value<String> postalOrder = const Value.absent(),
              }) => SealsCompanion.insert(
                id: id,
                reportId: reportId,
                spot: spot,
                columnRole: columnRole,
                mtSeal: mtSeal,
                postalOrder: postalOrder,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SealsTable, Seal>(table),
                  $$SealsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({reportId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (reportId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.reportId,
                        referencedTable: $$SealsTableReferences._reportIdTable(
                          db,
                        ),
                        referencedColumn: $$SealsTableReferences
                            ._reportIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$SealsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SealsTable,
      Seal,
      $$SealsTableFilterComposer,
      $$SealsTableOrderingComposer,
      $$SealsTableAnnotationComposer,
      $$SealsTableCreateCompanionBuilder,
      $$SealsTableUpdateCompanionBuilder,
      (Seal, $$SealsTableReferences),
      Seal,
      PrefetchHooks Function({bool reportId})
    >;
typedef $$SettingsTableCreateCompanionBuilder = SettingsCompanion Function({
  required String key,
  Value<String> value,
  Value<int> rowid,
});
typedef $$SettingsTableUpdateCompanionBuilder = SettingsCompanion Function({
  Value<String> key,
  Value<String> value,
  Value<int> rowid,
});

class $$SettingsTableFilterComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SettingsTable> {
  $$SettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$SettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SettingsTable,
          Setting,
          $$SettingsTableFilterComposer,
          $$SettingsTableOrderingComposer,
          $$SettingsTableAnnotationComposer,
          $$SettingsTableCreateCompanionBuilder,
          $$SettingsTableUpdateCompanionBuilder,
          (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
          Setting,
          PrefetchHooks Function()
        > {
  $$SettingsTableTableManager(_$AppDatabase db, $SettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback: ({
            required String key,
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => SettingsCompanion.insert(key: key, value: value, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SettingsTable, Setting>(table),
                  BaseReferences<_$AppDatabase, $SettingsTable, Setting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SettingsTable,
      Setting,
      $$SettingsTableFilterComposer,
      $$SettingsTableOrderingComposer,
      $$SettingsTableAnnotationComposer,
      $$SettingsTableCreateCompanionBuilder,
      $$SettingsTableUpdateCompanionBuilder,
      (Setting, BaseReferences<_$AppDatabase, $SettingsTable, Setting>),
      Setting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ConsumersTableTableManager get consumers =>
      $$ConsumersTableTableManager(_db, _db.consumers);
  $$MetersTableTableManager get meters =>
      $$MetersTableTableManager(_db, _db.meters);
  $$ReportsTableTableManager get reports =>
      $$ReportsTableTableManager(_db, _db.reports);
  $$ReportMetersTableTableManager get reportMeters =>
      $$ReportMetersTableTableManager(_db, _db.reportMeters);
  $$ReadingsTableTableManager get readings =>
      $$ReadingsTableTableManager(_db, _db.readings);
  $$PhaseLoadsTableTableManager get phaseLoads =>
      $$PhaseLoadsTableTableManager(_db, _db.phaseLoads);
  $$SealsTableTableManager get seals =>
      $$SealsTableTableManager(_db, _db.seals);
  $$SettingsTableTableManager get settings =>
      $$SettingsTableTableManager(_db, _db.settings);
}
