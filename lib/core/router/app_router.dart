import 'package:go_router/go_router.dart';
import '../../features/auth/login/presentation/view/login_view.dart';
import '../../features/error/presentation/view/error_view.dart';
import '../../features/explore/presentation/view/explore_view.dart';
import '../../features/profile/presentation/view/profile_view.dart';
import '../../features/smart_coach/presentation/view/smart_coach_view.dart';
import '../../features/workouts/presentation/view/workouts_view.dart';
import 'route_path.dart';

abstract class AppRouter {
  static final GoRouter goRouter = GoRouter(
    initialLocation: RoutePath.loginRoute,
    routes: [
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
      GoRoute(
        path: RoutePath.loginRoute,
        builder: (context, state) => const LoginView(),
      ),
    ],
    errorBuilder: (context, state) {
      return ErrorScreen(
        errorMessage: state.error?.toString() ?? 'Page not found',
      );
    },
  );
}
