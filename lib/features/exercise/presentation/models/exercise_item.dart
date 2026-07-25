/// Difficulty level for an [ExerciseItem].
///
/// Kept as a typed enum instead of a raw string so the UI can safely
/// switch on it, while still being trivial to map to/from whatever your
/// backend sends.
enum ExerciseDifficulty {
  beginner,
  intermediate,
  advanced;

  /// Parses a difficulty value coming from an API response
  /// (e.g. `"intermediate"`). Falls back to [beginner] for
  /// unknown/missing values instead of throwing, since a single bad
  /// record shouldn't crash the whole list.
  static ExerciseDifficulty fromApi(String? value) {
    switch (value?.toLowerCase().trim()) {
      case 'intermediate':
        return ExerciseDifficulty.intermediate;
      case 'advanced':
        return ExerciseDifficulty.advanced;
      case 'beginner':
      default:
        return ExerciseDifficulty.beginner;
    }
  }

  /// Serializes back to the string the API expects.
  String toApi() => name;
}

/// A single exercise entry (e.g. "Bench Press") shown inside [ExerciseView].
///
/// This is a plain, immutable data class on purpose — it has no knowledge
/// of Flutter widgets or of where the data came from, so the same model
/// can be reused by a repository/bloc/provider once you wire up the API.
class ExerciseItem {
  const ExerciseItem({
    this.id,
    required this.imagePath,
    required this.title,
    required this.sets,
    required this.description,
    this.difficulty = ExerciseDifficulty.beginner,
  });

  /// Backend identifier. Nullable for now since the current placeholder
  /// data doesn't have one, but any real API response should populate it
  /// (useful for navigation, favoriting, analytics, etc).
  final String? id;

  final String imagePath;
  final String title;
  final String sets;
  final String description;
  final ExerciseDifficulty difficulty;

  /// Builds an [ExerciseItem] from a JSON map, e.g. one element of the body
  /// of a `GET /exercises` response.
  ///
  /// Adjust the key names below to match your actual API contract —
  /// this is the only place that needs to change.
  factory ExerciseItem.fromJson(Map<String, dynamic> json) {
    return ExerciseItem(
      id: json['id']?.toString(),
      imagePath:
          (json['image_url'] ?? json['imagePath'] ?? '') as String,
      title: (json['title'] ?? json['name'] ?? '') as String,
      sets: (json['sets'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      difficulty: ExerciseDifficulty.fromApi(json['difficulty'] as String?),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image_url': imagePath,
      'title': title,
      'sets': sets,
      'description': description,
      'difficulty': difficulty.toApi(),
    };
  }

  ExerciseItem copyWith({
    String? id,
    String? imagePath,
    String? title,
    String? sets,
    String? description,
    ExerciseDifficulty? difficulty,
  }) {
    return ExerciseItem(
      id: id ?? this.id,
      imagePath: imagePath ?? this.imagePath,
      title: title ?? this.title,
      sets: sets ?? this.sets,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseItem &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          imagePath == other.imagePath &&
          title == other.title &&
          sets == other.sets &&
          description == other.description &&
          difficulty == other.difficulty;

  @override
  int get hashCode =>
      Object.hash(id, imagePath, title, sets, description, difficulty);
}
