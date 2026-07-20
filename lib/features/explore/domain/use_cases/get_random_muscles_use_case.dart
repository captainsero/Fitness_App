import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/models/muscle_model.dart';
import '../repo/explore_repo_contract.dart';

@injectable
class GetRandomMusclesUseCase {
  GetRandomMusclesUseCase({required ExploreRepoContract repoContract})
    : _repoContract = repoContract;

  final ExploreRepoContract _repoContract;

  Future<BaseResponse<List<MuscleModel>>> call() {
    return _repoContract.getRandomMuscles();
  }
}
