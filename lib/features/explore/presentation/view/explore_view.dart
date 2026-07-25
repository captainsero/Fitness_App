import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../core/router/route_path.dart';
import '../../../../core/shared_widgets/blurred_background.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';
import '../../../../generated/l10n.dart';
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
            //TODO: add name and image when getting profile data
            Text(
              'Hi Ahmed',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(S.current.letsStartYourDay),
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0, // Explore is tab index 0
        onTap: (index) => _onTabTapped(context, index),
      ),
    );
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
}
