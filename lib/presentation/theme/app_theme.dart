import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tiptap_tour/presentation/theme/app_colors.dart';
import 'package:tiptap_tour/presentation/theme/app_typography.dart';
import 'package:tiptap_tour/presentation/theme/glass_theme.dart';

abstract final class AppTheme {
  static ThemeData get light {
    final colorScheme = AppColors.lightColorScheme;
    final textTheme = AppTypography.lightTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.surfaceLight,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryLight,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimaryLight,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white.withAlpha(230),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiaryLight,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
        unselectedLabelStyle: textTheme.labelSmall,
        showUnselectedLabels: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white.withAlpha(230),
        elevation: 0,
        indicatorColor: AppColors.primary.withAlpha(31),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textTertiaryLight);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primary,
            );
          }
          return textTheme.labelSmall;
        }),
      ),
      cardTheme: CardThemeData(
        color: Colors.white.withAlpha((GlassTheme.surfaceOpacityLight * 255).round()),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadius),
          side: BorderSide(
            color: Colors.white.withAlpha((GlassTheme.borderOpacityLight * 255).round()),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceLight,
        modalBackgroundColor: AppColors.surfaceLight,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(GlassTheme.borderRadiusLarge),
          ),
        ),
        dragHandleColor: AppColors.dividerLight,
        dragHandleSize: const Size(40, 4),
        showDragHandle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          side: const BorderSide(color: AppColors.dividerLight),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white.withAlpha(179),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.dividerLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.dividerLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiaryLight,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondaryLight,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceLightAlt,
        selectedColor: AppColors.primary.withAlpha(31),
        disabledColor: AppColors.surfaceLightAlt,
        labelStyle: textTheme.labelMedium!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceLight,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusLarge),
        ),
      ),
    );
  }

  static ThemeData get dark {
    final colorScheme = AppColors.darkColorScheme;
    final textTheme = AppTypography.darkTextTheme;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: AppColors.surfaceDark,
      splashFactory: InkSparkle.splashFactory,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          color: AppColors.textPrimaryDark,
        ),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimaryDark,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark.withAlpha(230),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primaryLight,
        unselectedItemColor: AppColors.textTertiaryDark,
        selectedLabelStyle: textTheme.labelSmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppColors.primaryLight,
        ),
        unselectedLabelStyle: textTheme.labelSmall,
        showUnselectedLabels: true,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark.withAlpha(230),
        elevation: 0,
        indicatorColor: AppColors.primaryLight.withAlpha(31),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryLight);
          }
          return const IconThemeData(color: AppColors.textTertiaryDark);
        }),
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            );
          }
          return textTheme.labelSmall;
        }),
      ),
      cardTheme: CardThemeData(
        color: AppColors.surfaceDarkAlt.withAlpha((GlassTheme.surfaceOpacityDark * 255).round()),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadius),
          side: BorderSide(
            color: Colors.white.withAlpha((GlassTheme.borderOpacityDark * 255).round()),
          ),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDarkAlt,
        modalBackgroundColor: AppColors.surfaceDarkAlt,
        elevation: 0,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(GlassTheme.borderRadiusLarge),
          ),
        ),
        dragHandleColor: AppColors.dividerDark,
        dragHandleSize: const Size(40, 4),
        showDragHandle: true,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryLight,
        foregroundColor: AppColors.primaryDeep,
        elevation: 4,
        highlightElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadius),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryLight,
          foregroundColor: AppColors.primaryDeep,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          side: const BorderSide(color: AppColors.dividerDark),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryLight,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          ),
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceDarkElevated.withAlpha(179),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.dividerDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.dividerDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.primaryLight, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        hintStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textTertiaryDark,
        ),
        labelStyle: textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondaryDark,
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceDarkElevated,
        selectedColor: AppColors.primaryLight.withAlpha(31),
        disabledColor: AppColors.surfaceDarkElevated,
        labelStyle: textTheme.labelMedium!,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusSmall),
        ),
        side: BorderSide.none,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceDarkAlt,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(GlassTheme.borderRadiusLarge),
        ),
      ),
    );
  }
}
