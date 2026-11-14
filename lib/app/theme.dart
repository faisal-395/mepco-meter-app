import 'package:material_ui/material_ui.dart';

/// Width at which the layout switches to two panes (tablet landscape).
const tabletBreakpoint = 900.0;

bool isWide(BuildContext context) =>
    MediaQuery.sizeOf(context).width >= tabletBreakpoint;

/// Official palette: navy (government document blue), gold accent, paper white.
class AppColors {
  static const navy = Color(0xFF0B2E59);
  static const navyDark = Color(0xFF071F3D);
  static const navyLight = Color(0xFFE6ECF4);
  static const gold = Color(0xFFC9A227);
  static const goldLight = Color(0xFFF7EFD2);
  static const paper = Color(0xFFF4F6F9);
  static const line = Color(0xFFC9D1DC);
  static const text = Color(0xFF1A2333);
  static const muted = Color(0xFF5B6678);
}

const warningColor = Color(0xFFFFF4D1);
const warningBorder = Color(0xFFD9A400);
const okColor = Color(0xFF1E7B34);

const _radius = BorderRadius.all(Radius.circular(6));

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: AppColors.navy,
    primary: AppColors.navy,
    onPrimary: Colors.white,
    secondary: AppColors.gold,
    onSecondary: AppColors.navyDark,
    surface: Colors.white,
    onSurface: AppColors.text,
  );
  const fieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(4)),
    borderSide: BorderSide(color: AppColors.line),
  );
  return ThemeData(
    colorScheme: scheme,
    fontFamily: 'Roboto',
    scaffoldBackgroundColor: AppColors.paper,
    visualDensity: VisualDensity.standard,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.navy,
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 2,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        fontSize: 19,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        letterSpacing: 0.2,
      ),
    ),
    cardTheme: const CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: _radius,
        side: BorderSide(color: AppColors.line),
      ),
    ),
    dividerTheme: const DividerThemeData(color: AppColors.line, space: 1),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: fieldBorder,
      enabledBorder: fieldBorder,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(4)),
        borderSide: BorderSide(color: AppColors.navy, width: 2),
      ),
      labelStyle: TextStyle(color: AppColors.muted),
      floatingLabelStyle: TextStyle(
        color: AppColors.navy,
        fontWeight: FontWeight.w600,
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        minimumSize: const Size(64, 52),
        shape: const RoundedRectangleBorder(borderRadius: _radius),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.navy,
        minimumSize: const Size(64, 52),
        side: const BorderSide(color: AppColors.navy),
        shape: const RoundedRectangleBorder(borderRadius: _radius),
        textStyle: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.navy,
        shape: const RoundedRectangleBorder(borderRadius: _radius),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.gold,
      foregroundColor: AppColors.navyDark,
      shape: RoundedRectangleBorder(borderRadius: _radius),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: AppColors.navy,
      unselectedLabelColor: AppColors.muted,
      indicatorColor: AppColors.gold,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
    ),
    listTileTheme: const ListTileThemeData(
      minVerticalPadding: 10,
      iconColor: AppColors.navy,
    ),
    dialogTheme: const DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: _radius),
    ),
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: AppColors.navy,
        selectedForegroundColor: Colors.white,
        shape: const RoundedRectangleBorder(borderRadius: _radius),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.gold,
      linearTrackColor: AppColors.navyDark,
    ),
  );
}

/// Wraps every screen: keeps content (buttons, last list items, dialogs) above
/// the phone's navigation buttons / gesture bar. Android draws apps behind that
/// bar ("edge to edge"), so without this the bottom of screens is hidden.
Widget appFrame(BuildContext context, Widget? child) => ColoredBox(
  color: AppColors.paper,
  child: SafeArea(top: false, child: child ?? const SizedBox.shrink()),
);

/// Text buttons placed in the navy app bar (white, readable).
final appBarButtonStyle = TextButton.styleFrom(
  foregroundColor: Colors.white,
  disabledForegroundColor: Colors.white54,
  textStyle: const TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
);
