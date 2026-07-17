import '../../../../../config/base_response/base_response.dart';
import '../../data/models/forgot_pass_request.dart';
import '../../data/models/forgot_password_response.dart';

abstract interface class ForgotPassRepoContract {
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPassRequest request,
  );
}
