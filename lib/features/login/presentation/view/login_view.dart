import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/di/di.dart';
import '../../../../config/validators/text_field_validator.dart';
import '../../../../core/constants/color_manager.dart';
import '../../../../core/constants/font_manager.dart';
import '../../../../core/constants/values_manager.dart';
import '../../../../core/errors/validation_error_localizer.dart';
import '../../../../core/router/route_path.dart';
import '../../../../generated/l10n.dart';
import '../view_model/login_cubit.dart';
import '../view_model/login_state.dart';
import '../widgets/login_text_field.dart';
import '../widgets/social_login_row.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<LoginCubit>(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<LoginCubit>().login(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.data != null) {
            context.go(RoutePath.exploreRoute);
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
              imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 5),
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
                padding: const EdgeInsets.only(top: AppPadding.p20),
                child: Column(
                  children: [
                    Image.asset(
                      AssetsConst.logo,
                      height: AppSize.s70,
                      errorBuilder: (context, error, stackTrace) =>
                      const SizedBox(height: AppSize.s70),
                    ),
                    const SizedBox(height: AppSize.s20),
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
                            s.welcomeBack,
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
                    const SizedBox(height: AppSize.s20),
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppPadding.p20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(
                          AppPadding.p20,
                          AppPadding.p20,
                          AppPadding.p20,
                          AppPadding.p20,
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
                          autovalidateMode:
                          AutovalidateMode.onUserInteraction,
                          child: Column(
                            children: [
                              Text(
                                s.login,
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontFamily: FontConstants.balooThambi2,
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: FontSize.s24,
                                ),
                              ),
                              const SizedBox(height: AppSize.s8),
                              LoginTextField(
                                controller: _emailController,
                                hintText: s.email,
                                prefixIcon: Icons.email_outlined,
                                keyboardType: TextInputType.emailAddress,
                                validator: (value) => AppTextFieldValidator
                                    .validateEmail(value)
                                    ?.localize(s),
                              ),
                              const SizedBox(height: AppSize.s8),
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
                                        () =>
                                    _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                                validator: (value) => AppTextFieldValidator
                                    .validatePassword(value)
                                    ?.localize(s),
                              ),
                              const SizedBox(height: AppSize.s8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    s.forgetPassword,
                                    style: const TextStyle(
                                      color: AppColors.primaryLight3,
                                      fontFamily: FontConstants.balooThambi2,
                                      fontSize: FontSize.s14,
                                    ),
                                  ),
                                ),
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
                                        fontFamily:
                                        FontConstants.balooThambi2,
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
                              const SizedBox(height: AppSize.s8),
                              const SocialLoginRow(),
                              const SizedBox(height: AppSize.s8),
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  final isLoading = state.isLoading ?? false;
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed:
                                      isLoading ? null : _onLoginPressed,
                                      child: isLoading
                                          ? const SizedBox(
                                        height: AppSize.s20,
                                        width: AppSize.s20,
                                        child:
                                        CircularProgressIndicator(
                                          strokeWidth: AppSize.s2,
                                          color: AppColors.white,
                                        ),
                                      )
                                          : Text(s.login),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: AppSize.s8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      s.dontHaveAccountYet,
                                      style: const TextStyle(
                                        color: AppColors.neutral300,
                                        fontFamily:
                                        FontConstants.balooThambi2,
                                        fontSize: FontSize.s14,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: Text(
                                      s.register,
                                      style: const TextStyle(
                                        color: AppColors.primaryLight3,
                                        fontFamily:
                                        FontConstants.balooThambi2,
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
      ),
    );
  }
}