import 'package:flutter/material.dart';

abstract final class AppColors {
  // Primary - Vibrant Purple/Indigo Gradient Palette
  static const Color primary = Color(0xFF7C3AED);
  static const Color primaryLight = Color(0xFF9F67FF);
  static const Color primaryDark = Color(0xFF5B21B6);
  static const Color primaryDeep = Color(0xFF4C1D95);

  // Gradient endpoints
  static const Color gradientStart = Color(0xFF7C3AED);
  static const Color gradientMid = Color(0xFF6366F1);
  static const Color gradientEnd = Color(0xFF818CF8);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient primaryVerticalGradient = LinearGradient(
    colors: [gradientStart, gradientMid, gradientEnd],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Secondary - Teal/Cyan Accent
  static const Color secondary = Color(0xFF14B8A6);
  static const Color secondaryLight = Color(0xFF5EEAD4);
  static const Color secondaryDark = Color(0xFF0D9488);

  // Surface colors for glassmorphism
  static const Color surfaceLight = Color(0xFFF8F9FF);
  static const Color surfaceLightAlt = Color(0xFFF1F0FB);
  static const Color surfaceDark = Color(0xFF0F0D1A);
  static const Color surfaceDarkAlt = Color(0xFF1A1726);
  static const Color surfaceDarkElevated = Color(0xFF252136);

  // Glass surfaces
  static const Color glassWhite = Color(0x33FFFFFF);
  static const Color glassWhiteSubtle = Color(0x1AFFFFFF);
  static const Color glassWhiteBorder = Color(0x40FFFFFF);
  static const Color glassDark = Color(0x4D1A1726);
  static const Color glassDarkSubtle = Color(0x331A1726);
  static const Color glassDarkBorder = Color(0x33FFFFFF);

  // Text colors
  static const Color textPrimaryLight = Color(0xFF1A1726);
  static const Color textSecondaryLight = Color(0xFF64607A);
  static const Color textTertiaryLight = Color(0xFF9994AE);

  static const Color textPrimaryDark = Color(0xFFF8F9FF);
  static const Color textSecondaryDark = Color(0xFFB4B0C8);
  static const Color textTertiaryDark = Color(0xFF7A7590);

  // Semantic colors
  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFF4ADE80);
  static const Color successDark = Color(0xFF16A34A);
  static const Color successSurface = Color(0x1A22C55E);

  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFBBF24);
  static const Color warningDark = Color(0xFFD97706);
  static const Color warningSurface = Color(0x1AF59E0B);

  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFF87171);
  static const Color errorDark = Color(0xFFDC2626);
  static const Color errorSurface = Color(0x1AEF4444);

  static const Color info = Color(0xFF3B82F6);
  static const Color infoLight = Color(0xFF60A5FA);
  static const Color infoDark = Color(0xFF2563EB);
  static const Color infoSurface = Color(0x1A3B82F6);

  // Expense category colors
  static const Color categoryFood = Color(0xFFF97316);
  static const Color categoryTransport = Color(0xFF3B82F6);
  static const Color categoryLodging = Color(0xFF8B5CF6);
  static const Color categoryActivities = Color(0xFF22C55E);
  static const Color categoryShopping = Color(0xFFEC4899);
  static const Color categoryEmergency = Color(0xFFEF4444);

  // Expense category surface colors (for backgrounds/chips)
  static const Color categoryFoodSurface = Color(0x1AF97316);
  static const Color categoryTransportSurface = Color(0x1A3B82F6);
  static const Color categoryLodgingSurface = Color(0x1A8B5CF6);
  static const Color categoryActivitiesSurface = Color(0x1A22C55E);
  static const Color categoryShoppingSurface = Color(0x1AEC4899);
  static const Color categoryEmergencySurface = Color(0x1AEF4444);

  // Divider / Border
  static const Color dividerLight = Color(0xFFE5E1F0);
  static const Color dividerDark = Color(0xFF2E2A3E);

  // Scrim
  static const Color scrimLight = Color(0x4D000000);
  static const Color scrimDark = Color(0x80000000);

  // Light mode ColorScheme
  static ColorScheme get lightColorScheme => const ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: Colors.white,
    primaryContainer: Color(0xFFEDE9FE),
    onPrimaryContainer: primaryDeep,
    secondary: secondary,
    onSecondary: Colors.white,
    secondaryContainer: Color(0xFFCCFBF1),
    onSecondaryContainer: secondaryDark,
    tertiary: Color(0xFFEC4899),
    onTertiary: Colors.white,
    tertiaryContainer: Color(0xFFFCE7F3),
    onTertiaryContainer: Color(0xFFBE185D),
    error: error,
    onError: Colors.white,
    errorContainer: Color(0xFFFEE2E2),
    onErrorContainer: errorDark,
    surface: surfaceLight,
    onSurface: textPrimaryLight,
    onSurfaceVariant: textSecondaryLight,
    outline: dividerLight,
    outlineVariant: Color(0xFFF1F0FB),
    shadow: Color(0x1A000000),
    scrim: scrimLight,
    inverseSurface: surfaceDark,
    onInverseSurface: textPrimaryDark,
    inversePrimary: primaryLight,
    surfaceContainerHighest: Color(0xFFE5E1F0),
  );

  // Dark mode ColorScheme
  static ColorScheme get darkColorScheme => const ColorScheme(
    brightness: Brightness.dark,
    primary: primaryLight,
    onPrimary: primaryDeep,
    primaryContainer: primaryDark,
    onPrimaryContainer: Color(0xFFEDE9FE),
    secondary: secondaryLight,
    onSecondary: Color(0xFF003D36),
    secondaryContainer: secondaryDark,
    onSecondaryContainer: Color(0xFFCCFBF1),
    tertiary: Color(0xFFF9A8D4),
    onTertiary: Color(0xFF831843),
    tertiaryContainer: Color(0xFFBE185D),
    onTertiaryContainer: Color(0xFFFCE7F3),
    error: errorLight,
    onError: Color(0xFF7F1D1D),
    errorContainer: errorDark,
    onErrorContainer: Color(0xFFFEE2E2),
    surface: surfaceDark,
    onSurface: textPrimaryDark,
    onSurfaceVariant: textSecondaryDark,
    outline: dividerDark,
    outlineVariant: Color(0xFF1A1726),
    shadow: Color(0x4D000000),
    scrim: scrimDark,
    inverseSurface: surfaceLight,
    onInverseSurface: textPrimaryLight,
    inversePrimary: primaryDark,
    surfaceContainerHighest: Color(0xFF2E2A3E),
  );
}
