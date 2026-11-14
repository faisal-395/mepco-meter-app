import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mepco_meter_app/app/field_focus.dart';
import 'package:mepco_meter_app/app/providers.dart';
import 'package:mepco_meter_app/app/router.dart';
import 'package:mepco_meter_app/app/theme.dart';
import 'package:mepco_meter_app/data/daos.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';

Future<void> settle(WidgetTester t) async {
  for (var i = 0; i < 8; i++) {
    await t.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 30)),
    );
    await t.pump(const Duration(milliseconds: 120));
  }
}

void main() {
  driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;

  testWidgets('a reading warning opens the right meter tab and row', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(412, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    late AppDatabase db;
    late int id;
    await tester.runAsync(() async {
      db = AppDatabase(NativeDatabase.memory());
      id = (await insertDemoData(db)).first;
      final dao = ReportsDao(db);
      final b = (await dao.loadBundle(id))!;
      // Existing meter: total that is not Peak + Off Peak.
      b.column('existing').readings['kwh_total'] = '9999.99';
      await dao.saveBundle(b);
    });
    final router = buildRouter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          theme: buildTheme(),
          builder: appFrame,
          routerConfig: router,
        ),
      ),
    );
    router.push('/reports/$id');
    await settle(tester);
    for (var i = 0; i < 8; i++) {
      await tester.tap(find.text('Next'));
      await settle(tester);
    }
    final w = find.textContaining('Current Total KWH 9999.99');
    expect(w, findsOneWidget);
    await tester.tap(w);
    await settle(tester);
    await tester.pump(const Duration(seconds: 2));
    await settle(tester);

    expect(find.text('METER READINGS'), findsOneWidget);
    final focused = FocusManager.instance.primaryFocus?.context;
    expect(focused, isNotNull);
    final anchor = focused!.findAncestorWidgetOfExactType<FieldAnchor>();
    expect(anchor?.id, 'r:existing:kwh_total');

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 10));
  }, timeout: const Timeout(Duration(minutes: 2)));

  testWidgets('tapping a warning opens the exact field', (tester) async {
    tester.view.physicalSize = const Size(412, 900);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    late AppDatabase db;
    late int id;
    await tester.runAsync(() async {
      db = AppDatabase(NativeDatabase.memory());
      id = (await insertDemoData(db)).first;
      // Make the memo No missing so the review lists a warning for it.
      final dao = ReportsDao(db);
      final b = (await dao.loadBundle(id))!;
      b.report = b.report.copyWith(memoNo: '');
      await dao.saveBundle(b);
    });
    final router = buildRouter();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [databaseProvider.overrideWithValue(db)],
        child: MaterialApp.router(
          theme: buildTheme(),
          builder: appFrame,
          routerConfig: router,
        ),
      ),
    );
    router.push('/reports/$id');
    await settle(tester);
    for (var i = 0; i < 8; i++) {
      await tester.tap(find.text('Next'));
      await settle(tester);
    }
    expect(find.text('Memo No is empty'), findsOneWidget);

    await tester.tap(find.text('Memo No is empty'));
    await settle(tester);
    await tester.pump(const Duration(seconds: 2));
    await settle(tester);

    // Back on the header step, with the cursor in the Memo No. field.
    expect(find.text('MEMO & REFERENCE'), findsOneWidget);
    final focused = FocusManager.instance.primaryFocus?.context;
    expect(focused, isNotNull);
    final field = focused!.findAncestorWidgetOfExactType<TextField>();
    expect(field?.decoration?.labelText, 'Memo No.');

    await tester.pumpWidget(const SizedBox());
    await tester.pump(const Duration(seconds: 10));
  }, timeout: const Timeout(Duration(minutes: 2)));
}
