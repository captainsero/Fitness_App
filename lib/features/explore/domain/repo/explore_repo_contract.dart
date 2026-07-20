import '../../../../config/base_response/base_response.dart';
import '../../data/models/muscle_model.dart';
import '../../data/models/muscles_group_model.dart';

abstract class ExploreRepoContract {
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles();
  Future<BaseResponse<List<MusclesGroupModel>>> getMusclesGroup();
}
