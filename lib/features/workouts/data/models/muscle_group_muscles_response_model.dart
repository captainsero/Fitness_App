import 'muscle_model.dart';

/// Response shape of `GET /musclesGroup/by-muscle-group?muscleGroupId=...`:
/// ```json
/// {
///   "message": "success",
///   "muscleGroup": { "_id": "...", "name": "..." },
///   "muscles": [ { "_id": "...", "name": "...", "image": "..." }, ... ]
/// }
/// ```
///
/// Returns English names/images directly (confirmed via live network
/// logs), so `WorkoutsRepositoryImpl` uses `muscles` from this response
/// as-is -- no cross-referencing against another endpoint needed.
class MuscleGroupMusclesResponseModel {
  const MuscleGroupMusclesResponseModel({
    required this.message,
    required this.muscles,
  });

  factory MuscleGroupMusclesResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    final rawMuscles = json['muscles'] as List<dynamic>? ?? const [];

    return MuscleGroupMusclesResponseModel(
      message: json['message']?.toString() ?? '',
      muscles: rawMuscles
          .map(
            (muscle) => MuscleModel.fromJson(muscle as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String message;
  final List<MuscleModel> muscles;
}
