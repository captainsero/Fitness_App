import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/meal_entity.dart';
import '../repo/food_details_repo.dart';

@injectable
class GetMealDetailsUseCase {

  GetMealDetailsUseCase({required this.repo});
  final FoodDetailsRepoContract repo;

  Future<BaseResponse<MealEntity>> call(String id) {
    return repo.getMealDetails(id);
  }
}
