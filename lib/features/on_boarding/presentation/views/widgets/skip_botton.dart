import 'package:flutter/material.dart';

class OnboardingSkipButton extends StatelessWidget {
  const OnboardingSkipButton({
    required this.currentIndex,
    required this.totalPages,
    required this.onSkip,
    super.key,
  });

  final int currentIndex;
  final int totalPages;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= totalPages - 1) return const SizedBox.shrink();

    return Positioned(
      top: 48,
      right: 20,
      child: TextButton(
        onPressed: onSkip,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
        child: const Text(
          'Skip',
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
