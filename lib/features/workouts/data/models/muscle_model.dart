import '../../domain/entities/muscle_entity.dart';

class MuscleModel {
  const MuscleModel({
    required this.id,
    required this.name,
    this.image,
  });

  factory MuscleModel.fromJson(Map<String, dynamic> json) {
    return MuscleModel(
      id: json['_id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      image: json['image']?.toString(),
    );
  }

  final String id;
  final String name;

  /// Nullable in the API response (e.g. "Medial Deltoids", "Soleus").
  final String? image;

  MuscleEntity toEntity() {
    return MuscleEntity(id: id, name: name, imageUrl: image);
  }
}
