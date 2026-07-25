import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/values_manager.dart';

/// Animated progress bar loader
class AnimatedProgressBar extends StatelessWidget {

  const AnimatedProgressBar({
    required this.animation, super.key,
    this.width = 160,
    this.height = 3,
    this.color,
  });
  final Animation<double> animation;
  final double width;
  final double height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final barColor = color ?? AppColors.primary;
    final trackOpacity = isDark ? 0.15 : 0.1;
    final glowOpacity = isDark ? 0.7 : 0.5;

    return AnimatedContainer(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height / AppSize.s2),
        color: barColor.withValues(alpha: trackOpacity),
      ),
      duration: const Duration(milliseconds: 300),
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: 0.3,
            child: Transform.translate(
              offset: Offset(width * 0.7 * animation.value, 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(height / AppSize.s2),
                  gradient: LinearGradient(
                    colors: [
                      barColor.withValues(alpha: 0.3),
                      barColor,
                      barColor.withValues(alpha: 0.3),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: barColor.withValues(alpha: glowOpacity),
                      blurRadius: isDark ? 8 : 6,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
