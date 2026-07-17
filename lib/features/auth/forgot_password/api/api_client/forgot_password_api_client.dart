import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../../core/constants/api_constants/api_endpoints.dart';
import '../../data/models/forgot_password_response.dart';
part 'forgot_password_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ForgotPasswordApiClient {
  @factoryMethod
  factory ForgotPasswordApiClient(Dio dio) = _ForgotPasswordApiClient;

  @POST(ApiEndpoints.forgotPassword)
  Future<ForgotPasswordResponse> forgotPassword({
    @Body() Map<String, dynamic> body,
  });
}
