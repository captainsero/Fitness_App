import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../config/di/di.dart';
import '../../../../../config/validators/text_field_validator.dart';
import '../../../../../core/constants/color_manager.dart';
import '../../../../../core/constants/font_manager.dart';
import '../../../../../core/constants/values_manager.dart';
import '../../../../../core/errors/validation_error_localizer.dart';
import '../../../../../core/router/route_path.dart';
import '../../../../../generated/l10n.dart';
import '../../../login/presentation/widgets/login_text_field.dart';
import '../../../login/presentation/widgets/social_login_row.dart';
import '../models/register_form_data.dart';

/// Registration screen -- step 1 of the sign-up flow.
///
/// Collects name/email/password only. Gender is required by
/// `POST /auth/signup` too, but it's collected on the next screen
/// ([SelectGenderView]) as part of the existing onboarding UI -- so this
/// screen validates its fields and hands them off via
/// [RegisterFormData], rather than calling the API itself. The actual
/// signup call happens once gender is known.
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _formKey = GlobalKey<FormState>();

  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onRegisterPressed() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.push(
      RoutePath.selectGenderRoute,
      extra: RegisterFormData(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
      ),
    );
  }

  void _onLoginTap() {
    context.go(RoutePath.loginRoute);
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
              padding: const EdgeInsets.only(top: AppPadding.p40),
              child: Column(
                children: [
                  Image.asset(
                    AssetsConst.logo,
                    height: AppSize.s70,
                    errorBuilder: (context, error, stackTrace) =>
                    const SizedBox(height: AppSize.s70),
                  ),
                  const SizedBox(height: AppSize.s30),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          s.heyThere,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontFamily: FontConstants.balooThambi2,
                            fontSize: FontSize.s18,
                          ),
                        ),
                        Text(
                          s.createAnAccount,
                          style: const TextStyle(
                            color: AppColors.white,
                            fontFamily: FontConstants.balooThambi2,
                            fontWeight: FontWeightManager.bold,
                            fontSize: FontSize.s24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSize.s30),
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppPadding.p30),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(
                        AppPadding.p30,
                        AppPadding.p30,
                        AppPadding.p30,
                        AppPadding.p30,
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
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            Text(
                              s.register,
                              style: const TextStyle(
                                color: AppColors.white,
                                fontFamily: FontConstants.balooThambi2,
                                fontWeight: FontWeightManager.bold,
                                fontSize: FontSize.s24,
                              ),
                            ),
                            const SizedBox(height: AppSize.s24),
                            LoginTextField(
                              controller: _firstNameController,
                              hintText: s.firstName,
                              prefixIcon: Icons.person_outline,
                              keyboardType: TextInputType.name,
                              validator: (value) => AppTextFieldValidator
                                  .validateName(value)
                                  ?.localize(s),
                            ),
                            const SizedBox(height: AppSize.s16),
                            LoginTextField(
                              controller: _lastNameController,
                              hintText: s.lastName,
                              prefixIcon: Icons.person_outline,
                              keyboardType: TextInputType.name,
                              validator: (value) => AppTextFieldValidator
                                  .validateName(value)
                                  ?.localize(s),
                            ),
                            const SizedBox(height: AppSize.s16),
                            LoginTextField(
                              controller: _emailController,
                              hintText: s.email,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) => AppTextFieldValidator
                                  .validateEmail(value)
                                  ?.localize(s),
                            ),
                            const SizedBox(height: AppSize.s16),
                            LoginTextField(
                              controller: _passwordController,
                              hintText: s.password,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.neutral400,
                                ),
                                onPressed: () => setState(
                                      () => _obscurePassword = !_obscurePassword,
                                ),
                              ),
                              validator: (value) => AppTextFieldValidator
                                  .validatePassword(value)
                                  ?.localize(s),
                            ),
                            const SizedBox(height: AppSize.s16),
                            LoginTextField(
                              controller: _confirmPasswordController,
                              hintText: s.confirmPasswordHint,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscureConfirmPassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureConfirmPassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  color: AppColors.neutral400,
                                ),
                                onPressed: () => setState(
                                      () => _obscureConfirmPassword =
                                      !_obscureConfirmPassword,
                                ),
                              ),
                              validator: (value) =>
                                  AppTextFieldValidator.validateConfirmPassword(
                                    value,
                                    _passwordController.text,
                                  )?.localize(s),
                            ),
                            const SizedBox(height: AppSize.s8),
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: AppColors.white.withAlpha(50),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppPadding.p12,
                                  ),
                                  child: Text(
                                    s.or,
                                    style: const TextStyle(
                                      color: AppColors.neutral400,
                                      fontFamily: FontConstants.balooThambi2,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: AppColors.white.withAlpha(50),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSize.s20),
                            const SocialLoginRow(),
                            const SizedBox(height: AppSize.s30),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: _onRegisterPressed,
                                child: Text(s.register),
                              ),
                            ),
                            const SizedBox(height: AppSize.s20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: Text(
                                    s.alreadyHaveAnAccount,
                                    style: const TextStyle(
                                      color: AppColors.neutral300,
                                      fontFamily: FontConstants.balooThambi2,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: _onLoginTap,
                                  child: Text(
                                    s.login,
                                    style: const TextStyle(
                                      color: AppColors.primaryLight3,
                                      fontFamily: FontConstants.balooThambi2,
                                      fontWeight: FontWeightManager.bold,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ),
                              ],
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
