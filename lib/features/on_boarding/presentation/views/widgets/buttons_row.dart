import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';

class OnboardingButtonsRow extends StatelessWidget {
  const OnboardingButtonsRow({
    required this.currentIndex,
    required this.totalPages,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final int currentIndex;
  final int totalPages;
  final VoidCallback onNext;
  final VoidCallback onBack;

  bool get _isFirstPage => currentIndex == 0;
  bool get _isLastPage => currentIndex == totalPages - 1;

  @override
  Widget build(BuildContext context) {
    if (_isFirstPage) {
      return SizedBox(
        width: double.infinity,
        height: 52,
        child: ElevatedButton(
          onPressed: onNext,
          style: _elevatedStyle(),
          child: const Text('Next'),
        ),
      );
    }

    return Row(
      children: [
        // Back button
        Expanded(
          child: SizedBox(
            height: 52,
            child: OutlinedButton(
              onPressed: onBack,
              style: _outlinedStyle(),
              child: const Text('Back'),
            ),
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: onNext,
              style: _elevatedStyle(),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: Text(
                  _isLastPage ? 'Do IT' : 'Next',
                  key: ValueKey('btn$currentIndex'),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  ButtonStyle _elevatedStyle() => ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.5,
    ),
  );

  ButtonStyle _outlinedStyle() => OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    side: const BorderSide(color: AppColors.primary, width: 1.5),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
    ),
  );
}
