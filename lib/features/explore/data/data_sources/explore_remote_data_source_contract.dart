import '../../../../config/base_response/base_response.dart';
import '../models/muscle_model.dart';
import '../models/muscles_group_model.dart';

abstract class ExploreRemoteDataSourceContract {
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles();
  Future<BaseResponse<List<MusclesGroupModel>>> getMusclesGroup();
}
