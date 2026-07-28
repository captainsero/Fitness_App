import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';

class GlassBackgroundWrapper extends StatelessWidget {
  const GlassBackgroundWrapper({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg_gym.jpg', // المسار المعتمد للصورة
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
              child: Container(color: AppColors.black.withValues(alpha: 0.55)),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
