class MuscleGroupModel {
  const MuscleGroupModel({required this.id, required this.name});

  factory MuscleGroupModel.fromJson(Map<String, dynamic> json) {
    return MuscleGroupModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }

  final String id;

  /// English name as returned by `GET /muscles` (confirmed via live
  /// network logs) -- used directly as the Workouts tab label.
  final String name;
}
