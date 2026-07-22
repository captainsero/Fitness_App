sealed class ExploreEvent {}

class GetMealsCategoriesEvent extends ExploreEvent {}

class GetMusclesByMusclesGroupEvent extends ExploreEvent {
  GetMusclesByMusclesGroupEvent({required this.groupId});

  final String groupId;
}

class GetMusclesGroupEvent extends ExploreEvent {}

class GetRandomMusclesEvent extends ExploreEvent {}

class GetExerciseByMuscleDifficultyEvent extends ExploreEvent {}

class SelectMusclesGroupEvent extends ExploreEvent {
  SelectMusclesGroupEvent({required this.index});

  final int index;
}

