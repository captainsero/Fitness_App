import 'package:go_router/go_router.dart';
import '../../features/error/presentation/view/error_view.dart';
import '../../features/explore/presentation/view/explore_view.dart';
import '../../features/on_boarding/presentation/views/screen/on_boarding_screen.dart';
import '../../features/profile/presentation/view/profile_view.dart';
import '../../features/smart_coach/presentation/view/smart_coach_view.dart';
import '../../features/splash/presentation/view/pages/splash_page.dart';
import '../../features/workouts/presentation/view/workouts_view.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.splashRoute,
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
        builder: (context, state) => const ExploreView(),
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
    ],
    errorBuilder: (context, state) {
      return ErrorScreen(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
