import 'package:equatable/equatable.dart';

/// A single Workouts tab.
///
/// [id] is the real `muscleGroupId` from `GET /musclesGroup`, except for
/// the synthetic "Full Body" tab (`id == null`), which isn't a real API
/// muscle group -- it's a client-side entry that maps to
/// `GET /muscles/random` instead of a filtered request.
class WorkoutCategoryEntity extends Equatable {
  const WorkoutCategoryEntity({required this.id, required this.name});

  final String? id;
  final String name;

  bool get isFullBody => id == null;

  @override
  List<Object?> get props => [id, name];
}
