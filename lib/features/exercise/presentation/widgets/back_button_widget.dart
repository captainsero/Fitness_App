import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/values_manager.dart';

/// Small circular back button rendered on top of the header image.
class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Back',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: AppSize.s24,
          width: AppSize.s24,
          decoration: const BoxDecoration(
            color: AppColors.primary,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.white,
            size: AppSize.s14,
          ),
        ),
      ),
    );
  }
}
