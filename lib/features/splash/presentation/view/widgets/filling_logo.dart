import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/values_manager.dart';

class FillingLogo extends StatelessWidget {
  const FillingLogo({
    required this.fillController, required this.fillAnimation, required this.shimmerController, super.key,
  });

  final AnimationController fillController;
  final Animation<double> fillAnimation;
  final AnimationController shimmerController;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final logoBackgroundColor = isDark
        ? AppColors.neutral900
        : AppColors.white;

    return AnimatedBuilder(
      animation: fillController,
      builder: (context, child) {
        return Container(
          width: 160,
          height: 160,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: logoBackgroundColor,
          ),
          child: Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.s20),
              child: Container(
                width: 100,
                height: 100,
                color: AppColors.white,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Full colored logo
                    Image.asset(
                      AssetsConst.logo,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                    // Shimmer overlay for animation effect
                    AnimatedBuilder(
                      animation: shimmerController,
                      builder: (context, child) {
                        return ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.transparent,
                                Colors.white.withValues(alpha: 0.3),
                                Colors.transparent,
                              ],
                              stops: [
                                shimmerController.value - 0.3,
                                shimmerController.value,
                                shimmerController.value + 0.3,
                              ].map((e) => e.clamp(0.0, 1.0)).toList(),
                            ).createShader(bounds);
                          },
                          blendMode: BlendMode.srcATop,
                          child: Image.asset(
                            AssetsConst.logo,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
