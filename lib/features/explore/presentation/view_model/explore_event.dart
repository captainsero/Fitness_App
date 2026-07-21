sealed class ExploreEvent {}

class GetMealsCategoriesEvent extends ExploreEvent {}

class GetMusclesByMusclesGroupEvent extends ExploreEvent {
  final String groupId;

  GetMusclesByMusclesGroupEvent({required this.groupId});
}
class GetMusclesGroupEvent extends ExploreEvent{}

class GetRandomMusclesEvent extends ExploreEvent{}
