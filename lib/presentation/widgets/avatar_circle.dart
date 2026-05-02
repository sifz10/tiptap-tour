import 'package:flutter/material.dart';

import 'package:tiptap_tour/presentation/theme/app_colors.dart';

class AvatarCircle extends StatelessWidget {
  final String name;
  final String? imagePath;
  final double size;
  final Color? backgroundColor;

  const AvatarCircle({
    super.key,
    required this.name,
    this.imagePath,
    this.size = 40,
    this.backgroundColor,
  });

  static const _avatarPalette = [
    AppColors.primary,
    AppColors.secondary,
    AppColors.categoryFood,
    AppColors.categoryTransport,
    AppColors.categoryShopping,
    AppColors.categoryActivities,
    AppColors.categoryLodging,
    AppColors.info,
  ];

  Color _colorFromName() {
    final hash = name.codeUnits.fold<int>(0, (sum, c) => sum + c);
    return _avatarPalette[hash % _avatarPalette.length];
  }

  String _initials() {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? _colorFromName();
    final borderColor = Theme.of(context).brightness == Brightness.light
        ? Colors.white
        : AppColors.glassDarkBorder;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: bgColor,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      clipBehavior: Clip.antiAlias,
      child: imagePath != null
          ? Image.asset(
              imagePath!,
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) => _InitialsContent(
                initials: _initials(),
                size: size,
              ),
            )
          : _InitialsContent(
              initials: _initials(),
              size: size,
            ),
    );
  }
}

class _InitialsContent extends StatelessWidget {
  final String initials;
  final double size;

  const _InitialsContent({
    required this.initials,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        initials,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: size * 0.38,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
