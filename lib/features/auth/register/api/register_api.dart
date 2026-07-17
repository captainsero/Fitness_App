import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../../core/constants/api_constants/api_endpoints.dart';
import '../data/models/register_response_model.dart';

part 'register_api.g.dart';

@lazySingleton
@RestApi()
abstract class RegisterApi {
  @factoryMethod
  factory RegisterApi(Dio dio) = _RegisterApi;

  @POST(ApiEndpoints.signUp)
  Future<RegisterResponseModel> signUp(
      @Body() Map<String, dynamic> body,
      );
}