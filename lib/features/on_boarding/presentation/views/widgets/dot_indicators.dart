import 'package:flutter/material.dart';
import '../../../../../core/constants/color_manager.dart';

class OnboardingDotIndicators extends StatelessWidget {
  const OnboardingDotIndicators({
    required this.totalPages,
    required this.currentIndex,
    super.key,
  });

  final int totalPages;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (i) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentIndex == i ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentIndex == i
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.35),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
