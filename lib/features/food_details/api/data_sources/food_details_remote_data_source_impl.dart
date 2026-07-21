import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../data/data_sources/food_details_remote_data_source_contract.dart';
import '../../data/models/meals_response_model.dart';
import '../api_client/food_details_api_client.dart';

@Injectable(as: FoodDetailsRemoteDataSourceContract)
class FoodDetailsRemoteDataSourceImpl
    implements FoodDetailsRemoteDataSourceContract {
  FoodDetailsRemoteDataSourceImpl({required this.apiClient});
  final FoodDetailsApiClient apiClient;

  @override
  Future<BaseResponse<MealsResponseModel>> getMealDetails(String id) async {
    try {
      final response = await apiClient.getMealDetails(id);
      return SuccessBaseResponse<MealsResponseModel>(data: response);
    } catch (e) {
      return ErrorBaseResponse<MealsResponseModel>(error: e.toString());
    }
  }
}
