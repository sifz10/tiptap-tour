import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:tiptap_tour/presentation/theme/glass_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final double? radius;
  final VoidCallback? onTap;
  final bool useAccentGlass;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.radius,
    this.onTap,
    this.useAccentGlass = false,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final r = radius ?? GlassTheme.borderRadius;
    final sigma = GlassTheme.sigmaForBrightness(brightness);

    final decoration = useAccentGlass
        ? GlassTheme.accentGlass(brightness: brightness, radius: r)
        : GlassTheme.glass(brightness: brightness, radius: r);

    Widget content = Padding(
      padding: padding ?? const EdgeInsets.all(16),
      child: child,
    );

    if (onTap != null) {
      content = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(r),
        child: content,
      );
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: sigma, sigmaY: sigma),
        child: DecoratedBox(
          decoration: decoration,
          child: content,
        ),
      ),
    );
  }
}
