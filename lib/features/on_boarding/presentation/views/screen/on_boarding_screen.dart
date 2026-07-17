import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../widgets/background.dart';
import '../widgets/bottom_panel.dart';
import '../widgets/onboarding_data.dart';
import '../widgets/page_view.dart';
import '../widgets/skip_botton.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  List<OnboardingData> get _pages => [
    OnboardingData(
      title: S.of(context).onboarding_title_1,
      description: S.of(context).onboarding_description,
      imagePath: AssetsConst.onBoardingImage1,
    ),
    OnboardingData(
      title: S.of(context).onboarding_title_2,
      description: S.of(context).onboarding_description,
      imagePath: AssetsConst.onBoardingImage2,
    ),
    OnboardingData(
      title: S.of(context).onboarding_title_3,
      description: S.of(context).onboarding_description,
      imagePath: AssetsConst.onBoardingImage3,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _onNext() async {
    if (_currentIndex < _pages.length - 1) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(RoutePath.exploreRoute);
    }
  }

  Future<void> _onBack() async {
    if (_currentIndex > 0) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToExplore() {
    context.go(RoutePath.exploreRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const OnboardingBackground(),

          OnboardingPageView(
            pages: _pages,
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
          ),

          OnboardingSkipButton(
            currentIndex: _currentIndex,
            totalPages: _pages.length,
            onSkip: _navigateToExplore,
          ),

          OnboardingBottomPanel(
            pages: _pages,
            currentIndex: _currentIndex,
            onNext: _onNext,
            onBack: _onBack,
          ),
        ],
      ),
    );
  }
}
