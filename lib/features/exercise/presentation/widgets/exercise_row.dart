import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/font_manager.dart';
import '../../../../../../core/constants/values_manager.dart';
import '../models/exercise_item.dart';

/// A single row inside the exercise list: thumbnail, title/sets/description,
/// and a play button.
class ExerciseRow extends StatelessWidget {
  const ExerciseRow({super.key, required this.item, required this.onPlayTap});

  final ExerciseItem item;
  final VoidCallback onPlayTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r20)),
          child: Image.asset(
            item.imagePath,
            height: AppSize.s80,
            width: AppSize.s80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              height: AppSize.s80,
              width: AppSize.s80,
              color: AppColors.neutral900,
              child: const Icon(
                Icons.image_not_supported_rounded,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSize.s16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: FontConstants.balooThambi2,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s18,
                ),
              ),
              const SizedBox(height: AppSize.s4),
              Text(
                item.sets,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: FontConstants.balooThambi2,
                  fontSize: FontSize.s12,
                ),
              ),
              Text(
                item.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: FontConstants.balooThambi2,
                  fontSize: FontSize.s12,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppSize.s12),
        Semantics(
          button: true,
          label: 'Play ${item.title}',
          child: GestureDetector(
            onTap: onPlayTap,
            child: Container(
              height: AppSize.s24,
              width: AppSize.s24,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.play_arrow_rounded,
                color: AppColors.black,
                size: AppSize.s24,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
