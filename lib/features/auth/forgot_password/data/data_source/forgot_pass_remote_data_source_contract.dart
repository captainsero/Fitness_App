import '../../../../../config/base_response/base_response.dart';
import '../models/forgot_pass_request.dart';
import '../models/forgot_password_response.dart';

abstract interface class ForgotPassRemoteDataSourceContract {
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPassRequest request,
  );
}
