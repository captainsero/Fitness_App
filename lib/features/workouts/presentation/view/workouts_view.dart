import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/di.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../core/router/route_path.dart';
import '../../../../core/shared_widgets/blurred_background.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';
import '../../../../generated/l10n.dart';
import '../../domain/entities/muscle_entity.dart';
import '../view_model/workouts_cubit.dart';
import '../view_model/workouts_state.dart';

class WorkoutsView extends StatelessWidget {
  const WorkoutsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<WorkoutsCubit>()..loadCategories(),
      child: const _WorkoutsView(),
    );
  }
}

class _WorkoutsView extends StatelessWidget {
  const _WorkoutsView();

  /// Cards are tappable -- navigates to the exercises screen for the
  /// tapped muscle, passing its id as the required `primeMoverMuscleId`.
  void _onMuscleTap(BuildContext context, MuscleEntity muscle) {
    final id = muscle.id;
    if (id == null || id.isEmpty) return;
    context.push(RoutePath.exerciseView, extra: id);
  }

  void _onTabTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RoutePath.exploreRoute); // adjust to your actual constant
      case 1:
        context.go(RoutePath.smartCouchRoute); // adjust to your actual constant
      case 2:
        context.go(RoutePath.workoutsRoute); // adjust to your actual constant
      case 3:
        context.go(RoutePath.profileRoute); // adjust to your actual constant
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const BlurredBackground(),
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: AppSize.s24),
                Text(
                  s.workouts,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontFamily: FontConstants.balooThambi2,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s24,
                  ),
                ),
                const SizedBox(height: AppSize.s20),
                BlocBuilder<WorkoutsCubit, WorkoutsState>(
                  buildWhen: (previous, current) =>
                  previous.categories != current.categories ||
                      previous.selectedCategoryIndex !=
                          current.selectedCategoryIndex ||
                      previous.isLoadingCategories !=
                          current.isLoadingCategories ||
                      previous.categoriesErrorMessage !=
                          current.categoriesErrorMessage,
                  builder: (context, state) {
                    if (state.isLoadingCategories) {
                      return const SizedBox(
                        height: AppSize.s40,
                        child: Center(
                          child: SizedBox(
                            width: AppSize.s20,
                            height: AppSize.s20,
                            child: CircularProgressIndicator(
                              strokeWidth: AppSize.s2,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state.categoriesErrorMessage != null) {
                      return SizedBox(
                        height: AppSize.s40,
                        child: Center(
                          child: TextButton(
                            onPressed: () => context
                                .read<WorkoutsCubit>()
                                .loadCategories(),
                            child: Text(
                              s.retry,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontFamily: FontConstants.balooThambi2,
                                fontWeight: FontWeightManager.bold,
                                fontSize: FontSize.s14,
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    return SizedBox(
                      height: AppSize.s40,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p20,
                        ),
                        itemCount: state.categories.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSize.s16),
                        itemBuilder: (context, index) {
                          return _CategoryChip(
                            label: state.categories[index].name,
                            isSelected: index == state.selectedCategoryIndex,
                            onTap: () => context
                                .read<WorkoutsCubit>()
                                .selectCategory(index),
                          );
                        },
                      ),
                    );
                  },
                ),
                const SizedBox(height: AppSize.s16),
                Expanded(
                  child: BlocBuilder<WorkoutsCubit, WorkoutsState>(
                    buildWhen: (previous, current) =>
                    previous.muscles != current.muscles ||
                        previous.isLoadingMuscles !=
                            current.isLoadingMuscles ||
                        previous.musclesErrorMessage !=
                            current.musclesErrorMessage,
                    builder: (context, state) {
                      if (state.isLoadingMuscles) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primary,
                          ),
                        );
                      }

                      if (state.musclesErrorMessage != null) {
                        return _ErrorView(
                          message: state.musclesErrorMessage!,
                          onRetry: () =>
                              context.read<WorkoutsCubit>().retryMuscles(),
                        );
                      }

                      final muscles = state.muscles;

                      if (muscles.isEmpty) {
                        return Center(
                          child: Text(
                            s.noMusclesFound,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontFamily: FontConstants.balooThambi2,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        );
                      }

                      return GridView.builder(
                        padding: const EdgeInsets.fromLTRB(
                          AppPadding.p20,
                          0,
                          AppPadding.p20,
                          AppPadding.p20,
                        ),
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: AppSize.s12,
                          mainAxisSpacing: AppSize.s12,
                          childAspectRatio: 0.85,
                        ),
                        itemCount: muscles.length,
                        itemBuilder: (context, index) {
                          final muscle = muscles[index];
                          return _MuscleCard(
                            muscle: muscle,
                            onTap: () => _onMuscleTap(context, muscle),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2, // Workouts is tab index 2
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  const _CategoryChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r100)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: isSelected ? AppPadding.p16 : AppPadding.p4,
          vertical: AppPadding.p8,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: const BorderRadius.all(
            Radius.circular(RadiusSize.r100),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color:
            isSelected ? AppColors.white : AppColors.white.withAlpha(190),
            fontFamily: FontConstants.balooThambi2,
            fontWeight: isSelected
                ? FontWeightManager.bold
                : FontWeightManager.regular,
            fontSize: FontSize.s14,
          ),
        ),
      ),
    );
  }
}

class _MuscleCard extends StatelessWidget {
  const _MuscleCard({required this.muscle, required this.onTap});

  final MuscleEntity muscle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final imageUrl = muscle.imageUrl;

    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r20)),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r20)),
        child: ColoredBox(
          color: AppColors.neutral900,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (imageUrl != null && imageUrl.isNotEmpty)
                Image.network(
                  imageUrl,
                  fit: BoxFit.contain,
                  alignment: Alignment.center,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(
                      child: SizedBox(
                        width: AppSize.s24,
                        height: AppSize.s24,
                        child: CircularProgressIndicator(
                          strokeWidth: AppSize.s2,
                          color: AppColors.primary,
                        ),
                      ),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) =>
                  const _MuscleCardFallbackIcon(),
                )
              else
                const _MuscleCardFallbackIcon(),
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black87],
                    stops: [0.55, 1],
                  ),
                ),
              ),
              Positioned(
                left: AppPadding.p12,
                right: AppPadding.p12,
                bottom: AppPadding.p16,
                child: Text(
                  muscle.name,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontFamily: FontConstants.balooThambi2,
                    fontWeight: FontWeightManager.bold,
                    fontSize: FontSize.s16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MuscleCardFallbackIcon extends StatelessWidget {
  const _MuscleCardFallbackIcon();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.fitness_center,
        color: AppColors.neutral300,
        size: AppSize.s40,
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppColors.white,
                fontFamily: FontConstants.balooThambi2,
                fontSize: FontSize.s14,
              ),
            ),
            const SizedBox(height: AppSize.s16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(RadiusSize.r100),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p24,
                  vertical: AppPadding.p12,
                ),
              ),
              child: Text(
                s.retry,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: FontConstants.balooThambi2,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}