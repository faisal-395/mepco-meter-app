import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mepco_meter_app/app/providers.dart';
import 'package:mepco_meter_app/app/router.dart';
import 'package:mepco_meter_app/app/theme.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';

/// Opens the app on a phone-sized and a tablet-sized screen and walks
/// through the screens and every wizard step of each demo report.
Future<void> settle(WidgetTester t) async {
  for (var i = 0; i < 6; i++) {
    await t.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 30)),
    );
    await t.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
  for (final size in [const Size(400, 860), const Size(1280, 800)]) {
    testWidgets('screens and wizard render at ${size.width}x${size.height}', (
      tester,
    ) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      late AppDatabase db;
      late List<int> ids;
      await tester.runAsync(() async {
        db = AppDatabase(NativeDatabase.memory());
        ids = await insertDemoData(db);
      });

      final router = buildRouter();
      await tester.pumpWidget(
        ProviderScope(
          overrides: [databaseProvider.overrideWithValue(db)],
          child: MaterialApp.router(theme: buildTheme(), routerConfig: router),
        ),
      );
      await settle(tester);
      expect(find.text('NEW REPORT'), findsWidgets);
      expect(find.text('Test Cotton Factory'), findsOneWidget);

      for (final path in [
        '/consumers',
        '/settings',
        '/reports',
        '/search',
        '/consumers/1/history',
        '/consumers/2/history',
      ]) {
        router.push(path);
        await settle(tester);
        router.pop();
        await settle(tester);
      }
      router.push('/consumers/1');
      await settle(tester);
      router.pop();
      await settle(tester);

      for (final id in ids) {
        router.push('/reports/$id');
        await settle(tester);
        for (var step = 0; step < 8; step++) {
          await tester.tap(find.text('Next'));
          await settle(tester);
        }
        expect(find.text('Mark final'), findsOneWidget);
        router.pop();
        await settle(tester);
      }

      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 10));
      // The in-memory database is not closed: close() waits on the fake clock.
    }, timeout: const Timeout(Duration(minutes: 3)));
  }
}
