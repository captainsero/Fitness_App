import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/api_constants/api_endpoints.dart';
import '../data/models/login_response_model.dart';

part 'login_api.g.dart';

@lazySingleton
@RestApi()
abstract class LoginApi {
  @factoryMethod
  factory LoginApi(Dio dio) = _LoginApi;

  @POST(ApiEndpoints.signIn)
  Future<LoginResponseModel> signIn(@Body() Map<String, dynamic> body);
}
