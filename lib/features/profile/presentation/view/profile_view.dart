import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/nav_helper.dart';
import '../../../../core/shared_widgets/custom_buttom_navigation_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    return Scaffold(
      body: const Center(
        child: Text('Profile'),
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: NavHelper.getCurrentIndex(location),
        onTap: (index) => NavHelper.onItemTapped(context, index),
      ),
    );
  }
}
