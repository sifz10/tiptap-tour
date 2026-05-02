import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:tiptap_tour/presentation/theme/app_colors.dart';

abstract final class GlassTheme {
  static const double blurSigma = 24.0;
  static const double blurSigmaLight = 16.0;
  static const double blurSigmaHeavy = 40.0;

  static const double surfaceOpacityLight = 0.72;
  static const double surfaceOpacityDark = 0.55;

  static const double borderOpacityLight = 0.25;
  static const double borderOpacityDark = 0.12;

  static const double borderWidth = 1.0;
  static const double borderRadius = 20.0;
  static const double borderRadiusSmall = 12.0;
  static const double borderRadiusLarge = 28.0;

  static BoxDecoration lightGlass({
    double? radius,
    double? opacity,
    double? borderOpacity,
  }) {
    final r = radius ?? borderRadius;
    final surfaceAlpha = ((opacity ?? surfaceOpacityLight) * 255).round();
    final edgeAlpha = ((borderOpacity ?? borderOpacityLight) * 255).round();

    return BoxDecoration(
      color: Colors.white.withAlpha(surfaceAlpha),
      borderRadius: BorderRadius.circular(r),
      border: Border.all(
        color: Colors.white.withAlpha(edgeAlpha),
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: AppColors.primary.withAlpha(13),
          blurRadius: 24,
          offset: const Offset(0, 8),
          spreadRadius: -4,
        ),
        BoxShadow(
          color: Colors.black.withAlpha(8),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration darkGlass({
    double? radius,
    double? opacity,
    double? borderOpacity,
  }) {
    final r = radius ?? borderRadius;
    final surfaceAlpha = ((opacity ?? surfaceOpacityDark) * 255).round();
    final edgeAlpha = ((borderOpacity ?? borderOpacityDark) * 255).round();

    return BoxDecoration(
      color: AppColors.surfaceDarkAlt.withAlpha(surfaceAlpha),
      borderRadius: BorderRadius.circular(r),
      border: Border.all(
        color: Colors.white.withAlpha(edgeAlpha),
        width: borderWidth,
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withAlpha(51),
          blurRadius: 32,
          offset: const Offset(0, 12),
          spreadRadius: -8,
        ),
        BoxShadow(
          color: AppColors.primary.withAlpha(10),
          blurRadius: 20,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }

  static BoxDecoration glass({
    required Brightness brightness,
    double? radius,
    double? opacity,
    double? borderOpacity,
  }) {
    return brightness == Brightness.light
        ? lightGlass(
            radius: radius,
            opacity: opacity,
            borderOpacity: borderOpacity,
          )
        : darkGlass(
            radius: radius,
            opacity: opacity,
            borderOpacity: borderOpacity,
          );
  }

  static BoxDecoration accentGlass({
    required Brightness brightness,
    double? radius,
  }) {
    final r = radius ?? borderRadius;

    return BoxDecoration(
      gradient: LinearGradient(
        colors: brightness == Brightness.light
            ? [
                AppColors.primary.withAlpha(20),
                AppColors.secondary.withAlpha(13),
              ]
            : [
                AppColors.primary.withAlpha(38),
                AppColors.secondary.withAlpha(25),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(r),
      border: Border.all(
        color: AppColors.primary.withAlpha(
          brightness == Brightness.light ? 51 : 38,
        ),
        width: borderWidth,
      ),
    );
  }

  static double sigmaForBrightness(Brightness brightness) {
    return brightness == Brightness.light ? blurSigma : blurSigmaHeavy;
  }

  static ImageFilter blurFilter({Brightness brightness = Brightness.light}) {
    final sigma = sigmaForBrightness(brightness);
    return ImageFilter.blur(sigmaX: sigma, sigmaY: sigma);
  }
}
