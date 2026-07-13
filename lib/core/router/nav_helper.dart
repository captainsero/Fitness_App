import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'route_path.dart';

class NavHelper {
  static int getCurrentIndex(String location) {
    if (location == RoutePath.exploreRoute) return 0;
    if (location == RoutePath.smartCouchRoute) return 1;
    if (location == RoutePath.workoutsRoute) return 2;
    if (location == RoutePath.profileRoute) return 3;
    return 0;
  }

  static void onItemTapped(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RoutePath.exploreRoute);
      case 1:
        context.go(RoutePath.smartCouchRoute);
      case 2:
        context.go(RoutePath.workoutsRoute);
      case 3:
        context.go(RoutePath.profileRoute);
    }
  }
}
