import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/use_cases/get_exercise_by_muscle_difficulty_use_case.dart';
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
    required GetExerciseByMuscleDifficultyUseCase
        getExerciseByMuscleDifficultyUseCase,
  }) : _getMealsCategoriesUseCase = getMealsCategoriesUseCase,
       _getMusclesByMusclesGroupUseCase = getMusclesByMusclesGroupUseCase,
       _getMusclesGroupUseCase = getMusclesGroupUseCase,
       _getRandomMusclesUseCase = getRandomMusclesUseCase,
       _getExerciseByMuscleDifficultyUseCase =
           getExerciseByMuscleDifficultyUseCase,
       super(const ExploreState());

  final GetMealsCategoriesUseCase _getMealsCategoriesUseCase;
  final GetMusclesByMusclesGroupUseCase _getMusclesByMusclesGroupUseCase;
  final GetMusclesGroupUseCase _getMusclesGroupUseCase;
  final GetRandomMusclesUseCase _getRandomMusclesUseCase;
  final GetExerciseByMuscleDifficultyUseCase
      _getExerciseByMuscleDifficultyUseCase;

  Future<void> init() async {
    unawaited(onEvent(GetRandomMusclesEvent()));
    unawaited(onEvent(GetMealsCategoriesEvent()));
    unawaited(onEvent(GetExerciseByMuscleDifficultyEvent()));
    await onEvent(GetMusclesGroupEvent());
  }

  Future<void> onEvent(ExploreEvent event) async {
    if (event is GetMealsCategoriesEvent) {
      await _getMealsCategories();
    } else if (event is GetMusclesByMusclesGroupEvent) {
      await _getMusclesByMusclesGroup(event.groupId);
    } else if (event is GetMusclesGroupEvent) {
      await _getMusclesGroup();
    } else if (event is GetRandomMusclesEvent) {
      await _getRandomMuscles();
    } else if (event is GetExerciseByMuscleDifficultyEvent) {
      await _getExerciseByMuscleDifficulty();
    } else if (event is SelectMusclesGroupEvent) {
      await _selectMusclesGroup(event.index);
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

    // After fetching muscles groups, automatically fetch
    // muscles for the first group
    if (handler.data != null && handler.data!.isNotEmpty) {
      final firstGroupId = handler.data!.first.id;
      if (firstGroupId != null) {
        await _getMusclesByMusclesGroup(firstGroupId);
      }
    }
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

  Future<void> _selectMusclesGroup(int index) async {
    emit(state.copyWith(selectedMusclesGroupIndex: index));

    final musclesGroups = state.getMusclesGroupState.data;
    if (musclesGroups != null && index < musclesGroups.length) {
      final groupId = musclesGroups[index].id;
      if (groupId != null) {
        await _getMusclesByMusclesGroup(groupId);
      }
    }
  }

  Future<void> _getRandomMuscles() async {
    emit(
      state.copyWith(getRandomMusclesState: const BaseState(isLoading: true)),
    );

    final response = await _getRandomMusclesUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getRandomMusclesState: handler));
  }

  Future<void> _getExerciseByMuscleDifficulty() async {
    emit(
      state.copyWith(
        getExerciseByMuscleDifficultyState: const BaseState(isLoading: true),
      ),
    );

    final response = await _getExerciseByMuscleDifficultyUseCase();
    final handler = ResponseToStateMapper.handle(response);

    emit(state.copyWith(getExerciseByMuscleDifficultyState: handler));
  }
}

