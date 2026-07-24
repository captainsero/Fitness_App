import 'muscle_model.dart';

/// Response shape of `GET /muscle/random`:
/// ```json
/// {
///   "message": "success",
///   "totalMuscles": 20,
///   "muscles": [ { "_id": "...", "name": "...", "image": "..." }, ... ]
/// }
/// ```
class RandomMusclesResponseModel {
  const RandomMusclesResponseModel({
    required this.message,
    required this.totalMuscles,
    required this.muscles,
  });

  factory RandomMusclesResponseModel.fromJson(Map<String, dynamic> json) {
    final rawMuscles = json['muscles'] as List? ?? const [];

    return RandomMusclesResponseModel(
      message: json['message']?.toString() ?? '',
      totalMuscles: (json['totalMuscles'] as num?)?.toInt() ?? 0,
      muscles: rawMuscles
          .map(
            (muscle) =>
                MuscleModel.fromJson(Map<String, dynamic>.from(muscle as Map)),
          )
          .toList(),
    );
  }

  final String message;
  final int totalMuscles;
  final List<MuscleModel> muscles;
}
