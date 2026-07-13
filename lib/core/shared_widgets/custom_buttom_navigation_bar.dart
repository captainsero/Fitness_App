import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../constants/values_manager.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(RadiusSize.r20),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).colorScheme.tertiary.withAlpha(220),
        unselectedItemColor: Theme.of(context).colorScheme.onPrimary,
        onTap: onTap,
        items: [
          _buildNavItem(
            context,
            assetPath: AssetsConst.exploreIcon,
            label: 'Explore',
          ),
          _buildNavItem(
            context,
            assetPath: AssetsConst.smartCoachIcon,
            label: 'Smart Coach',
          ),
          _buildNavItem(
            context,
            assetPath: AssetsConst.workoutsIcon,
            label: 'Workouts',
          ),
          _buildNavItem(
            context,
            assetPath: AssetsConst.profileIcon,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
    BuildContext context, {
    required String assetPath,
    required String label,
  }) {
    return BottomNavigationBarItem(
      activeIcon: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.primary,
          BlendMode.srcIn,
        ),
      ),
      icon: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          Theme.of(context).colorScheme.onPrimary,
          BlendMode.srcIn,
        ),
      ),
      label: label,
    );
  }
}
