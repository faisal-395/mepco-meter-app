// Renders app screens to PNG files for design review (not part of CI).
// Run: flutter test tool/screenshots_test.dart --update-goldens
import 'dart:io';

import 'package:drift/drift.dart' show driftRuntimeOptions;
import 'package:drift/native.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mepco_meter_app/app/providers.dart';
import 'package:mepco_meter_app/app/router.dart';
import 'package:mepco_meter_app/app/theme.dart';
import 'package:mepco_meter_app/data/database.dart';
import 'package:mepco_meter_app/data/demo_data.dart';

const _fonts = '/opt/flutter/bin/cache/artifacts/material_fonts';

Future<void> _loadFonts() async {
  ByteData f(String name) =>
      ByteData.view(File('$_fonts/$name').readAsBytesSync().buffer);
  final roboto = FontLoader('Roboto');
  for (final n in [
    'Roboto-Regular.ttf',
    'Roboto-Medium.ttf',
    'Roboto-Bold.ttf',
  ]) {
    roboto.addFont(Future.value(f(n)));
  }
  await roboto.load();
  await (FontLoader(
    'MaterialIcons',
  )..addFont(Future.value(f('MaterialIcons-Regular.otf')))).load();
}

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
  final label = Platform.environment['SHOT_LABEL'] ?? 'shot';

  for (final (name, size) in [
    ('phone', const Size(412, 900)),
    ('tablet', const Size(1280, 800)),
  ]) {
    testWidgets('screenshots $name', (tester) async {
      await tester.runAsync(_loadFonts);
      tester.view.physicalSize = size * 2;
      tester.view.devicePixelRatio = 2;
      // Simulated status bar and navigation bar (edge-to-edge Android).
      tester.view.padding = const FakeViewPadding(top: 48, bottom: 96);
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
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: buildTheme(),
            builder: appFrame,
            routerConfig: router,
          ),
        ),
      );
      await settle(tester);

      Future<void> shot(String file) async {
        await settle(tester);
        await expectLater(
          find.byType(MaterialApp),
          matchesGoldenFile('shots/${label}_${name}_$file.png'),
        );
      }

      await shot('01_home');
      router.push('/consumers/1');
      await shot('02_consumer');
      router.pop();
      router.push('/reports/${ids[0]}');
      await settle(tester);
      await shot('03_header');
      final steps = {
        1: '04_section_a',
        2: '05_meters',
        3: '06_readings',
        4: '07_section_c',
        5: '08_seals',
        6: '08b_remarks',
        7: '08c_signers',
        8: '09_review',
      };
      var at = 0;
      for (final e in steps.entries) {
        while (at < e.key) {
          await tester.tap(find.text('Next'));
          await settle(tester);
          at++;
        }
        await shot(e.value);
      }
      router.pop();
      router.push('/settings');
      await shot('10_settings');
      await tester.drag(find.byType(Scrollable).last, const Offset(0, -6000));
      await shot('11_settings_bottom');
      await tester.pumpWidget(const SizedBox());
      await tester.pump(const Duration(seconds: 10));
    });
  }
}
