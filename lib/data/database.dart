import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../domain/settings_keys.dart';
import 'tables.dart';

export 'tables.dart';

part 'database.g.dart';

const dbFileName = 'mepco_meter.sqlite';

Future<File> databaseFile() async {
  final dir = await getApplicationDocumentsDirectory();
  return File(p.join(dir.path, dbFileName));
}

@DriftDatabase(
  tables: [
    Consumers,
    Meters,
    Reports,
    ReportMeters,
    Readings,
    PhaseLoads,
    Seals,
    Settings,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Opens the database file in the app documents folder.
  factory AppDatabase.open() {
    return AppDatabase(
      LazyDatabase(() async {
        final file = await databaseFile();
        return NativeDatabase.createInBackground(file);
      }),
    );
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();
    },
    onUpgrade: (m, from, to) async {
      // Step by step. Never drop user data.
      if (from < 2) {
        await m.addColumn(consumers, consumers.ctVaBurden);
        await m.addColumn(reports, reports.loadType);
      }
      if (from < 3) {
        await m.addColumn(consumers, consumers.sanctionDate);
      }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
      // Insert any setting that is missing (keeps edited values).
      for (final e in SettingKeys.defaults.entries) {
        await into(settings).insert(
          SettingsCompanion.insert(key: e.key, value: Value(e.value)),
          mode: InsertMode.insertOrIgnore,
        );
      }
    },
  );
}
