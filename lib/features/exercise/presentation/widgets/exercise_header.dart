import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/font_manager.dart';
import '../../../../../../core/constants/values_manager.dart';
import 'back_button_widget.dart';
import 'info_pill.dart';

/// Hero section at the top of [ExerciseView]: background image, gradient,
/// back button, and the title/description/stat pills pinned to the bottom.
///
/// All text is passed in as plain strings so this widget doesn't care
/// whether they came from the default placeholder values or from an API
/// response — swap the caller's data source and this widget needs no
/// changes. Pass [isLoading] to show skeleton placeholders instead of text
/// while the real content is being fetched.
class ExerciseHeader extends StatelessWidget {
  const ExerciseHeader({
    super.key,
    required this.title,
    required this.description,
    required this.durationLabel,
    required this.caloriesLabel,
    required this.headerImagePath,
    required this.onBackTap,
    this.isLoading = false,
  });

  final String title;
  final String description;
  final String durationLabel;
  final String caloriesLabel;
  final String headerImagePath;
  final VoidCallback onBackTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final topSafeArea = MediaQuery.paddingOf(context).top;

    return Stack(
      children: [
        Image.asset(
          headerImagePath,
          height: AppSize.s400,
          width: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => Container(
            height: AppSize.s400,
            width: double.infinity,
            color: AppColors.neutral900,
            child: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.white,
              size: AppSize.s40,
            ),
          ),
        ),
        // Gradient overlay for text/icon readability.
        Container(
          height: AppSize.s400,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.black.withValues(alpha: 0.15),
                AppColors.neutral900,
              ],
            ),
          ),
        ),
        // Back button, offset to respect the device safe area.
        Positioned(
          top: topSafeArea + AppPadding.p16,
          left: AppPadding.p16,
          child: BackButtonWidget(onTap: onBackTap),
        ),
        // Title / description / info row, pinned to the bottom.
        Positioned(
          left: AppPadding.p24,
          right: AppPadding.p24,
          bottom: AppPadding.p16,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _HeaderText(
                isLoading: isLoading,
                text: title,
                skeletonWidth: 150,
                skeletonHeight: AppSize.s24,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: FontConstants.balooThambi2,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s30,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              _HeaderText(
                isLoading: isLoading,
                text: description,
                skeletonWidth: double.infinity,
                skeletonHeight: AppSize.s16,
                style: TextStyle(
                  color: AppColors.white.withValues(alpha: 0.82),
                  fontFamily: FontConstants.balooThambi2,
                  fontSize: FontSize.s14,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InfoPill(label: durationLabel, textColor: AppColors.white),
                  InfoPill(label: caloriesLabel, textColor: AppColors.primary),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Shows [text] normally, or a grey skeleton bar while [isLoading] is true.
class _HeaderText extends StatelessWidget {
  const _HeaderText({
    required this.isLoading,
    required this.text,
    required this.skeletonWidth,
    required this.skeletonHeight,
    required this.style,
  });

  final bool isLoading;
  final String text;
  final double skeletonWidth;
  final double skeletonHeight;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Container(
        width: skeletonWidth,
        height: skeletonHeight,
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.15),
          borderRadius: const BorderRadius.all(Radius.circular(6)),
        ),
      );
    }
    return Text(text, style: style);
  }
}
