import 'package:flutter/material.dart';

import '../../../../../../core/constants/color_manager.dart';
import '../../../../../../core/constants/font_manager.dart';
import '../../../../../../core/constants/values_manager.dart';

/// Centered spinner shown while exercises are being fetched.
class LoadingStateWidget extends StatelessWidget {
  const LoadingStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppPadding.p24),
      child: Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      ),
    );
  }
}

/// Shown when fetching exercises fails. Give the user a way to try again
/// instead of leaving them looking at a blank container.
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: AppColors.white,
            size: AppSize.s40,
          ),
          const SizedBox(height: AppSize.s8),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
              fontFamily: FontConstants.balooThambi2,
              fontSize: FontSize.s14,
            ),
          ),
          const SizedBox(height: AppSize.s8),
          TextButton(
            onPressed: onRetry,
            child: const Text(
              'Retry',
              style: TextStyle(
                color: AppColors.primary,
                fontFamily: FontConstants.balooThambi2,
                fontWeight: FontWeightManager.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Shown when a request succeeded but returned no exercises for the
/// selected difficulty.
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p24),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.white,
          fontFamily: FontConstants.balooThambi2,
          fontSize: FontSize.s14,
        ),
      ),
    );
  }
}
