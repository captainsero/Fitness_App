import 'package:equatable/equatable.dart';

import '../../../../../../config/base_state/base_state.dart';
import '../../../data/models/forgot_password_response.dart';

class ForgotPasswordState extends Equatable {
  const ForgotPasswordState({
    BaseState<ForgotPasswordResponse>? forgotPasswordState,
    BaseState<ForgotPasswordResponse>? verifyOTPCodeState,
    BaseState<ForgotPasswordResponse>? resetPasswordState,
  }) : forgotPasswordState = forgotPasswordState ?? const BaseState(),
       verifyOTPCodeState = verifyOTPCodeState ?? const BaseState(),
       resetPasswordState = resetPasswordState ?? const BaseState();

  final BaseState<ForgotPasswordResponse> forgotPasswordState;
  final BaseState<ForgotPasswordResponse> verifyOTPCodeState;
  final BaseState<ForgotPasswordResponse> resetPasswordState;

  @override
  List<Object?> get props => [
    forgotPasswordState,
    verifyOTPCodeState,
    resetPasswordState,
  ];

  ForgotPasswordState copyWith({
    BaseState<ForgotPasswordResponse>? forgotPasswordState,
    BaseState<ForgotPasswordResponse>? verifyOTPCodeState,
    BaseState<ForgotPasswordResponse>? resetPasswordState,
  }) {
    return ForgotPasswordState(
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      verifyOTPCodeState: verifyOTPCodeState ?? this.verifyOTPCodeState,
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }
}
