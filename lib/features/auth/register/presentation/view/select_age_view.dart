import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';

class SelectAgeView extends StatefulWidget {
  const SelectAgeView({super.key, this.formData});

  final RegisterFormData? formData;

  @override
  State<SelectAgeView> createState() => _SelectAgeViewState();
}

class _SelectAgeViewState extends State<SelectAgeView> {
  static const int _minAge = 15;
  static const int _maxAge = 80;
  static const int _initialAge = 25;

  int _selectedAge = _initialAge;

  void _onBackPressed() {
    if (context.canPop()) {
      context.pop();
    }
  }

  void _onAgeChanged(int age) {
    setState(() => _selectedAge = age);
  }

  void _onNextPressed() {
    final data = widget.formData;
    if (data == null) return;

    context.push(
      RoutePath.selectWeightRoute,
      extra: data.copyWith(age: _selectedAge),
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
                        step: 2,
                        totalSteps: 6,
                      ),
                      const SizedBox(height: AppSize.s20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          s.howOldAreYou,
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
                    Radius.circular(RadiusSize.r50),
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
                        borderRadius: const BorderRadius.all(
                          Radius.circular(RadiusSize.r50),
                        ),
                        border: Border.all(
                          color: AppColors.white.withAlpha(35),
                        ),
                      ),
                      child: Column(
                        children: [
                          Text(
                            s.year,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontFamily: FontConstants.balooThambi2,
                              fontWeight: FontWeightManager.bold,
                              fontSize: FontSize.s12,
                            ),
                          ),
                          const SizedBox(height: AppSize.s12),
                          _AgePicker(
                            minAge: _minAge,
                            maxAge: _maxAge,
                            initialAge: _initialAge,
                            onChanged: _onAgeChanged,
                          ),
                          const SizedBox(height: AppSize.s4),
                          const Icon(
                            Icons.arrow_drop_up,
                            color: AppColors.primary,
                            size: AppSize.s24,
                          ),
                          const SizedBox(
                            height: AppSize.s24,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: _onNextPressed,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.primary,
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

class _AgePicker extends StatefulWidget {
  const _AgePicker({
    required this.minAge,
    required this.maxAge,
    required this.initialAge,
    required this.onChanged,
  });

  final int minAge;
  final int maxAge;
  final int initialAge;
  final ValueChanged<int> onChanged;

  @override
  State<_AgePicker> createState() => _AgePickerState();
}

class _AgePickerState extends State<_AgePicker> {
  static const double _itemWidth = 70;
  static const double _pickerHeight = 62;

  late final PageController _controller;
  late int _selectedIndex;
  bool _controllerReady = false;

  int get _itemCount => widget.maxAge - widget.minAge + 1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialAge - widget.minAge;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_controllerReady) return;

    final screenWidth = MediaQuery.of(context).size.width;
    final fraction = (_itemWidth / screenWidth).clamp(0.05, 1.0);

    _controller = PageController(
      viewportFraction: fraction,
      initialPage: _selectedIndex,
    );
    _controllerReady = true;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() => _selectedIndex = index);
    widget.onChanged(widget.minAge + index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _pickerHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final page =
              _controller.hasClients && _controller.position.haveDimensions
              ? (_controller.page ?? _selectedIndex.toDouble())
              : _selectedIndex.toDouble();

          return PageView.builder(
            controller: _controller,
            itemCount: _itemCount,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final distance = (index - page).abs().clamp(0.0, 3.0);
              final scale = 1.0 - (distance * 0.18).clamp(0.0, 0.55);
              final opacity = 1.0 - (distance * 0.28).clamp(0.0, 0.75);
              final isSelected = distance < 0.5;

              return Center(
                child: Transform.scale(
                  scale: scale,
                  child: Opacity(
                    opacity: opacity,
                    child: Text(
                      '${widget.minAge + index}',
                      style: TextStyle(
                        color: isSelected ? AppColors.primary : AppColors.white,
                        fontFamily: FontConstants.balooThambi2,
                        fontWeight: isSelected
                            ? FontWeightManager.bold
                            : FontWeightManager.regular,
                        fontSize: isSelected ? 38 : 28,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
