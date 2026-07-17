import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';

enum Goal { gainWeight, loseWeight, getFitter, gainMoreFlexible, learnTheBasics }

extension GoalApiValue on Goal {
  String get apiValue {
    switch (this) {
      case Goal.gainWeight:
        return 'Gain weight';
      case Goal.loseWeight:
        return 'Lose weight';
      case Goal.getFitter:
        return 'Get fitter';
      case Goal.gainMoreFlexible:
        return 'Gain more flexible';
      case Goal.learnTheBasics:
        return 'Learn the basics';
    }
  }
}

class SelectGoalView extends StatefulWidget {
  const SelectGoalView({super.key, this.formData});

  final RegisterFormData? formData;

  @override
  State<SelectGoalView> createState() => _SelectGoalViewState();
}

class _SelectGoalViewState extends State<SelectGoalView> {
  Goal? _selectedGoal;

  bool get _canContinue => _selectedGoal != null;

  void _onBackPressed() {
    if (context.canPop()) {
      context.pop();
    }
  }

  void _onGoalTap(Goal goal) {
    setState(() => _selectedGoal = goal);
  }

  void _onNextPressed() {
    final data = widget.formData;
    final goal = _selectedGoal;

    if (!_canContinue || data == null || goal == null) return;

    context.push(
      RoutePath.selectActivityLevelRoute,
      extra: data.copyWith(goal: goal.apiValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Image.asset(
              AssetsConst.loginBackground,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
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
                                  errorBuilder: (_, __, ___) =>
                                  const SizedBox(height: AppSize.s48),
                                ),
                              ),
                            ),
                            const SizedBox(width: 32),
                          ],
                        ),
                        const SizedBox(height: AppSize.s12),
                        const _StepProgressIndicator(
                          step: 5,
                          totalSteps: 6,
                        ),
                        const SizedBox(height: AppSize.s20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            s.whatIsYourGoal,
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
                            _GoalOption(
                              label: s.gainWeight,
                              isSelected: _selectedGoal == Goal.gainWeight,
                              onTap: () => _onGoalTap(Goal.gainWeight),
                            ),
                            const SizedBox(height: AppSize.s12),
                            _GoalOption(
                              label: s.loseWeight,
                              isSelected: _selectedGoal == Goal.loseWeight,
                              onTap: () => _onGoalTap(Goal.loseWeight),
                            ),
                            const SizedBox(height: AppSize.s12),
                            _GoalOption(
                              label: s.getFitter,
                              isSelected: _selectedGoal == Goal.getFitter,
                              onTap: () => _onGoalTap(Goal.getFitter),
                            ),
                            const SizedBox(height: AppSize.s12),
                            _GoalOption(
                              label: s.gainMoreFlexible,
                              isSelected:
                              _selectedGoal == Goal.gainMoreFlexible,
                              onTap: () =>
                                  _onGoalTap(Goal.gainMoreFlexible),
                            ),
                            const SizedBox(height: AppSize.s12),
                            _GoalOption(
                              label: s.learnTheBasics,
                              isSelected:
                              _selectedGoal == Goal.learnTheBasics,
                              onTap: () => _onGoalTap(Goal.learnTheBasics),
                            ),
                            const SizedBox(height: AppSize.s20),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed:
                                _canContinue ? _onNextPressed : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: _canContinue
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
                                child: Text(
                                  s.next,
                                  style: const TextStyle(
                                    color: AppColors.white,
                                    fontFamily: FontConstants.balooThambi2,
                                    fontWeight: FontWeightManager.bold,
                                    fontSize: FontSize.s14,
                                  ),
                                ),
                              ),
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
        width: 32,
        height: 32,
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

class _GoalOption extends StatelessWidget {
  const _GoalOption({
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