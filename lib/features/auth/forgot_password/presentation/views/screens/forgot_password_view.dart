import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/shared_widgets/primary_button.dart';
import '../../../data/models/forgot_pass_request.dart';
import '../../view_model/cubit/forgot_password_cubit.dart';
import '../../view_model/cubit/forgot_password_state.dart';
import '../widgets/frosted_card.dart';
import '../widgets/glass_background_wrapper.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onSendOtpPressed(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      // استدعاء الـ UseCase من خلال الـ Cubit
      context.read<ForgotPasswordCubit>().forgotPassword(
        ForgotPasswordRequest(email: _emailController.text.trim()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassBackgroundWrapper(
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) =>
            previous.forgotPasswordState != current.forgotPasswordState,
        listener: (context, state) {
          final forgotState = state.forgotPasswordState;
          if (forgotState.errorMessage != null &&
              forgotState.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(forgotState.errorMessage!)),
            );
          } else if (forgotState.data != null && !forgotState.isLoading) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ForgotPasswordCubit>(),
                  child: OtpVerificationScreen(
                    email: _emailController.text.trim(),
                  ),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.forgotPasswordState.isLoading;

          return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              children: [
                const Icon(
                  Icons.fitness_center,
                  size: 60,
                  color: Color(0xFFFF4500),
                ),
                const SizedBox(height: 30),
                FrostedCard(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Enter Your Email",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Forget Password",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      autofillHints: const [AutofillHints.email],
                      style: const TextStyle(color: Colors.white),
                      decoration: _inputDecoration(
                        hint: "Email",
                        icon: Icons.email_outlined,
                      ),
                      validator: (val) {
                        if (val == null || val.isEmpty)
                          return "Please enter your email";
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(val)) {
                          return "Enter a valid email address";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    PrimaryOrangeButton(
                      label: "Sent OTP",
                      isLoading: isLoading,
                      onPressed: () => _onSendOtpPressed(context),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
