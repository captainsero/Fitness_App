import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../generated/l10n.dart';

class AppName extends StatelessWidget {
  const AppName({
    required this.titleOpacity, required this.titleSlide, super.key,
  });
  final Animation<double> titleOpacity;
  final Animation<Offset> titleSlide;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SlideTransition(
      position: titleSlide,
      child: FadeTransition(
        opacity: titleOpacity,
        child: ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                AppColors.primary,
                AppColors.primary.withValues(alpha: 0.8),
                AppColors.primary,
              ],
            ).createShader(bounds);
          },
          child: Text(
            S.of(context).fitnessApp,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: AppColors.white,
              shadows: [
                Shadow(
                  color: isDark ? Colors.black26 : Colors.black12,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
