import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/font_manager.dart';
import '../../../../../../core/constants/values_manager.dart';

/// Rounded, bordered pill used to show a short stat such as
/// "30 MIN" or "130 Cal" in the header.
class InfoPill extends StatelessWidget {
  const InfoPill({super.key, required this.label, required this.textColor});

  final String label;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppPadding.p12,
        vertical: AppPadding.p8,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.white.withValues(alpha: 0.5)),
        color: AppColors.neutral900.withValues(alpha: 0.63),
        borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r30)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontFamily: FontConstants.balooThambi2,
          fontWeight: FontWeightManager.bold,
          fontSize: FontSize.s12,
        ),
      ),
    );
  }
}
