import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/models/muscles_group_model.dart';
import '../repo/explore_repo_contract.dart';

@injectable
class GetMusclesGroupUseCase {
  GetMusclesGroupUseCase({required ExploreRepoContract repoContract})
    : _repoContract = repoContract;

  final ExploreRepoContract _repoContract;

  Future<BaseResponse<List<MusclesGroupModel>>> call() {
    return _repoContract.getMusclesGroup();
  }
}
