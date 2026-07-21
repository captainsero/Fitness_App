import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/color_manager.dart';
import '../../../../generated/l10n.dart';
import '../view_model/food_details_cubit.dart';
import '../view_model/food_details_state.dart';
import 'ingredient_row.dart';
import 'macro_circle.dart';
import 'meal_video_player.dart';
import 'no_video_placeholder.dart';

class FoodDetailsBody extends StatelessWidget {
  const FoodDetailsBody({required this.mealId, super.key});

  final String mealId;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<FoodDetailsCubit, FoodDetailsState>(
        builder: (context, state) {
          if (state.isLoading == true) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (state.errorMessage != null) {
            return Center(
              child: Text(
                state.errorMessage!,
                style: const TextStyle(color: AppColors.white),
              ),
            );
          }

          final meal = state.data;
          if (meal == null) {
            return Center(
              child: Text(
                S.of(context).noDataFound,
                style: const TextStyle(color: AppColors.white),
              ),
            );
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (meal.strYoutube != null && meal.strYoutube!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: MealVideoPlayer(videoUrl: meal.strYoutube!),
                )
              else
                const Padding(
                  padding: EdgeInsets.fromLTRB(16, 12, 16, 4),
                  child: NoVideoPlaceholder(),
                ),

              const SizedBox(height: 20),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        meal.strMeal ?? S.of(context).unknownMeal,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        meal.strInstructions ?? '',
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.7),
                          fontSize: 13,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Macros row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MacroCircle(
                            value: '100 K',
                            label: S.of(context).energy,
                          ),
                          MacroCircle(
                            value: '15 G',
                            label: S.of(context).protein,
                          ),
                          MacroCircle(
                            value: '58 G',
                            label: S.of(context).carbs,
                          ),
                          MacroCircle(value: '20 G', label: S.of(context).fat),
                        ],
                      ),
                      const SizedBox(height: 28),

                      Text(
                        S.of(context).ingredients,
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Ingredients list
                      if (meal.ingredients != null)
                        ...meal.ingredients!.map(
                          (ingredient) => IngredientRow(
                            name: ingredient.key,
                            amount: ingredient.value,
                          ),
                        ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
