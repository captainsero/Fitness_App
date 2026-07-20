import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../core/shared_widgets/blurred_background.dart';
import '../models/exercise_item.dart';
import '../widgets/difficulty_tabs.dart';
import '../widgets/exercise_header.dart';
import '../widgets/exercise_list_section.dart';

/// Exercise detail page: hero header, difficulty tabs, and a list of
/// exercises for the selected difficulty.
///
/// Data currently comes from the [exercises] constructor parameter
/// (defaulted to placeholder content below), but the widget is shaped so
/// swapping that for a real API-backed source is a small, local change:
///
/// 1. Wrap this widget in a bloc/provider/riverpod consumer that fetches
///    exercises for the given `exerciseId` / muscle group.
/// 2. Pass the fetched `List<ExerciseItem>` (via [ExerciseItem.fromJson])
///    into [exercises], and forward the request's loading/error state into
///    [isLoading] / [errorMessage] / [onRetry].
/// 3. Nothing else in this file, or in the split-out widgets, needs to
///    change — they don't know or care where the data came from.
class ExerciseView extends StatefulWidget {
  const ExerciseView({
    super.key,
    this.title = 'Chest Exercise',
    this.description =
        'Lorem Ipsum Dolor Sit Amet Consectetur. Tempus Volutpat Ut Nisi Morbi.',
    this.durationLabel = '30 MIN',
    this.caloriesLabel = '130 Cal',
    this.headerImagePath =
        'assets/images/Handsome man working push ups at the gym. sport exercises.png',
    this.exercises = const [
      ExerciseItem(
        title: 'Bench press',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        difficulty: ExerciseDifficulty.advanced,
        imagePath:
            'assets/images/Handsome man working push ups at the gym. sport exercises.png',
        sets: '3 groups * 15 times',
      ),
      ExerciseItem(
        title: 'Bench press',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        difficulty: ExerciseDifficulty.advanced,
        imagePath:
            'assets/images/Handsome man working push ups at the gym. sport exercises.png',
        sets: '3 groups * 15 times',
      ),
      ExerciseItem(
        title: 'Bench press',
        description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
        difficulty: ExerciseDifficulty.advanced,
        imagePath:
            'assets/images/Handsome man working push ups at the gym. sport exercises.png',
        sets: '3 groups * 15 times',
      ),
    ],
    this.onBackTap,
    this.onDifficultyChanged,
    this.onExerciseTap,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
  });

  final String title;
  final String description;
  final String durationLabel;
  final String caloriesLabel;
  final String headerImagePath;
  final List<ExerciseItem> exercises;

  final VoidCallback? onBackTap;
  final ValueChanged<ExerciseDifficulty>? onDifficultyChanged;
  final void Function(ExerciseItem item, int index)? onExerciseTap;
  final bool isLoading;
  final String? errorMessage;

  final VoidCallback? onRetry;

  @override
  State<ExerciseView> createState() => _ExerciseViewState();
}

class _ExerciseViewState extends State<ExerciseView> {
  ExerciseDifficulty _selected = ExerciseDifficulty.beginner;

  List<ExerciseItem> get _filteredExercises => widget.exercises
      .where((e) => e.difficulty == _selected)
      .toList(growable: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BlurredBackground(),
          CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: ExerciseHeader(
                  title: widget.title,
                  description: widget.description,
                  durationLabel: widget.durationLabel,
                  caloriesLabel: widget.caloriesLabel,
                  headerImagePath: widget.headerImagePath,
                  onBackTap: widget.onBackTap ?? () => context.pop(),
                ),
              ),
              SliverToBoxAdapter(
                child: DifficultyTabs(
                  selected: _selected,
                  onChanged: (difficulty) {
                    setState(() => _selected = difficulty);
                    widget.onDifficultyChanged?.call(difficulty);
                  },
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSize.s8)),
              SliverToBoxAdapter(
                child: ExerciseListSection(
                  exercises: _filteredExercises,
                  isLoading: widget.isLoading,
                  errorMessage: widget.errorMessage,
                  onRetry: widget.onRetry,
                  onExerciseTap: (item, index) =>
                      widget.onExerciseTap?.call(item, index),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: AppSize.s24)),
            ],
          ),
        ],
      ),
    );
  }
}
