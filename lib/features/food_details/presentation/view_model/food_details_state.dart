import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/handler/response_to_state_mapper.dart'
    show ResponseToStateMapper;
import '../../domain/entities/meal_entity.dart';
import 'food_details_cubit.dart' show FoodDetailsCubit;

/// State emitted by [FoodDetailsCubit].
///
/// A typedef over the app-wide [BaseState] so the food-details feature gets
/// its own named state type while reusing the shared loading/data/error
/// handling provided by [ResponseToStateMapper].
typedef FoodDetailsState = BaseState<MealEntity>;
