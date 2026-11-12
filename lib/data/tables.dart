import 'package:drift/drift.dart';

/// Consumers (one row per account). Numbers are kept as text, exactly as typed.
@DataClassName('ConsumerRow')
class Consumers extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get accountNo => text().unique()();
  TextColumn get tariff => text().withDefault(const Constant(''))();
  TextColumn get name => text().withDefault(const Constant(''))();
  TextColumn get address => text().withDefault(const Constant(''))();
  TextColumn get subDivision => text().withDefault(const Constant(''))();
  TextColumn get opDivision => text().withDefault(const Constant(''))();
  TextColumn get sanctionedLoadKw => text().withDefault(const Constant(''))();
  TextColumn get connectedLoad => text().withDefault(const Constant(''))();
  TextColumn get industryKind => text().withDefault(const Constant(''))();
  TextColumn get transformerKva => text().withDefault(const Constant(''))();
  TextColumn get transformerMake => text().withDefault(const Constant(''))();
  TextColumn get transformerNo => text().withDefault(const Constant(''))();
  TextColumn get ctPrimary => text().withDefault(const Constant(''))();
  TextColumn get ctSecondary => text().withDefault(const Constant(''))();
  TextColumn get mf => text().withDefault(const Constant(''))();
  TextColumn get cableSize => text().withDefault(const Constant(''))();
  TextColumn get msbType => text().withDefault(const Constant(''))();
  TextColumn get feederName => text().withDefault(const Constant(''))();
  TextColumn get applicationNo => text().withDefault(const Constant(''))();
  DateTimeColumn get applicationDate => dateTime().nullable()();
  TextColumn get sanctionRef => text().withDefault(const Constant(''))();
  TextColumn get scoMcoRcoNo => text().withDefault(const Constant(''))();
  DateTimeColumn get scoDate => dateTime().nullable()();
  TextColumn get notes => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class Meters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get consumerId =>
      integer().references(Consumers, #id, onDelete: KeyAction.cascade)();
  TextColumn get mfgNo => text()();
  TextColumn get make => text().withDefault(const Constant(''))();

  /// AMR / TOU / AMI / NET
  TextColumn get meterKind => text().withDefault(const Constant('AMR'))();
  TextColumn get amps => text().withDefault(const Constant(''))();
  TextColumn get volts => text().withDefault(const Constant(''))();
  TextColumn get meterConstant => text().withDefault(const Constant(''))();
  TextColumn get mf => text().withDefault(const Constant(''))();
  TextColumn get simNo => text().withDefault(const Constant(''))();
  TextColumn get commId => text().withDefault(const Constant(''))();

  /// active / removed
  TextColumn get status => text().withDefault(const Constant('active'))();
  DateTimeColumn get installedOn => dateTime().nullable()();
  DateTimeColumn get removedOn => dateTime().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class Reports extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get consumerId =>
      integer().references(Consumers, #id, onDelete: KeyAction.cascade)();
  TextColumn get reportType => text()();

  /// draft / final
  TextColumn get status => text().withDefault(const Constant('draft'))();
  TextColumn get memoNo => text().withDefault(const Constant(''))();
  DateTimeColumn get memoDate => dateTime().nullable()();
  TextColumn get toSubDivision => text().withDefault(const Constant(''))();

  /// memo / telephonic / seasonal / routine
  TextColumn get refType => text().withDefault(const Constant('memo'))();
  TextColumn get refNo => text().withDefault(const Constant(''))();
  DateTimeColumn get refDate => dateTime().nullable()();
  DateTimeColumn get visitDate => dateTime().nullable()();
  TextColumn get teamText => text().withDefault(const Constant(''))();

  /// Snapshot of section A (consumer fields) as JSON, so old reports never change.
  TextColumn get sectionAJson => text().withDefault(const Constant('{}'))();
  TextColumn get msbStatus => text().withDefault(const Constant(''))();
  TextColumn get postalOrdersText => text().withDefault(const Constant(''))();
  TextColumn get checkedLoadKw => text().withDefault(const Constant(''))();
  TextColumn get exportLoadText => text().withDefault(const Constant(''))();
  TextColumn get accuracyText => text().withDefault(const Constant(''))();
  TextColumn get transformerLtBushes =>
      text().withDefault(const Constant(''))();
  TextColumn get remarks => text().withDefault(const Constant(''))();
  TextColumn get storeChallanNo => text().withDefault(const Constant(''))();
  DateTimeColumn get storeChallanDate => dateTime().nullable()();
  TextColumn get newMeterCount => text().withDefault(const Constant(''))();
  TextColumn get ctCount => text().withDefault(const Constant(''))();
  TextColumn get signerExenOp => text().withDefault(const Constant(''))();
  TextColumn get signerSdoOp => text().withDefault(const Constant(''))();
  TextColumn get signer3 => text().withDefault(const Constant(''))();
  TextColumn get signer4 => text().withDefault(const Constant(''))();

  /// Manual overrides of the computed values in section C (empty = computed).
  TextColumn get checkLoadOverride => text().withDefault(const Constant(''))();
  TextColumn get percentErrorOverride =>
      text().withDefault(const Constant(''))();
  TextColumn get withinLimitOverride =>
      text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

class ReportMeters extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reportId =>
      integer().references(Reports, #id, onDelete: KeyAction.cascade)();
  IntColumn get meterId => integer().nullable().references(
    Meters,
    #id,
    onDelete: KeyAction.setNull,
  )();

  /// removed / amr / existing / billing / backup / backup_removed
  TextColumn get columnRole => text()();
  BoolColumn get notApplicable =>
      boolean().withDefault(const Constant(false))();
}

class Readings extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reportId =>
      integer().references(Reports, #id, onDelete: KeyAction.cascade)();
  IntColumn get reportMeterId =>
      integer().references(ReportMeters, #id, onDelete: KeyAction.cascade)();
  TextColumn get paramCode => text()();
  TextColumn get valueText => text().withDefault(const Constant(''))();
}

class PhaseLoads extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reportId =>
      integer().references(Reports, #id, onDelete: KeyAction.cascade)();

  /// import / export
  TextColumn get side => text()();

  /// R / Y / B
  TextColumn get phase => text()();
  TextColumn get volts => text().withDefault(const Constant(''))();
  TextColumn get amps => text().withDefault(const Constant(''))();
  TextColumn get kwOverride => text().withDefault(const Constant(''))();
  TextColumn get pf => text().withDefault(const Constant(''))();
}

class Seals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reportId =>
      integer().references(Reports, #id, onDelete: KeyAction.cascade)();

  /// TOU_MC, TOU_TC, MSB, MSB_2, MSB_GLASS, TFORMER
  TextColumn get spot => text()();
  TextColumn get columnRole => text()();
  TextColumn get mtSeal => text().withDefault(const Constant(''))();
  TextColumn get postalOrder => text().withDefault(const Constant(''))();
}

class Settings extends Table {
  TextColumn get key => text()();
  TextColumn get value => text().withDefault(const Constant(''))();

  @override
  Set<Column> get primaryKey => {key};
}
