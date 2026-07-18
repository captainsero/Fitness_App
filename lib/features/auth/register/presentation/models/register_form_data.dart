/// Accumulates the fields collected across the whole registration /
/// onboarding flow (RegisterView -> SelectGenderView -> SelectAgeView ->
/// SelectWeightView -> SelectHeightView -> SelectGoalView ->
/// SelectActivityLevelView) so they can be carried forward -- via
/// `GoRouterState.extra` -- from screen to screen.
///
/// `POST /auth/signup` requires all of firstName/lastName/email/password/
/// rePassword/gender/age/weight/height/goal/activityLevel at once, so the
/// actual API call only happens on the final step (SelectActivityLevelView),
/// once every field below is populated.
class RegisterFormData {
  const RegisterFormData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    this.gender,
    this.age,
    this.weight,
    this.height,
    this.goal,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String? gender;
  final int? age;
  final int? weight;
  final int? height;
  final String? goal;

  RegisterFormData copyWith({
    String? gender,
    int? age,
    int? weight,
    int? height,
    String? goal,
  }) {
    return RegisterFormData(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      goal: goal ?? this.goal,
    );
  }
}
