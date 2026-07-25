import '../../../../config/base_response/base_response.dart';
import '../entities/meal_entity.dart';

abstract interface class FoodDetailsRepoContract {
  Future<BaseResponse<MealEntity>> getMealDetails(String id);
}
