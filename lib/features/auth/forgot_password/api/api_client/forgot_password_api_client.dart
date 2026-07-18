import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/api_constants/api_endpoints.dart';
import '../../data/models/forgot_pass_request.dart';
import '../../data/models/forgot_password_response.dart';
import '../../data/models/reset_password_request.dart';
import '../../data/models/verify_otp_code_request.dart';
part 'forgot_password_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ForgotPasswordApiClient {
  @factoryMethod
  factory ForgotPasswordApiClient(Dio dio) = _ForgotPasswordApiClient;

  @POST(ApiEndpoints.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword({
    @Body() ForgotPasswordRequest body,
  });

  @POST(ApiEndpoints.verifyResetCode)
  Future<ForgotPasswordResponse> verifyResetCode({
    @Body() VerifyOTPCodeRequestModel resetCode,
  });

  @PUT(ApiEndpoints.resetPassword)
  Future<ForgotPasswordResponse> resetPassword({
    @Body() ResetPasswordRequest newPassword,
  });
}
