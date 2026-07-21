import 'package:flutter/material.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../generated/l10n.dart';

class NoVideoPlaceholder extends StatelessWidget {
  const NoVideoPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.primary),
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.videocam_off_outlined,
              color: AppColors.primary,
              size: 42,
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).noVideoForThisRecipe,
              style: const TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
