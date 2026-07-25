import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../generated/l10n.dart';
import 'animated_progress_bar.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    required this.loadingController,
    required this.textController,
    required this.textOpacity,
    super.key,
  });
  final AnimationController loadingController;
  final AnimationController textController;
  final Animation<double> textOpacity;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final subtitleColor = isDark ? AppColors.neutral300 : AppColors.neutral500;

    return AnimatedBuilder(
      animation: textController,
      builder: (context, child) {
        return Opacity(
          opacity: textOpacity.value,
          child: Column(
            children: [
              // Progress bar style loader
              AnimatedProgressBar(animation: loadingController),
              const SizedBox(height: 16),
              // Loading text
              Text(
                S.of(context).loading,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: subtitleColor,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
