import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../generated/l10n.dart';

class Slogan extends StatelessWidget {
  const Slogan({required this.textOpacity, required this.textSlide, super.key});
  final Animation<double> textOpacity;
  final Animation<Offset> textSlide;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor = isDark ? AppColors.neutral300 : AppColors.neutral500;
    final sloganBackground = isDark
        ? AppColors.neutral900.withValues(alpha: 0.5)
        : AppColors.primaryLight9;
    final sloganBorder = isDark
        ? AppColors.primary.withValues(alpha: 0.2)
        : AppColors.primaryLight7;

    return SlideTransition(
      position: textSlide,
      child: FadeTransition(
        opacity: textOpacity,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p20,
            vertical: AppPadding.p12,
          ),
          margin: const EdgeInsets.symmetric(horizontal: AppMargin.m20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(RadiusSize.r30),
            color: sloganBackground,
            border: Border.all(color: sloganBorder),
          ),
          child: Text(
            S.of(context).your_fitness_journey_starts_here,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: subtitleColor,
              height: 1.5,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ),
    );
  }
}
