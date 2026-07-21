import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants/api_endpoints.dart';
import '../../data/models/meals_response_model.dart';

part 'food_details_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class FoodDetailsApiClient {
  @factoryMethod
  factory FoodDetailsApiClient(Dio dio) = _FoodDetailsApiClient;

  @GET(ApiEndpoints.getMealDetails)
  Future<MealsResponseModel> getMealDetails(@Query('i') String id);
}
