import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants/api_endpoints.dart';
import '../../data/models/random_muscles_response.dart';

part 'explore_api_client.g.dart';

@lazySingleton
@RestApi()
abstract class ExploreApiClient {
  @factoryMethod
  factory ExploreApiClient(Dio dio) = _ExploreApiClient;

  @GET(ApiEndpoints.musclesRandom)
  Future<RandomMusclesResponse> getRandomMuscles();
}
