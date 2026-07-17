import 'package:flutter/material.dart';

import '../../../../../core/constants/values_manager.dart';

class OnboardingBackground extends StatelessWidget {
  const OnboardingBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetsConst.onBoardingBackGround,
      height: double.infinity,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }
}
