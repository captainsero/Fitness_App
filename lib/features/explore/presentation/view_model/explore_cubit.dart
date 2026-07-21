import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/use_cases/get_meals_categories_use_case.dart';
import '../../domain/use_cases/get_muscles_by_muscles_group_use_case.dart';
import '../../domain/use_cases/get_muscles_group_use_case.dart';
import '../../domain/use_cases/get_random_muscles_use_case.dart';
import 'explore_event.dart';
import 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  ExploreCubit({
    required GetMealsCategoriesUseCase getMealsCategoriesUseCase,
    required GetMusclesByMusclesGroupUseCase getMusclesByMusclesGroupUseCase,
    required GetMusclesGroupUseCase getMusclesGroupUseCase,
    required GetRandomMusclesUseCase getRandomMusclesUseCase,
  }) : _getMealsCategoriesUseCase = getMealsCategoriesUseCase,
       _getMusclesByMusclesGroupUseCase = getMusclesByMusclesGroupUseCase,
       _getMusclesGroupUseCase = getMusclesGroupUseCase,
       _getRandomMusclesUseCase = getRandomMusclesUseCase,
       super(const ExploreState());

  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  final GetMusclesByMusclesGroupUseCase _getMusclesByMusclesGroupUseCase;
  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetRandomMusclesUseCase _getRandomMusclesUseCase;

  Future<void> onEvent(ExploreEvent event) async {
    if (event is GetMealsCategoriesEvent) {
      await _getMealsCategories();
    } else if (event is GetMusclesByMusclesGroupEvent) {
      await _getMusclesByMusclesGroup(event.groupId);
    } else if (event is GetMusclesGroupEvent) {
      await _getMusclesGroup();
    } else if (event is GetRandomMusclesEvent) {
      await _getRandomMuscles();
    }
  }

  Future<void> _getMealsCategories() async {
    emit(
      state.copyWith(getMealsCategoriesState: const BaseState(isLoading: true)),
    );

    final response = await _getMealsCategoriesUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getMealsCategoriesState: handler));
  }

  Future<void> _getMusclesGroup() async {
    emit(
      state.copyWith(getMusclesGroupState: const BaseState(isLoading: true)),
    );

    final response = await _getMusclesGroupUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getMusclesGroupState: handler));
  }

  Future<void> _getMusclesByMusclesGroup(String groupId) async {
    emit(
      state.copyWith(
        getMusclesByMusclesGroupState: const BaseState(isLoading: true),
      ),
    );

    final response = await _getMusclesByMusclesGroupUseCase(groupId: groupId);
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getMusclesByMusclesGroupState: handler));
  }

  Future<void> _getRandomMuscles() async {
    emit(
      state.copyWith(getRandomMusclesState: const BaseState(isLoading: true)),
    );

    final response = await _getRandomMusclesUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getRandomMusclesState: handler));
  }
}
