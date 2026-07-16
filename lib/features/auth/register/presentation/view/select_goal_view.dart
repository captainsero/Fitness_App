import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';

/// Goal options for the "what is your goal" onboarding step.
enum Goal { gainWeight, loseWeight, getFitter, gainMoreFlexible, learnTheBasics }

/// Onboarding step 5/6 - goal selection.
///
/// Records the chosen goal onto [formData] and carries it forward to the
/// activity-level step -- the actual `POST /auth/signup` call happens once
/// every onboarding field is known, on that final step
/// (SelectActivityLevelView).
class SelectGoalView extends StatefulWidget {
  const SelectGoalView({super.key, this.formData});

  /// Data collected on the previous screens. Null if this screen was
  /// reached directly rather than via the normal flow.
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
      extra: data.copyWith(goal: goal.name),
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
              errorBuilder: (context, error, stackTrace) =>
              const ColoredBox(color: AppColors.backgroundDark),
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.black.withAlpha(140),
                  AppColors.black.withAlpha(210),
                  AppColors.black.withAlpha(245),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(top: AppPadding.p12),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20,
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
                                  height: AppSize.s50,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                  const SizedBox(height: AppSize.s50),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSize.s40),
                          ],
                        ),
                        const SizedBox(height: AppSize.s16),
                        const _StepProgressIndicator(step: 5, totalSteps: 6),
                        const SizedBox(height: AppSize.s24),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            s.whatIsYourGoal,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontFamily: FontConstants.balooThambi2,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s22,
                            ),
                          ),
                        ),
                        const SizedBox(height: AppSize.s8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            s.thisHelpsUsCreateYourPersonalizedPlan,
                            style: const TextStyle(
                              color: AppColors.white,
                              fontFamily: FontConstants.balooThambi2,
                              fontSize: FontSize.s14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      AppPadding.p20,
                      AppPadding.p30,
                      AppPadding.p20,
                      AppPadding.p20,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: AppPadding.p26,
                        horizontal: AppPadding.p16,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.neutral900.withAlpha(115),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(RadiusSize.r30),
                        ),
                        border: Border.all(
                          color: AppColors.white.withAlpha(25),
                        ),
                      ),
                      child: Column(
                        children: [
                          _GoalOption(
                            label: s.gainWeight,
                            isSelected: _selectedGoal == Goal.gainWeight,
                            onTap: () => _onGoalTap(Goal.gainWeight),
                          ),
                          const SizedBox(height: AppSize.s16),
                          _GoalOption(
                            label: s.loseWeight,
                            isSelected: _selectedGoal == Goal.loseWeight,
                            onTap: () => _onGoalTap(Goal.loseWeight),
                          ),
                          const SizedBox(height: AppSize.s16),
                          _GoalOption(
                            label: s.getFitter,
                            isSelected: _selectedGoal == Goal.getFitter,
                            onTap: () => _onGoalTap(Goal.getFitter),
                          ),
                          const SizedBox(height: AppSize.s16),
                          _GoalOption(
                            label: s.gainMoreFlexible,
                            isSelected:
                            _selectedGoal == Goal.gainMoreFlexible,
                            onTap: () => _onGoalTap(Goal.gainMoreFlexible),
                          ),
                          const SizedBox(height: AppSize.s16),
                          _GoalOption(
                            label: s.learnTheBasics,
                            isSelected: _selectedGoal == Goal.learnTheBasics,
                            onTap: () => _onGoalTap(Goal.learnTheBasics),
                          ),
                          const SizedBox(height: AppSize.s25),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _canContinue ? _onNextPressed : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _canContinue
                                    ? AppColors.primary
                                    : AppColors.neutral300,
                                disabledBackgroundColor:
                                AppColors.neutral300,
                                padding: const EdgeInsets.symmetric(
                                  vertical: AppPadding.p16,
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
                                  fontSize: FontSize.s16,
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
        width: AppSize.s40,
        height: AppSize.s40,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: AppColors.white,
          size: AppSize.s16,
        ),
      ),
    );
  }
}

/// Small circular-progress + fraction label used as the step indicator
/// (e.g. the "5/6" badge with an orange arc ring around it).
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
            fontSize: FontSize.s14,
          ),
        ),
      ],
    );
  }
}

/// A single pill-shaped, radio-style goal row.
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
      borderRadius: const BorderRadius.all(Radius.circular(RadiusSize.r100)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p20,
          vertical: AppPadding.p16,
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
                  fontSize: FontSize.s14,
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
      width: AppSize.s20,
      height: AppSize.s20,
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
        width: AppSize.s12,
        height: AppSize.s12,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.primary,
        ),
      )
          : null,
    );
  }
}