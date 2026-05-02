import 'package:flutter/animation.dart';

abstract final class AppAnimations {
  static const Duration fast = Duration(milliseconds: 200);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
  static const Duration pageTransition = Duration(milliseconds: 400);
  static const Duration shimmer = Duration(milliseconds: 1500);

  static const Curve springLike = Curves.easeOutQuint;
  static const Curve smooth = Curves.easeInOutCubic;
  static const Curve decelerate = Curves.decelerate;
  static const Curve snappy = Curves.easeOutCubic;
  static const Curve entrance = Curves.easeOutBack;

  static const Duration staggerDelay = Duration(milliseconds: 50);

  static Duration staggerFor(int index) {
    return staggerDelay * index;
  }

  static const double slideEnterOffset = 0.15;
  static const double slideExitOffset = -0.10;
  static const double slideUpOffset = 0.08;

  static const Offset enterFromRight = Offset(slideEnterOffset, 0);
  static const Offset enterFromLeft = Offset(-slideEnterOffset, 0);
  static const Offset enterFromBottom = Offset(0, slideEnterOffset);
  static const Offset enterFromTop = Offset(0, -slideEnterOffset);
  static const Offset exitToLeft = Offset(slideExitOffset, 0);
  static const Offset exitToRight = Offset(-slideExitOffset, 0);

  static const double fadeEnterBegin = 0.0;
  static const double fadeEnterEnd = 1.0;

  static const double scaleEnterBegin = 0.92;
  static const double scaleEnterEnd = 1.0;
}
