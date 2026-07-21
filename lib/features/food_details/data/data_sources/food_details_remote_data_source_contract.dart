import '../../../../config/base_response/base_response.dart';
import '../models/meals_response_model.dart';

abstract interface class FoodDetailsRemoteDataSourceContract {
  Future<BaseResponse<MealsResponseModel>> getMealDetails(String id);
}
