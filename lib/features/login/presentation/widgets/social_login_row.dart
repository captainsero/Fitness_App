import 'package:flutter/material.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/values_manager.dart';

class SocialLoginRow extends StatelessWidget {
  const SocialLoginRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SocialIconButton(assetPath: AssetsConst.facebookIcon, onTap: () {}),
        const SizedBox(width: AppSize.s20),
        _SocialIconButton(assetPath: AssetsConst.googleIcon, onTap: () {}),
        const SizedBox(width: AppSize.s20),
        _SocialIconButton(assetPath: AssetsConst.appleIcon, onTap: () {}),
      ],
    );
  }
}

class _SocialIconButton extends StatelessWidget {
  const _SocialIconButton({required this.assetPath, required this.onTap});

  final String assetPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: AppSize.s40,
        height: AppSize.s40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.neutral800,
          shape: BoxShape.circle,
        ),
        child: ClipOval(
          child: Image.asset(
            assetPath,
            width: AppSize.s24,
            height: AppSize.s24,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => const Icon(
              Icons.error_outline,
              size: AppSize.s16,
              color: AppColors.neutral400,
            ),
          ),
        ),
      ),
    );
  }
}
