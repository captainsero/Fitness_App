import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../config/base_state/base_state.dart';
import '../../../../../../config/handler/response_to_state_mapper.dart';
import '../../../data/models/forgot_pass_request.dart';
import '../../../data/models/reset_password_request.dart';
import '../../../data/models/verify_otp_code_request.dart';
import '../../../domain/use_case/forgot_pass_use_case.dart';
import '../../../domain/use_case/reset_password_use_case.dart';
import '../../../domain/use_case/verify_otp_code_use_case.dart';
import 'forgot_password_state.dart';

@injectable
class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit(
    super.initialState, {
    required this.forgotPasswordUseCase,
    required this.verifyOTPCodeUseCase,
    required this.resetPasswordUseCase,
  });

  final ForgotPasswordUseCase forgotPasswordUseCase;
  final VerifyOTPCodeUseCase verifyOTPCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  Future<void> forgotPassword(ForgotPasswordRequest request) async {
    emit(state.copyWith(forgotPasswordState: const BaseState(isLoading: true)));
    final response = await forgotPasswordUseCase.forgotPassword(request);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        forgotPasswordState: BaseState(
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> verifyOTP(VerifyOTPCodeRequestModel request) async {
    emit(state.copyWith(verifyOTPCodeState: const BaseState(isLoading: true)));
    final response = await verifyOTPCodeUseCase.call(request);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        verifyOTPCodeState: BaseState(
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }

  Future<void> resetPassword(ResetPasswordRequest request) async {
    emit(state.copyWith(resetPasswordState: const BaseState(isLoading: true)));
    final response = await resetPasswordUseCase.call(request);
    final handler = ResponseToStateMapper.handle(response);

    emit(
      state.copyWith(
        resetPasswordState: BaseState(
          data: handler.data,
          errorMessage: handler.errorMessage,
        ),
      ),
    );
  }
}
