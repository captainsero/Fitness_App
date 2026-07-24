/// The category tabs shown on the Workouts screen.
///
/// The API doesn't have a single muscle group per tab -- it has 17
/// finer-grained muscle groups (see [WorkoutsRepositoryImpl] for the
/// id mapping), several of which roll up into one tab here (e.g. "Arm"
/// covers biceps, triceps, and forearms).
enum WorkoutCategory { fullBody, chest, arm, shoulder, back, legs, waist }
