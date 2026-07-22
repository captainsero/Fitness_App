import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/values_manager.dart';

class RecommendationWidget extends StatelessWidget {
  const RecommendationWidget({
    required this.image,
    required this.name,
    super.key,
  });

  final String image;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(RadiusSize.r20),
          child: SizedBox(
            width: AppSize.s100,
            height: AppSize.s100,
            child: Image.network(
              image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.broken_image_outlined, size: AppSize.s30),
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(RadiusSize.r20),
              top: Radius.circular(RadiusSize.r12),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: AppSize.s10,
                sigmaY: AppSize.s10,
              ),
              child: Container(
                height: AppSize.s20,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppPadding.p12,
                ),
                alignment: Alignment.bottomCenter,
                child: Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(fontSize: FontSize.s12),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
