import 'package:flutter/material.dart';

import '../constants/color_manager.dart';
import '../constants/font_manager.dart';
import '../constants/style_manager.dart';
import '../constants/values_manager.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  scaffoldBackgroundColor: AppColors.white,

  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.primary,
    onPrimary: AppColors.white,

    secondary: AppColors.primaryLight2,
    onSecondary: AppColors.white,

    error: AppColors.error,
    onError: AppColors.white,

    surface: AppColors.white,
    onSurface: AppColors.black,

    tertiary: AppColors.neutral900,
    onTertiary: AppColors.white,
  ),

  textTheme: TextTheme(
    displayLarge: getBoldStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s40,
    ),
    displayMedium: getSemiBoldStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s35,
    ),
    displaySmall: getMediumStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s30,
    ),

    headlineLarge: getSemiBoldStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s24,
    ),
    headlineMedium: getMediumStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s22,
    ),
    headlineSmall: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s18,
    ),

    titleLarge: getSemiBoldStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s22,
    ),
    titleMedium: getMediumStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s16,
    ),
    titleSmall: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s14,
    ),

    bodyLarge: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.neutral700,
      fontSize: FontSize.s16,
    ),
    bodyMedium: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.neutral700,
      fontSize: FontSize.s14,
    ),
    bodySmall: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.neutral700,
    ),

    labelLarge: getMediumStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.neutral500,
      fontSize: FontSize.s14,
    ),
    labelMedium: getMediumStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.neutral500,
    ),
    labelSmall: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.neutral500,
      fontSize: FontSize.s10,
    ),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.transparent,
    foregroundColor: AppColors.black,
    titleTextStyle: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s20,
    ),
    leadingWidth: AppSize.s25,
    actionsPadding: const EdgeInsets.only(right: AppPadding.p20),
    titleSpacing: AppSize.s0,
    elevation: 0,
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      disabledBackgroundColor: AppColors.neutral300,
      disabledForegroundColor: AppColors.neutral500,
      padding: const EdgeInsets.all(AppPadding.p16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
      textStyle: getMediumStyle(
        fontFamily: FontConstants.balooThambi2,
        color: AppColors.white,
        fontSize: FontSize.s16,
      ),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.neutral50,
    hintStyle: const TextStyle(
      color: AppColors.neutral500,
      fontSize: FontSize.s16,
      fontFamily: FontConstants.balooThambi2,
    ),
    labelStyle: const TextStyle(
      color: AppColors.neutral700,
      fontSize: FontSize.s18,
      fontWeight: FontWeight.w500,
      fontFamily: FontConstants.balooThambi2,
    ),
    floatingLabelStyle: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.primary,
      fontSize: FontSize.s18,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
    errorStyle: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.error,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: const BorderSide(color: AppColors.neutral300),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: const BorderSide(color: AppColors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: const BorderSide(color: AppColors.primary, width: AppSize.s2),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: const BorderSide(color: AppColors.error),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(RadiusSize.r4),
      borderSide: const BorderSide(color: AppColors.error, width: AppSize.s2),
    ),

    contentPadding: const EdgeInsets.all(AppPadding.p16),
  ),

  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: AppColors.primary,
    linearTrackColor: AppColors.neutral200,
    borderRadius: BorderRadius.circular(RadiusSize.r8),
  ),

  dialogTheme: DialogThemeData(
    backgroundColor: AppColors.white,
    elevation: 0,
    surfaceTintColor: AppColors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    titleTextStyle: getSemiBoldStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s18,
    ),
    contentTextStyle: getRegularStyle(
      fontFamily: FontConstants.balooThambi2,
      color: AppColors.black,
      fontSize: FontSize.s16,
    ),
  ),

  cardTheme: CardThemeData(
    color: AppColors.white,
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
      side: const BorderSide(color: AppColors.cardBorder),
    ),
  ),

  dividerTheme: const DividerThemeData(color: AppColors.neutral200),

  iconTheme: const IconThemeData(color: AppColors.neutral900),

  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
  ),

  checkboxTheme: CheckboxThemeData(
    fillColor: WidgetStateProperty.resolveWith(
      (states) => states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.white,
    ),
  ),
);
