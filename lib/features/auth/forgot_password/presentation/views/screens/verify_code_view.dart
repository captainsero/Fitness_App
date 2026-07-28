
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/shared_widgets/primary_button.dart';
import '../../../data/models/forgot_pass_request.dart';
import '../../view_model/cubit/forgot_password_cubit.dart';
import '../widgets/frosted_card.dart';
import '../widgets/glass_background_wrapper.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({required this.email ,super.key });
  final String email;

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onConfirmPressed(BuildContext context) {
    String otp = _controllers.map((e) => e.text).join();
    if (otp.length == 4) {
      FocusScope.of(context).unfocus();
      context.read<ForgotPasswordCubit>().verifyOTP(
        VerifyOTPCodeRequestModel(email: widget.email, code: otp),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter complete 4-digit code")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GlassBackgroundWrapper(
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) =>
            previous.verifyOTPCodeState != current.verifyOTPCodeState,
        listener: (context, state) {
          final verifyState = state.verifyOTPCodeState;
          if (verifyState.errorMessage != null && verifyState.errorMessage!.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(verifyState.errorMessage!)),
            );
          } else if (verifyState.data != null && !verifyState.isLoading) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: context.read<ForgotPasswordCubit>(),
                  child: CreatePasswordScreen(email: widget.email),
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state.verifyOTPCodeState.isLoading;

          return Column(
            children: [
              const Icon(Icons.fitness_center, size: 60, color: Color(0xFFFF4500)),
              const SizedBox(height: 30),
              FrostedCard(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("OTP CODE", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Enter Your OTP Check Your Email", style: TextStyle(color: Colors.white70, fontSize: 13)),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 50,
                        child: TextFormField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                          enableInteractiveSelection: false,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(1),
                          ],
                          decoration: const InputDecoration(
                            counterText: "",
                            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white54, width: 2)),
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFFFF4500), width: 3)),
                          ),
                          onChanged: (val) => _onOtpChanged(val, index),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 30),
                  PrimaryOrangeButton(
                    label: "Confirm",
                    isLoading: isLoading,
                    onPressed: () => _onConfirmPressed(context),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () {
                      context.read<ForgotPasswordCubit>().forgotPassword(
                        ForgotPasswordRequest(email: widget.email),
                      );
                    },
                    child: const Text("Resend Code?", style: TextStyle(color: Color(0xFFFF4500), fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}