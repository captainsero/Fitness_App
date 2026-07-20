import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';

class TopRightDecorativeCircle extends StatelessWidget {
  const TopRightDecorativeCircle({
    required this.pulseController, required this.size, super.key,
  });
  final Animation<double> pulseController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      top: -size.width * 0.3,
      right: -size.width * 0.3,
      child: AnimatedBuilder(
        animation: pulseController,
        builder: (context, child) {
          final scale = 1.0 + (pulseController.value * 0.05);
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: isDark
                      ? [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.primaryDark1.withValues(alpha: 0.05),
                          AppColors.transparent,
                        ]
                      : [
                          AppColors.primaryLight7.withValues(alpha: 0.3),
                          AppColors.primaryLight9.withValues(alpha: 0.1),
                          AppColors.transparent,
                        ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BottomLeftDecorativeCircle extends StatelessWidget {
  const BottomLeftDecorativeCircle({
    required this.pulseController, required this.size, super.key,
  });
  final Animation<double> pulseController;
  final Size size;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Positioned(
      bottom: -size.width * 0.25,
      left: -size.width * 0.25,
      child: AnimatedBuilder(
        animation: pulseController,
        builder: (context, child) {
          final scale = 1.0 + ((1 - pulseController.value) * 0.05);
          return Transform.scale(
            scale: scale,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: isDark
                      ? [
                          AppColors.primary.withValues(alpha: 0.15),
                          AppColors.primaryDark1.withValues(alpha: 0.05),
                          AppColors.transparent,
                        ]
                      : [
                          AppColors.primaryLight7.withValues(alpha: 0.3),
                          AppColors.primaryLight9.withValues(alpha: 0.1),
                          AppColors.transparent,
                        ],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
