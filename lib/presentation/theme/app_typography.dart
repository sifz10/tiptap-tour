import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:tiptap_tour/presentation/theme/app_colors.dart';

abstract final class AppTypography {
  static String get _headingFamily => GoogleFonts.spaceGrotesk().fontFamily!;
  static String get _bodyFamily => GoogleFonts.plusJakartaSans().fontFamily!;

  static TextTheme get lightTextTheme => _buildTextTheme(
    headingColor: AppColors.textPrimaryLight,
    bodyColor: AppColors.textPrimaryLight,
    secondaryColor: AppColors.textSecondaryLight,
  );

  static TextTheme get darkTextTheme => _buildTextTheme(
    headingColor: AppColors.textPrimaryDark,
    bodyColor: AppColors.textPrimaryDark,
    secondaryColor: AppColors.textSecondaryDark,
  );

  static TextTheme _buildTextTheme({
    required Color headingColor,
    required Color bodyColor,
    required Color secondaryColor,
  }) {
    return TextTheme(
      displayLarge: TextStyle(
        fontFamily: _headingFamily,
        fontSize: 40,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.5,
        height: 1.15,
        color: headingColor,
      ),
      displayMedium: TextStyle(
        fontFamily: _headingFamily,
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: -1.0,
        height: 1.2,
        color: headingColor,
      ),
      displaySmall: TextStyle(
        fontFamily: _headingFamily,
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.5,
        height: 1.22,
        color: headingColor,
      ),
      headlineLarge: TextStyle(
        fontFamily: _headingFamily,
        fontSize: 24,
        fontWeight: FontWeight.w700,
        letterSpacing: -0.5,
        height: 1.25,
        color: headingColor,
      ),
      headlineMedium: TextStyle(
        fontFamily: _headingFamily,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
        height: 1.3,
        color: headingColor,
      ),
      headlineSmall: TextStyle(
        fontFamily: _headingFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.33,
        color: headingColor,
      ),
      titleLarge: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
        color: headingColor,
      ),
      titleMedium: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.38,
        color: headingColor,
      ),
      titleSmall: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
        color: headingColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.5,
        color: bodyColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.43,
        color: bodyColor,
      ),
      bodySmall: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.2,
        height: 1.33,
        color: secondaryColor,
      ),
      labelLarge: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.1,
        height: 1.43,
        color: bodyColor,
      ),
      labelMedium: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
        height: 1.33,
        color: bodyColor,
      ),
      labelSmall: TextStyle(
        fontFamily: _bodyFamily,
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
        color: secondaryColor,
      ),
    );
  }

  static TextStyle currencyDisplay({
    Color? color,
    double fontSize = 32,
  }) {
    return TextStyle(
      fontFamily: _headingFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.15,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }

  static TextStyle currencyBody({
    Color? color,
    double fontSize = 16,
  }) {
    return TextStyle(
      fontFamily: _bodyFamily,
      fontSize: fontSize,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.25,
      color: color,
      fontFeatures: const [FontFeature.tabularFigures()],
    );
  }
}
