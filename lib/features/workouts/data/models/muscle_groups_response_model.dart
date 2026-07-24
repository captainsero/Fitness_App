.import 'muscle_group_model.dart';

/// Response shape of `GET /muscles` (confirmed via live network logs --
/// despite the name, this bare endpoint returns muscle GROUPS, not
/// individual muscles; `GET /muscles/random` is the individual-muscles
/// endpoint):
/// ```json
/// {
///   "message": "success",
///   "musclesGroup": [ { "_id": "...", "name": "..." }, ... ]
/// }
/// ```
class MuscleGroupsResponseModel {
  const MuscleGroupsResponseModel({
    required this.message,
    required this.groups,
  });

  factory MuscleGroupsResponseModel.fromJson(Map<String, dynamic> json) {
    final rawGroups = json['musclesGroup'] as List<dynamic>? ?? const [];

    return MuscleGroupsResponseModel(
      message: json['message']?.toString() ?? '',
      groups: rawGroups
          .map(
            (group) =>
                MuscleGroupModel.fromJson(group as Map<String, dynamic>),
          )
          .toList(),
    );
  }

  final String message;
  final List<MuscleGroupModel> groups;
}
