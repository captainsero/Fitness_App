import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';

enum Gender { male, female }

class SelectGenderView extends StatelessWidget {
  const SelectGenderView({super.key, this.formData});

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
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppPadding.p16,
                    AppPadding.p16,
                    AppPadding.p16,
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
                                height: AppSize.s48,
                                errorBuilder: (_, _, _) =>
                                const SizedBox(height: AppSize.s48),
                              ),
                            ),
                          ),
                          const SizedBox(width: 32),
                        ],
                      ),
                      const SizedBox(height: AppSize.s12),
                      const _StepProgressIndicator(
                        step: 1,
                        totalSteps: 6,
                      ),
                      const SizedBox(height: AppSize.s20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          s.tellUsAboutYourself,
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
                          s.weNeedToKnowYourGender,
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
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(RadiusSize.r30),
                    topRight: Radius.circular(RadiusSize.r30),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.fromLTRB(
                        AppPadding.p20,
                        AppPadding.p24,
                        AppPadding.p20,
                        AppPadding.p16 + MediaQuery.of(context).padding.bottom,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.neutral900.withAlpha(105),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(RadiusSize.r30),
                          topRight: Radius.circular(RadiusSize.r30),
                        ),
                        border: Border.all(
                          color: AppColors.white.withAlpha(35),
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
                          const SizedBox(height: AppSize.s16),
                          _GenderOption(
                            icon: Icons.female,
                            label: s.female,
                            isSelected: _selectedGender == Gender.female,
                            onTap: () => _onGenderTap(Gender.female),
                          ),
                          const SizedBox(height: AppSize.s24,),
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
        width: 76,
        height: 76,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected
              ? AppColors.primary.withAlpha(180)
              : AppColors.white.withAlpha(15),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.white.withAlpha(100),
            width: AppSize.s1_5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.white,
              size: AppSize.s24,
            ),
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