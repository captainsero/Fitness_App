import '../../../login/data/models/user_model.dart';

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
        Map<String, dynamic>.from(json['user'] as Map),
      ),
      token: json['token']?.toString() ?? '',
    );
  }

  final String message;
  final UserModel user;
  final String token;
}