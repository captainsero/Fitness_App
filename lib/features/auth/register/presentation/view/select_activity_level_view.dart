import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/di/di.dart';
import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';
import '../view_model/register_cubit.dart';
import '../view_model/register_state.dart';

enum ActivityLevel {
  sedentary,
  lightlyActive,
  moderatelyActive,
  veryActive,
  extraActive,
}

extension ActivityLevelApiValue on ActivityLevel {
  String get apiValue {
    switch (this) {
      case ActivityLevel.sedentary:
        return 'level1';
      case ActivityLevel.lightlyActive:
        return 'level2';
      case ActivityLevel.moderatelyActive:
        return 'level3';
      case ActivityLevel.veryActive:
        return 'level4';
      case ActivityLevel.extraActive:
        return 'level5';
    }
  }
}

class SelectActivityLevelView extends StatelessWidget {
  const SelectActivityLevelView({super.key, this.formData});

  final RegisterFormData? formData;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<RegisterCubit>(),
      child: _SelectActivityLevelView(formData: formData),
    );
  }
}

class _SelectActivityLevelView extends StatefulWidget {
  const _SelectActivityLevelView({this.formData});

  final RegisterFormData? formData;

  @override
  State<_SelectActivityLevelView> createState() =>
      _SelectActivityLevelViewState();
}

class _SelectActivityLevelViewState extends State<_SelectActivityLevelView> {
  ActivityLevel? _selectedActivityLevel;

  bool get _canContinue {
    final data = widget.formData;

    return _selectedActivityLevel != null &&
        data != null &&
        data.gender != null &&
        data.age != null &&
        data.weight != null &&
        data.height != null &&
        data.goal != null;
  }

  void _onBackPressed() {
    if (context.canPop()) {
      context.pop();
    }
  }

  void _onActivityLevelTap(ActivityLevel activityLevel) {
    setState(() => _selectedActivityLevel = activityLevel);
  }

  void _onNextPressed() {
    final data = widget.formData;
    final activityLevel = _selectedActivityLevel;

    if (!_canContinue || data == null || activityLevel == null) return;

    context.read<RegisterCubit>().register(
      firstName: data.firstName,
      lastName: data.lastName,
      email: data.email,
      password: data.password,
      rePassword: data.password,
      gender: data.gender!,
      age: data.age!,
      weight: data.weight!,
      height: data.height!,
      goal: data.goal!,
      activityLevel: activityLevel.apiValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state.data != null) {
            context.go(RoutePath.loginRoute);
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage!),
                  backgroundColor: AppColors.error,
                ),
              );
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Image.asset(
                AssetsConst.loginBackground,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                const ColoredBox(color: AppColors.backgroundDark),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withAlpha(105),
                    AppColors.black.withAlpha(165),
                    AppColors.black.withAlpha(205),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  vertical: AppPadding.p16,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppPadding.p16,
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _BackButton(onTap: _onBackPressed),
                              Expanded(
                                child: Center(
                                  child: Image.asset(
                                    AssetsConst.logo,
                                    height: AppSize.s48,
                                    errorBuilder: (_, _, _) =>
                                    const SizedBox(height: AppSize.s48),
                                  ),
                                ),
                              ),
                              const SizedBox(width: AppSize.s40),
                            ],
                          ),
                          const SizedBox(height: AppSize.s12),
                          const _StepProgressIndicator(
                            step: 6,
                            totalSteps: 6,
                          ),
                          const SizedBox(height: AppSize.s20),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              s.whatIsYourActivityLevel,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: FontConstants.balooThambi2,
                                fontWeight: FontWeightManager.bold,
                                fontSize: FontSize.s20,
                              ),
                            ),
                          ),
                          const SizedBox(height: AppSize.s4),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              s.thisHelpsUsCreateYourPersonalizedPlan,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: FontConstants.balooThambi2,
                                fontSize: FontSize.s12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(RadiusSize.r30),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(AppPadding.p20),
                          decoration: BoxDecoration(
                            color: AppColors.neutral900.withAlpha(105),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(RadiusSize.r30),
                            ),
                            border: Border.all(
                              color: AppColors.white.withAlpha(35),
                            ),
                          ),
                          child: Column(
                            children: [
                              _ActivityLevelOption(
                                label: s.sedentary,
                                isSelected: _selectedActivityLevel ==
                                    ActivityLevel.sedentary,
                                onTap: () => _onActivityLevelTap(
                                  ActivityLevel.sedentary,
                                ),
                              ),
                              const SizedBox(height: AppSize.s12),
                              _ActivityLevelOption(
                                label: s.lightlyActive,
                                isSelected: _selectedActivityLevel ==
                                    ActivityLevel.lightlyActive,
                                onTap: () => _onActivityLevelTap(
                                  ActivityLevel.lightlyActive,
                                ),
                              ),
                              const SizedBox(height: AppSize.s12),
                              _ActivityLevelOption(
                                label: s.moderatelyActive,
                                isSelected: _selectedActivityLevel ==
                                    ActivityLevel.moderatelyActive,
                                onTap: () => _onActivityLevelTap(
                                  ActivityLevel.moderatelyActive,
                                ),
                              ),
                              const SizedBox(height: AppSize.s12),
                              _ActivityLevelOption(
                                label: s.veryActive,
                                isSelected: _selectedActivityLevel ==
                                    ActivityLevel.veryActive,
                                onTap: () => _onActivityLevelTap(
                                  ActivityLevel.veryActive,
                                ),
                              ),
                              const SizedBox(height: AppSize.s12),
                              _ActivityLevelOption(
                                label: s.extraActive,
                                isSelected: _selectedActivityLevel ==
                                    ActivityLevel.extraActive,
                                onTap: () => _onActivityLevelTap(
                                  ActivityLevel.extraActive,
                                ),
                              ),
                              const SizedBox(height: AppSize.s20),
                              BlocBuilder<RegisterCubit, RegisterState>(
                                builder: (context, state) {
                                  final isLoading = state.isLoading ?? false;
                                  final enabled = _canContinue && !isLoading;

                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed:
                                      enabled ? _onNextPressed : null,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: enabled
                                            ? AppColors.primary
                                            : AppColors.neutral300,
                                        disabledBackgroundColor:
                                        AppColors.neutral300,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: AppPadding.p12,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            RadiusSize.r100,
                                          ),
                                        ),
                                      ),
                                      child: isLoading
                                          ? const SizedBox(
                                        height: AppSize.s18,
                                        width: AppSize.s18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: AppSize.s2,
                                          color: AppColors.white,
                                        ),
                                      )
                                          : Text(
                                        s.next,
                                        style: const TextStyle(
                                          color: AppColors.white,
                                          fontFamily:
                                          FontConstants.balooThambi2,
                                          fontWeight:
                                          FontWeightManager.bold,
                                          fontSize: FontSize.s14,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Container(
        width: AppSize.s32,
        height: AppSize.s32,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
          size: FontSize.s12,
        ),
      ),
    );
  }
}

class _StepProgressIndicator extends StatelessWidget {
  const _StepProgressIndicator({
    required this.step,
    required this.totalSteps,
  });

  final int step;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppSize.s16,
          height: AppSize.s16,
          child: CircularProgressIndicator(
            value: step / totalSteps,
            strokeWidth: 2,
            color: AppColors.primary,
            backgroundColor: AppColors.white.withAlpha(60),
          ),
        ),
        const SizedBox(width: AppSize.s4),
        Text(
          '$step/$totalSteps',
          style: const TextStyle(
            color: AppColors.primary,
            fontFamily: FontConstants.balooThambi2,
            fontWeight: FontWeightManager.bold,
            fontSize: FontSize.s12,
          ),
        ),
      ],
    );
  }
}

class _ActivityLevelOption extends StatelessWidget {
  const _ActivityLevelOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: const BorderRadius.all(
        Radius.circular(RadiusSize.r100),
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p16,
          vertical: AppPadding.p12,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withAlpha(35)
              : AppColors.white.withAlpha(20),
          borderRadius: const BorderRadius.all(
            Radius.circular(RadiusSize.r100),
          ),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.white.withAlpha(60),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: AppColors.white,
                  fontFamily: FontConstants.balooThambi2,
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSize.s12,
                ),
              ),
            ),
            const SizedBox(width: AppSize.s8),
            _RadioCircle(isSelected: isSelected),
          ],
        ),
      ),
    );
  }
}

class _RadioCircle extends StatelessWidget {
  const _RadioCircle({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: AppSize.s16,
      height: AppSize.s16,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? AppColors.primary : AppColors.white,
          width: AppSize.s1_5,
        ),
      ),
      child: isSelected
          ? Container(
        width: AppSize.s8,
        height: AppSize.s8,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
      )
          : null,
    );
  }
}