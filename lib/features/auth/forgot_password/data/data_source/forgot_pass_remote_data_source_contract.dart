import '../../../../../config/base_response/base_response.dart';
import '../models/forgot_pass_request.dart';
import '../models/forgot_password_response.dart';
import '../models/reset_password_request.dart';
import '../models/verify_otp_code_request.dart';

abstract interface class ForgotPassRemoteDataSourceContract {
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPasswordRequest request,
  );

  Future<BaseResponse<ForgotPasswordResponse>> verifyResetCode(
    VerifyOTPCodeRequestModel request,
  );

  Future<BaseResponse<ForgotPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  );
}
