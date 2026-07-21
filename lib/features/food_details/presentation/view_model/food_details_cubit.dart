import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/use_cases/get_meal_details_use_case.dart';
import 'food_details_state.dart';

@injectable
class FoodDetailsCubit extends Cubit<FoodDetailsState> {
  FoodDetailsCubit(this._getMealDetailsUseCase) : super(const BaseState());

  final GetMealDetailsUseCase _getMealDetailsUseCase;

  Future<void> getMealDetails(String id) async {
    emit(const BaseState(isLoading: true));

    final response = await _getMealDetailsUseCase(id);

    emit(ResponseToStateMapper.handle(response));
  }
}
