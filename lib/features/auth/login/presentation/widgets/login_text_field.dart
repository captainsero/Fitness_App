import 'package:flutter/material.dart';

import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';



class LoginTextField extends StatelessWidget {
  const LoginTextField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    super.key,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      keyboardType: keyboardType,
      validator: validator,
      style: const TextStyle(
        color: AppColors.white,
        fontFamily: FontConstants.balooThambi2,
        fontSize: FontSize.s16,
      ),
      cursorColor: AppColors.primary,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: AppColors.neutral400,
          fontFamily: FontConstants.balooThambi2,
          fontSize: FontSize.s16,
        ),
        prefixIcon: Icon(prefixIcon, color: AppColors.neutral400),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.white.withAlpha(15),
        errorStyle: const TextStyle(
          color: AppColors.primaryLight4,
          fontFamily: FontConstants.balooThambi2,
          fontSize: FontSize.s12,
        ),
        contentPadding: const EdgeInsets.symmetric(
          vertical: AppPadding.p16,
          horizontal: AppPadding.p12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusSize.r100),
          borderSide: BorderSide(color: AppColors.white.withAlpha(40)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusSize.r100),
          borderSide: BorderSide(color: AppColors.white.withAlpha(40)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusSize.r100),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: AppSize.s1_5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusSize.r100),
          borderSide: const BorderSide(color: AppColors.primaryLight4),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(RadiusSize.r100),
          borderSide: const BorderSide(color: AppColors.primaryLight4),
        ),
      ),
    );
  }
}
