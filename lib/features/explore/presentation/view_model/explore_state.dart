import 'package:equatable/equatable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../data/models/muscle_model.dart';
import '../../data/models/muscles_group_model.dart';
import '../../domain/entities/meals_category_entity.dart';

class ExploreState extends Equatable {
  const ExploreState({
    this.getMealsCategoriesState = const BaseState<List<MealsCategoryEntity>>(),
    this.getMusclesByMusclesGroupState = const BaseState<List<MuscleModel>>(),
    this.getMusclesGroupState = const BaseState<List<MusclesGroupModel>>(),
    this.getRandomMusclesState = const BaseState<List<MuscleModel>>(),
  });

  ExploreState copyWith({
    BaseState<List<MealsCategoryEntity>>? getMealsCategoriesState,
    BaseState<List<MuscleModel>>? getMusclesByMusclesGroupState,
    BaseState<List<MusclesGroupModel>>? getMusclesGroupState,
    BaseState<List<MuscleModel>>? getRandomMusclesState,
  }) => ExploreState(
    getMealsCategoriesState:
        getMealsCategoriesState ?? this.getMealsCategoriesState,
    getMusclesByMusclesGroupState:
        getMusclesByMusclesGroupState ?? this.getMusclesByMusclesGroupState,
    getMusclesGroupState: getMusclesGroupState ?? this.getMusclesGroupState,
    getRandomMusclesState: getRandomMusclesState ?? this.getRandomMusclesState,
  );

  final BaseState<List<MealsCategoryEntity>> getMealsCategoriesState;
  final BaseState<List<MuscleModel>> getMusclesByMusclesGroupState;
  final BaseState<List<MusclesGroupModel>> getMusclesGroupState;
  final BaseState<List<MuscleModel>> getRandomMusclesState;

  @override
  List<Object?> get props => [
    getMealsCategoriesState,
    getMusclesByMusclesGroupState,
    getMusclesGroupState,
    getRandomMusclesState,
  ];
}
