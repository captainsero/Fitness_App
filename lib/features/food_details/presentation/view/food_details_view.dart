import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';
import '../widgets/food_details_body.dart';

class FoodDetailsView extends StatelessWidget {
  const FoodDetailsView({required this.mealId, super.key});

  final String mealId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
