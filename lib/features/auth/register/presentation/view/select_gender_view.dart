import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';

/// Gender options for the "tell us about yourself" onboarding step.
enum Gender { male, female }

/// Onboarding step 1/6 - gender selection.
///
/// `POST /auth/signup` needs firstName/lastName/email/password/gender
/// *plus* age/weight/height/goal/activityLevel all in one request, so the
/// account isn't created here. This screen just records the gender picked
/// and carries [formData] (from [RegisterView]) forward via
/// [RegisterFormData.copyWith] to the next step -- the actual signup call
/// happens once every field is known, on the final onboarding step
/// (SelectActivityLevelView).
class SelectGenderView extends StatelessWidget {
  const SelectGenderView({super.key, this.formData});

  /// Data collected on the previous screen. Null if this screen was
  /// reached directly (e.g. deep link / dev testing) rather than via the
  /// normal Register -> SelectGender flow -- in that case there's
  /// nothing valid to sign up with, so "Next" is disabled entirely.
  final RegisterFormData? formData;

  @override
  Widget build(BuildContext context) {
    return _SelectGenderView(formData: formData);
  }
}

class _SelectGenderView extends StatefulWidget {
  const _SelectGenderView({this.formData});

  final RegisterFormData? formData;

  @override
  State<_SelectGenderView> createState() => _SelectGenderViewState();
}

class _SelectGenderViewState extends State<_SelectGenderView> {
  Gender? _selectedGender;

  bool get _canContinue => _selectedGender != null && widget.formData != null;

  void _onBackPressed() {
    if (context.canPop()) {
      context.pop();
    }
  }

  void _onGenderTap(Gender gender) {
    setState(() => _selectedGender = gender);
  }

  void _onNextPressed() {
    final data = widget.formData;
    final gender = _selectedGender;
    if (data == null || gender == null) return;

    context.push(
      RoutePath.selectAgeRoute,
      extra: data.copyWith(gender: gender.name),
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
          Column(
            children: [
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p20,
                    AppPadding.p12,
                    AppPadding.p20,
                    0,
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
                      Text(
                        s.onboardingStepIndicator(1, 6),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontFamily: FontConstants.balooThambi2,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      const SizedBox(height: AppSize.s24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          s.tellUsAboutYourself,
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
                          s.weNeedToKnowYourGender,
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
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: AppSize.s24),
                  padding: EdgeInsets.fromLTRB(
                    AppPadding.p30,
                    AppPadding.p40,
                    AppPadding.p30,
                    AppPadding.p20 + MediaQuery.of(context).padding.bottom,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(RadiusSize.r30),
                      topRight: Radius.circular(RadiusSize.r30),
                    ),
                  ),
                  child: Column(
                    children: [
                      _GenderOption(
                        icon: Icons.male,
                        label: s.male,
                        isSelected: _selectedGender == Gender.male,
                        onTap: () => _onGenderTap(Gender.male),
                      ),
                      const SizedBox(height: AppSize.s24),
                      _GenderOption(
                        icon: Icons.female,
                        label: s.female,
                        isSelected: _selectedGender == Gender.female,
                        onTap: () => _onGenderTap(Gender.female),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _canContinue ? _onNextPressed : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _canContinue
                                ? AppColors.primary
                                : AppColors.neutral300,
                            disabledBackgroundColor: AppColors.neutral300,
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

class _GenderOption extends StatelessWidget {
  const _GenderOption({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: AppSize.s90,
        height: AppSize.s90,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? AppColors.primary : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.white.withAlpha(150),
            width: AppSize.s1_5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppColors.white, size: AppSize.s30),
            const SizedBox(height: AppSize.s4),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.white,
                fontFamily: FontConstants.balooThambi2,
                fontSize: FontSize.s12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
