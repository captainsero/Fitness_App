import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';

class ExploreContainersHeadline extends StatelessWidget {
  const ExploreContainersHeadline({required this.title, super.key});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(
        context,
      ).textTheme.titleLarge!.copyWith(fontSize: FontSize.s16),
    );
  }
}
