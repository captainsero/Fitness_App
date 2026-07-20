import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import 'mesh_gradient_painter.dart';

class MeshGradient extends StatelessWidget {
  const MeshGradient({
    required this.size, required this.plusController, super.key,
  });
  final Size size;
  final AnimationController plusController;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AnimatedBuilder(
      animation: plusController,
      builder: (context, child) {
        return CustomPaint(
          size: size,
          painter: MeshGradientPainter(
            progress: plusController.value,
            primaryColor: AppColors.primary,
            isDark: isDark,
          ),
        );
      },
    );
  }
}
