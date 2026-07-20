import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/font_manager.dart';
import '../../../../../../core/constants/values_manager.dart';
import '../../../../../../generated/l10n.dart';
import '../models/exercise_item.dart';

/// Row of tappable difficulty tabs. Purely presentational — it reports
/// selection changes through [onChanged] and lets the parent decide what
/// that means for the data (e.g. re-filtering a local list today, or
/// triggering a new API request with a `difficulty` query param later).
class DifficultyTabs extends StatelessWidget {
  const DifficultyTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final ExerciseDifficulty selected;
  final ValueChanged<ExerciseDifficulty> onChanged;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral900.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(RadiusSize.r20),
          bottomRight: Radius.circular(RadiusSize.r20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p24,
          vertical: AppPadding.p4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ExerciseDifficulty.values.map((difficulty) {
            final isSelected = difficulty == selected;
            final label = switch (difficulty) {
              ExerciseDifficulty.beginner => s.beginner,
              ExerciseDifficulty.intermediate => s.intermediate,
              ExerciseDifficulty.advanced => s.advanced,
            };

            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (!isSelected) onChanged(difficulty);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
                  padding: const EdgeInsets.all(AppPadding.p8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(RadiusSize.r20),
                    ),
                  ),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.white,
                      fontFamily: FontConstants.balooThambi2,
                      fontWeight: isSelected
                          ? FontWeightManager.bold
                          : FontWeightManager.medium,
                      fontSize: FontSize.s14,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
