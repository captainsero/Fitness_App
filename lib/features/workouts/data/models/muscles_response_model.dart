import 'muscle_model.dart';

/// Shared response shape for both `GET /muscles` (all muscles) and
/// `GET /muscles/random` (20 random muscles):
/// ```json
/// {
///   "message": "success",
///   "totalMuscles": 20,
///   "muscles": [ { "_id": "...", "name": "...", "image": "..." }, ... ]
/// }
/// ```
class MusclesResponseModel {
  const MusclesResponseModel({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory MusclesResponseModel.fromJson(Map<String, dynamic> json) {
    final rawMuscles = json['muscles'] as List<dynamic>? ?? const [];

    return MusclesResponseModel(
      message: json['message']?.toString() ?? '',
      totalMuscles: (json['totalMuscles'] as num?)?.toInt() ?? 0,
      muscles: rawMuscles
          .map(
            (muscle) => MuscleModel.fromJson(muscle as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String message;
  final int totalMuscles;
  final List<MuscleModel> muscles;
}
