import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../core/router/nav_helper.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';

class ExploreView extends StatelessWidget {
  const ExploreView({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: const Center(
        child: Text('Explore'),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p10,
        ),
        child: CustomBottomNavigationBar(
          currentIndex: NavHelper.getCurrentIndex(location),
          onTap: (index) => NavHelper.onItemTapped(context, index),
        ),
      ),
    );
  }
}
