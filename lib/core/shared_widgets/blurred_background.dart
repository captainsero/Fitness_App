import 'package:flutter/material.dart';
import '../constants/color_manager.dart';

class BlurredBackground extends StatelessWidget {
  const BlurredBackground({
    super.key,
    this.imagePath = 'assets/images/background-blur.png',
    this.overlayColor = const Color(0xFF1A1A1A),
    this.overlayOpacity = 0.5,
  });

  final String imagePath;
  final Color overlayColor;
  final double overlayOpacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          imagePath,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const ColoredBox(color: AppColors.backgroundDark),
        ),
        Container(color: overlayColor.withValues(alpha: overlayOpacity)),
      ],
    );
  }
}
