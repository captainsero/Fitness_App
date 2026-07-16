import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../generated/l10n.dart';

class VersionInfo extends StatelessWidget {
  const VersionInfo({
    super.key,
    required this.textController,
    required this.textOpacity,
  });
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
          opacity: textOpacity.value * 0.6,
          child: Text(
            S.of(context).VersionNumber,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              color: subtitleColor,
              letterSpacing: 1,
            ),
          ),
        );
      },
    );
  }
}
