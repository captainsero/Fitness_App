import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/di/di.dart';
import '../../../../core/constants/values_manager.dart';
import '../view_model/food_details_cubit.dart';
import '../widgets/food_details_body.dart';

class FoodDetailsView extends StatelessWidget {
  const FoodDetailsView({required this.mealId, super.key});

  final String mealId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FoodDetailsCubit>()..getMealDetails(mealId),
      child: Scaffold(
        extendBodyBehindAppBar: true,

        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                AssetsConst.foodDetailsBackground,
                fit: BoxFit.cover,
              ),
            ),

            FoodDetailsBody(mealId: mealId),
          ],
        ),
      ),
    );
  }
}
