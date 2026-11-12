import 'package:material_ui/material_ui.dart';

/// Width at which the layout switches to two panes (tablet landscape).
const tabletBreakpoint = 900.0;

bool isWide(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= tabletBreakpoint;

const warningColor = Color(0xFFFFF3C4);
const warningBorder = Color(0xFFE0A800);
const okColor = Color(0xFF2E7D32);

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(seedColor: const Color(0xFF0D47A1));
  return ThemeData(
    colorScheme: scheme,
    visualDensity: VisualDensity.standard,
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
      isDense: false,
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size(64, 52),
        textStyle: const TextStyle(fontSize: 16),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(minimumSize: const Size(64, 52)),
    ),
    listTileTheme: const ListTileThemeData(minVerticalPadding: 10),
  );
}
