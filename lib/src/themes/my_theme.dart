
import 'package:flutter/material.dart';
import 'package:pokedex_sprout/src/themes/my_color.dart';
import 'package:pokedex_sprout/src/themes/my_text_style.dart';
import 'package:pokedex_sprout/src/utils/utils.dart';

class MyColorTheme {
  final Color primary;
  final Color primaryLight;
  final Color secondary;
  final Color background;
  final Color surface;
  final Color error;
  final Color onBackground;
  final Color onSurface;
  final Color buttonDisabled;

  const MyColorTheme({
    required this.primary,
    required this.primaryLight,
    required this.secondary,
    required this.background,
    required this.surface,
    required this.error,
    required this.onBackground,
    required this.onSurface,
    required this.buttonDisabled,
  });
}

class MyTheme {
  // === COLOR PALETTES ===
  static final defaultLightColor = MyColorTheme(
    primary: MyColor.primary,
    primaryLight: MyColor.primaryLight,
    secondary: const Color(0xFF5ED5A8),
    background: const Color(0xFFF7F9FB),
    surface: Colors.white,
    error: const Color(0xFFD42A33),
    onBackground: const Color(0xFF252727),
    onSurface: const Color(0xFF444646),
    buttonDisabled: const Color(0xFFD0D1D1),
  );


  static ColorScheme colorScheme = Theme.of(Utils.navigatorKey.currentContext!).colorScheme;

  // === THEME FACTORIES ===
  static ThemeData defaultLight() =>
      _buildTheme(defaultLightColor, Brightness.light);

  static ThemeData _buildTheme(MyColorTheme color, Brightness brightness) {
    return ThemeData(
      fontFamily: MyTextStyle.fontFamily,
      primaryColor: color.primary,
      brightness: brightness,
      scaffoldBackgroundColor: color.background,
      appBarTheme: AppBarTheme(
        backgroundColor: color.primary,
        iconTheme: IconThemeData(color: color.surface),
        titleTextStyle: MyTextStyle.h6.semiBold.withColor(color.surface),
      ),
      textTheme: TextTheme(
        headlineLarge: MyTextStyle.h1.bold.copyWith(color: color.onSurface),
        headlineMedium: MyTextStyle.h3.bold.copyWith(color: color.onSurface),
        headlineSmall: MyTextStyle.h5.bold.copyWith(color: color.onSurface),
        labelLarge: MyTextStyle.h6.semiBold.copyWith(color: color.onSurface),
        labelMedium: MyTextStyle.h7.semiBold.copyWith(color: color.onSurface),
        labelSmall: MyTextStyle.h8.semiBold.copyWith(color: color.onSurface),
        displayLarge: MyTextStyle.h6.copyWith(color: color.onSurface),
        displayMedium: MyTextStyle.h6.copyWith(color: color.onSurface),
        displaySmall: MyTextStyle.h6.copyWith(color: color.onSurface),
        titleLarge: MyTextStyle.h2.bold.copyWith(color: color.onSurface),
        titleMedium: MyTextStyle.h4.bold.copyWith(color: color.onSurface),
        titleSmall: MyTextStyle.h5.bold.copyWith(color: color.onSurface),
        bodyLarge: MyTextStyle.h5.copyWith(color: color.onSurface),
        bodyMedium: MyTextStyle.h6.copyWith(color: color.onSurface),
        bodySmall: MyTextStyle.h7.copyWith(color: color.onSurface),
      ),
      colorScheme: ColorScheme(
        brightness: brightness,
        primary: color.primary,
        primaryContainer: color.primaryLight,
        secondary: color.secondary,
        secondaryContainer: color.secondary,
        background: color.background,
        surface: color.surface,
        error: color.error,
        onPrimary: color.surface,
        onSecondary: color.surface,
        onBackground: color.onBackground,
        onSurface: color.onSurface,
        onError: color.surface,
      ),
      cardColor: color.primaryLight,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: color.primary,
          foregroundColor: color.surface,
          disabledBackgroundColor: color.buttonDisabled,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: color.primary,
        foregroundColor: color.surface,
      ),
      dividerTheme: DividerThemeData(
        color: Colors.transparent
      )
    );
  }
}
