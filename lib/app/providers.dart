import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/daos.dart';
import '../data/database.dart';

/// The open database. Invalidate it after a restore to re-open the file.
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase.open();
  ref.onDispose(db.close);
  return db;
});

final consumersDaoProvider = Provider(
  (ref) => ConsumersDao(ref.watch(databaseProvider)),
);
final metersDaoProvider = Provider(
  (ref) => MetersDao(ref.watch(databaseProvider)),
);
final reportsDaoProvider = Provider(
  (ref) => ReportsDao(ref.watch(databaseProvider)),
);
final settingsDaoProvider = Provider(
  (ref) => SettingsDao(ref.watch(databaseProvider)),
);

final settingsProvider = StreamProvider<Map<String, String>>(
  (ref) => ref.watch(settingsDaoProvider).watchAll(),
);

final consumerProvider = StreamProvider.autoDispose.family<ConsumerRow?, int>(
  (ref, id) => ref.watch(consumersDaoProvider).watchById(id),
);

final consumerMetersProvider = StreamProvider.autoDispose
    .family<List<Meter>, int>(
      (ref, id) => ref.watch(metersDaoProvider).watchForConsumer(id),
    );

final consumerReportsProvider = StreamProvider.autoDispose
    .family<List<ReportListItem>, int>(
      (ref, id) => ref.watch(reportsDaoProvider).watchForConsumer(id),
    );

final draftsProvider = StreamProvider.autoDispose<List<ReportListItem>>(
  (ref) => ref.watch(reportsDaoProvider).watchDrafts(),
);
