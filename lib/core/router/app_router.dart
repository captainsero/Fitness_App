import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../config/di/di.dart';
import '../../features/auth/login/presentation/view/login_view.dart';
import '../../features/auth/register/presentation/models/register_form_data.dart';
import '../../features/auth/register/presentation/view/register_view.dart';
import '../../features/auth/register/presentation/view/select_activity_level_view.dart';
import '../../features/auth/register/presentation/view/select_age_view.dart';
import '../../features/auth/register/presentation/view/select_gender_view.dart';
import '../../features/auth/register/presentation/view/select_goal_view.dart';
import '../../features/auth/register/presentation/view/select_height_view.dart';
import '../../features/auth/register/presentation/view/select_weight_view.dart';
import '../../features/error/presentation/view/error_view.dart';
import '../../features/explore/presentation/view/explore_view.dart';
import '../../features/food_details/presentation/view/food_details_view.dart';
import '../../features/explore/presentation/view_model/explore_cubit.dart';
import '../../features/on_boarding/presentation/views/screen/on_boarding_screen.dart';
import '../../features/profile/presentation/view/profile_view.dart';
import '../../features/smart_coach/presentation/view/smart_coach_view.dart';
import '../../features/splash/presentation/view/pages/splash_page.dart';
import '../../features/workouts/presentation/view/workouts_view.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    // initialLocation: RoutePath.splashRoute,
    //! =======================================
    initialLocation: '${RoutePath.foodDetailsRoute}/52959',
    //! =======================================
    routes: [
      GoRoute(
        path: RoutePath.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RoutePath.onBoardingRoute,
        builder: (context, state) => const OnBoardingScreen(),
      ),
      GoRoute(
        path: RoutePath.exploreRoute,
        builder: (context, state) => BlocProvider(
          create: (context) {
            final cubit = getIt.get<ExploreCubit>();
            unawaited(cubit.init());
            return cubit;
          },
          child: const ExploreView(),
        ),
      ),
      GoRoute(
        path: RoutePath.smartCouchRoute,
        builder: (context, state) => const SmartCoachView(),
      ),
      GoRoute(
        path: RoutePath.workoutsRoute,
        builder: (context, state) => const WorkoutsView(),
      ),
      GoRoute(
        path: RoutePath.profileRoute,
        builder: (context, state) => const ProfileView(),
      ),
      GoRoute(
        path: RoutePath.loginRoute,
        builder: (context, state) => const LoginView(),
      ),
      GoRoute(
        path: RoutePath.registerRoute,
        builder: (context, state) => const RegisterView(),
      ),
      GoRoute(
        path: RoutePath.selectGenderRoute,
        builder: (context, state) => SelectGenderView(
          formData: state.extra as RegisterFormData?,
        ),
      ),
      GoRoute(
        path: RoutePath.selectAgeRoute,
        builder: (context, state) => SelectAgeView(
          formData: state.extra as RegisterFormData?,
        ),
      ),
      GoRoute(
        path: RoutePath.selectWeightRoute,
        builder: (context, state) => SelectWeightView(
          formData: state.extra as RegisterFormData?,
        ),
      ),
      GoRoute(
        path: RoutePath.selectHeightRoute,
        builder: (context, state) => SelectHeightView(
          formData: state.extra as RegisterFormData?,
        ),
      ),
      GoRoute(
        path: RoutePath.selectGoalRoute,
        builder: (context, state) => SelectGoalView(
          formData: state.extra as RegisterFormData?,
        ),
      ),
      GoRoute(
        path: RoutePath.selectActivityLevelRoute,
        builder: (context, state) => SelectActivityLevelView(
          formData: state.extra as RegisterFormData?,
        ),
      ),
      GoRoute(
        path: '${RoutePath.foodDetailsRoute}/:mealId',
        builder: (context, state) => FoodDetailsView(
          mealId: state.pathParameters['mealId'] ?? '53440',
        ),
      ),
    ],
    errorBuilder: (context, state) {
      return ErrorScreen(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
