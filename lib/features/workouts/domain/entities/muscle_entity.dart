import 'package:equatable/equatable.dart';

/// A single prime mover muscle, as returned by `GET /muscles`,
/// `GET /muscles/random`, and `GET /musclesGroup/by-muscle-group`
/// (see `MuscleModel`).
class MuscleEntity extends Equatable {
  const MuscleEntity({
    required this.id,
    required this.name,
    this.imageUrl,
  });

  final String id;
  final String name;

  /// Nullable -- some muscles in the API response have `"image": null`.
  final String? imageUrl;

  @override
  List<Object?> get props => [id, name, imageUrl];
}
