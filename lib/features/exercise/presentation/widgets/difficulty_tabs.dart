import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/font_manager.dart';
import '../../../../../../core/constants/values_manager.dart';
import '../../domain/entities/difficulty_level_entity.dart';

/// Horizontally scrollable row of difficulty-level tabs, built from
/// whatever the API returns (currently 7 levels), instead of a fixed
/// 3-value enum. Reports selection through [onChanged] with the tapped
/// level's id.
class DifficultyTabs extends StatelessWidget {
  const DifficultyTabs({
    super.key,
    required this.levels,
    required this.selectedId,
    required this.onChanged,
  });

  final List<DifficultyLevelEntity> levels;
  final String? selectedId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.neutral900.withValues(alpha: 0.9),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(RadiusSize.r20),
          bottomRight: Radius.circular(RadiusSize.r20),
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p4),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
        child: Row(
          children: levels.map((level) {
            final isSelected = level.id == selectedId;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p4),
              child: GestureDetector(
                onTap: () {
                  if (!isSelected) onChanged(level.id);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppPadding.p16,
                    vertical: AppPadding.p8,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(RadiusSize.r20),
                    ),
                  ),
                  child: Text(
                    level.name,
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