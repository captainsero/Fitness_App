import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../models/register_form_data.dart';

/// Onboarding step 4/6 - height selection (in cm).
///
/// Records the chosen height onto [formData] and carries it forward to the
/// goal step -- the actual `POST /auth/signup` call happens once every
/// onboarding field is known, on the final step (SelectActivityLevelView).
class SelectHeightView extends StatefulWidget {
  const SelectHeightView({super.key, this.formData});

  /// Data collected on the previous screens. Null if this screen was
  /// reached directly rather than via the normal flow.
  final RegisterFormData? formData;

  @override
  State<SelectHeightView> createState() => _SelectHeightViewState();
}

class _SelectHeightViewState extends State<SelectHeightView> {
  static const int _minHeight = 100;
  static const int _maxHeight = 250;
  static const int _initialHeight = 167;

  int _selectedHeight = _initialHeight;

  void _onBackPressed() {
    if (context.canPop()) {
      context.pop();
    }
  }

  void _onHeightChanged(int height) {
    setState(() => _selectedHeight = height);
  }

  void _onNextPressed() {
    final data = widget.formData;
    if (data == null) return;

    context.push(
      RoutePath.selectGoalRoute,
      extra: data.copyWith(height: _selectedHeight),
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
                      const _StepProgressIndicator(step: 4, totalSteps: 6),
                      const SizedBox(height: AppSize.s24),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          s.whatIsYourHeight,
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
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: AppSize.s24),
                  padding: EdgeInsets.fromLTRB(
                    0,
                    AppPadding.p40,
                    0,
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
                      Text(
                        s.cm,
                        style: const TextStyle(
                          color: AppColors.primaryLight3,
                          fontFamily: FontConstants.balooThambi2,
                          fontWeight: FontWeightManager.bold,
                          fontSize: FontSize.s14,
                        ),
                      ),
                      const SizedBox(height: AppSize.s16),
                      _NumberWheelPicker(
                        minValue: _minHeight,
                        maxValue: _maxHeight,
                        initialValue: _initialHeight,
                        onChanged: _onHeightChanged,
                      ),
                      const SizedBox(height: AppSize.s4),
                      const Icon(
                        Icons.arrow_drop_up,
                        color: AppColors.primary,
                        size: AppSize.s30,
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p30,
                        ),
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _onNextPressed,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
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

/// Small circular-progress + fraction label used as the step indicator
/// (e.g. the "4/6" badge with an orange arc ring around it).
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

/// Horizontal, snapping number wheel: the centered value is large and
/// highlighted, with neighboring values shrinking/fading by distance.
/// Used for height (cm) here; the same shape is used for age (years) in
/// SelectAgeView.
class _NumberWheelPicker extends StatefulWidget {
  const _NumberWheelPicker({
    required this.minValue,
    required this.maxValue,
    required this.initialValue,
    required this.onChanged,
  });

  final int minValue;
  final int maxValue;
  final int initialValue;
  final ValueChanged<int> onChanged;

  @override
  State<_NumberWheelPicker> createState() => _NumberWheelPickerState();
}

class _NumberWheelPickerState extends State<_NumberWheelPicker> {
  static const double _itemWidth = 80;
  static const double _pickerHeight = 70;

  late final PageController _controller;
  late int _selectedIndex;
  bool _controllerReady = false;

  int get _itemCount => widget.maxValue - widget.minValue + 1;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialValue - widget.minValue;
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
    widget.onChanged(widget.minValue + index);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _pickerHeight,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final page = _controller.hasClients &&
              _controller.position.haveDimensions
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
                      '${widget.minValue + index}',
                      style: TextStyle(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.white,
                        fontFamily: FontConstants.balooThambi2,
                        fontWeight: isSelected
                            ? FontWeightManager.bold
                            : FontWeightManager.regular,
                        fontSize: isSelected ? FontSize.s44 : FontSize.s33,
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