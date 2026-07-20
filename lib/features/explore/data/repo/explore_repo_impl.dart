import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/repo/explore_repo_contract.dart';
import '../data_sources/explore_remote_data_source_contract.dart';
import '../models/muscle_model.dart';
import '../models/muscles_group_model.dart';

@Injectable(as: ExploreRepoContract)
class ExploreRepoImpl implements ExploreRepoContract {
  ExploreRepoImpl({
    required ExploreRemoteDataSourceContract remoteDataSourceContract,
  }) : _remoteDataSourceContract = remoteDataSourceContract;

  final ExploreRemoteDataSourceContract _remoteDataSourceContract;
  @override
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles() {
    return _remoteDataSourceContract.getRandomMuscles();
  }

  @override
  Future<BaseResponse<List<MusclesGroupModel>>> getMusclesGroup() {
    return _remoteDataSourceContract.getMusclesGroup();
  }

  @override
  Future<BaseResponse<List<MuscleModel>>> getMusclesByMusclesGroup({
    required String groupId,
  }) {
    return _remoteDataSourceContract.getMusclesByMusclesGroup(groupId: groupId);
  }
}
