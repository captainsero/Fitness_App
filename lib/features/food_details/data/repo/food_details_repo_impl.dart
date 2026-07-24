import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../domain/entities/meal_entity.dart';
import '../../domain/repo/food_details_repo.dart';
import '../data_sources/food_details_remote_data_source_contract.dart';

@Injectable(as: FoodDetailsRepoContract)
class FoodDetailsRepoImpl implements FoodDetailsRepoContract {
  FoodDetailsRepoImpl({required this.remoteDataSource});
  final FoodDetailsRemoteDataSourceContract remoteDataSource;

  @override
  Future<BaseResponse<MealEntity>> getMealDetails(String id) async {
    final response = await remoteDataSource.getMealDetails(id);
    switch (response) {
      case SuccessBaseResponse():
        final meals = response.data.meals;
        if (meals != null && meals.isNotEmpty) {
          final meal = meals.first.mapToEntity();
          return SuccessBaseResponse<MealEntity>(data: meal);
        }
        return const ErrorBaseResponse<MealEntity>(errorMessage: 'No meal found');

      default:
        return ErrorBaseResponse<MealEntity>(
          error: (response as ErrorBaseResponse).error,
        );
    }
  }
}
