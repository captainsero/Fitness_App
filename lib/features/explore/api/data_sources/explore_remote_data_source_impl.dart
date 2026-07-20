import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/data_sources/explore_remote_data_source_contract.dart';
import '../../data/models/muscle_model.dart';
import '../api_client/explore_api_client.dart';

@Injectable(as: ExploreRemoteDataSourceContract)
class ExploreRemoteDataSourceImpl implements ExploreRemoteDataSourceContract {
  ExploreRemoteDataSourceImpl({required ExploreApiClient apiClient})
    : _apiClient = apiClient;

  final ExploreApiClient _apiClient;
  @override
  Future<BaseResponse<List<MuscleModel>>> getRandomMuscles() async {
    try {
      final response = await _apiClient.getRandomMuscles();
      return SuccessBaseResponse<List<MuscleModel>>(
        data: response.muscles ?? [],
      );
    } catch (e) {
      return ErrorBaseResponse<List<MuscleModel>>(error: e);
    }
  }
}
