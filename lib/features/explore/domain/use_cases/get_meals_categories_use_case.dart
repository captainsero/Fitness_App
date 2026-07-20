import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../entities/meals_category_entity.dart';
import '../repo/explore_repo_contract.dart';

@injectable
class GetMealsCategoriesUseCase {
  GetMealsCategoriesUseCase({required ExploreRepoContract repoContract})
    : _repoContract = repoContract;

  final ExploreRepoContract _repoContract;

  Future<BaseResponse<List<MealsCategoryEntity>>> call() {
    return _repoContract.getMealsCategories();
  }
}
