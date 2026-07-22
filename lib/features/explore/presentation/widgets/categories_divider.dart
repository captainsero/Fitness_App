import 'package:flutter/material.dart';

import '../../../../core/constants/values_manager.dart';

class CategoriesDivider extends StatelessWidget {
  const CategoriesDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.s60,
      child: VerticalDivider(
        thickness: 3,
        color: Theme.of(
          context,
        ).colorScheme.surface.withAlpha(255),
      ),
    );
  }
}
