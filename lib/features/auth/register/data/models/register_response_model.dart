import '../../../login/data/models/user_model.dart';

/// Response body for POST /auth/signup:
/// ```json
/// { "message": "success", "user": { ... }, "token": "..." }
/// ```
/// Identical shape to [LoginResponseModel] (same `user` object, same
/// `token`), so this reuses [UserModel] rather than duplicating it.
class RegisterResponseModel {
  const RegisterResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    return RegisterResponseModel(
      message: json['message']?.toString() ?? '',
      user: UserModel.fromJson(
        (json['user'] as Map<Object?, dynamic>?)?.cast<String, dynamic>() ??
            const {},
      ),
      token: json['token']?.toString() ?? '',
    );
  }

  final String message;
  final UserModel user;
  final String token;
}
