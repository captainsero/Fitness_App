import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../core/constants/api_constants/api_endpoints.dart';
import '../data/models/muscle_group_muscles_response_model.dart';
import '../data/models/muscle_groups_response_model.dart';
import '../data/models/muscles_response_model.dart';

part 'workouts_api.g.dart';

@lazySingleton
@RestApi()
abstract class WorkoutsApi {
  @factoryMethod
  factory WorkoutsApi(Dio dio) = _WorkoutsApi;

  /// 20 (all) prime-mover muscles, shuffled -- used for the "Full Body"
  /// tab.
  @GET(ApiEndpoints.randomPrimeMoverMuscles)
  Future<MusclesResponseModel> getRandomPrimeMoverMuscles();

  /// Every muscle group -- powers the Workouts tabs.
  @GET(ApiEndpoints.muscleGroups)
  Future<MuscleGroupsResponseModel> getAllMuscleGroups();

  /// Muscles belonging to one muscle group -- powers every tab except
  /// "Full Body".
  @GET(ApiEndpoints.musclesByGroup)
  Future<MuscleGroupMusclesResponseModel> getMusclesByGroup(
    @Query('muscleGroupId') String muscleGroupId,
  );
}
