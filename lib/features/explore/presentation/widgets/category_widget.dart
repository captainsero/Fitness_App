import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/values_manager.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    required this.image,
    required this.title,
    super.key,
  });

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: AppSize.s60,
          height: AppSize.s60,
          child: Image.asset(image),
        ),

        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontSize: FontSize.s12),
        ),
      ],
    );
  }
}
