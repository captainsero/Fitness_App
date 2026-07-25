import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/values_manager.dart';
import '../../domain/entities/exercise_entity.dart';
import 'exercise_row.dart';
import 'state_placeholders.dart';

class ExerciseListSection extends StatelessWidget {
  const ExerciseListSection({
    super.key,
    required this.exercises,
    required this.onExerciseTap,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.emptyMessage = 'No exercises found',
  });

  final List<ExerciseEntity> exercises;
  final void Function(ExerciseEntity item, int index) onExerciseTap;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p24),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.neutral900.withValues(alpha: 0.8),
          borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r20)),
        ),
        padding: const EdgeInsets.all(AppPadding.p16),
        child: _buildContent(context),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    if (isLoading) {
      return const LoadingStateWidget();
    }
    if (errorMessage != null) {
      return ErrorStateWidget(message: errorMessage!, onRetry: onRetry ?? () {});
    }
    if (exercises.isEmpty) {
      return EmptyStateWidget(label: emptyMessage);
    }
    return Column(
      children: [
        for (var index = 0; index < exercises.length; index++) ...[
          if (index != 0) ...[
            const SizedBox(height: AppSize.s16),
            Divider(
              height: 1,
              thickness: 1,
              color: AppColors.white.withValues(alpha: 0.12),
            ),
            const SizedBox(height: AppSize.s16),
          ],
          ExerciseRow(
            item: exercises[index],
            onPlayTap: () => onExerciseTap(exercises[index], index),
          ),
        ],
      ],
    );
  }
}