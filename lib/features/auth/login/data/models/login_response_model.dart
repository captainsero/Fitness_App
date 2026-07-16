import 'user_model.dart';

class LoginResponseModel {
  const LoginResponseModel({
    required this.message,
    required this.user,
    required this.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
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
