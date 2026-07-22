import 'package:flutter/material.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../core/shared_widgets/blurred_background.dart';
import '../widgets/categories_container.dart';
import '../widgets/popular_training_container.dart';
import '../widgets/recommendation_for_you_container.dart';
import '../widgets/recommendation_to_day_container.dart';
import '../widgets/upcoming_workouts_container.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Ahmed',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Text("let's start your day"),
          ],
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('assets/images/logo.png'),
          ),
        ],
      ),
      body: const Stack(
        children: [
          BlurredBackground(),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(AppPadding.p16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: AppSize.s24,
                  children: [
                    CategoriesContainer(),
                    RecommendationToDayContainer(),
                    UpcomingWorkoutsContainer(),
                    RecommendationForYouContainer(),
                    PopularTrainingContainer(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
