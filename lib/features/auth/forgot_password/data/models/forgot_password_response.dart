import 'package:json_annotation/json_annotation.dart';

part 'forgot_password_response.g.dart';

@JsonSerializable()
class ForgotPasswordResponse {
  ForgotPasswordResponse({
    required this.message,
    required this.status,
    required this.code,
    required this.info,
    required this.token,
  });

  factory ForgotPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordResponseFromJson(json);

  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'status')
  final String? status;
  @JsonKey(name: 'code')
  final int? code;
  @JsonKey(name: 'info')
  final String? info;
  @JsonKey(name: 'token')
  final String? token;

  Map<String, dynamic> toJson() => _$ForgotPasswordResponseToJson(this);
}
