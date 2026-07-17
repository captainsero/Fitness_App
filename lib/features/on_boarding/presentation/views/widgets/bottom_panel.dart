import 'package:flutter/material.dart';

import 'buttons_row.dart';
import 'dot_indicators.dart';
import 'onboarding_data.dart';

class OnboardingBottomPanel extends StatelessWidget {
  const OnboardingBottomPanel({
    required this.pages,
    required this.currentIndex,
    required this.onNext,
    required this.onBack,
    super.key,
  });

  final List<OnboardingData> pages;
  final int currentIndex;
  final VoidCallback onNext;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 24, 24, 36),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.50),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.08),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.15),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: Text(
                pages[currentIndex].title,
                key: ValueKey('title$currentIndex'),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  letterSpacing: 0.5,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 12),

            AnimatedSwitcher(
              duration: const Duration(milliseconds: 350),
              child: Text(
                pages[currentIndex].description,
                key: ValueKey('desc$currentIndex'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.60),
                  fontSize: 13,
                  height: 1.6,
                ),
              ),
            ),

            const SizedBox(height: 24),

            OnboardingDotIndicators(
              totalPages: pages.length,
              currentIndex: currentIndex,
            ),

            const SizedBox(height: 24),

            OnboardingButtonsRow(
              currentIndex: currentIndex,
              totalPages: pages.length,
              onNext: onNext,
              onBack: onBack,
            ),
          ],
        ),
      ),
    );
  }
}
