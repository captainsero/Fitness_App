class ResetPasswordRequest {
  ResetPasswordRequest({required this.newPassword, required this.email});

  String? email;
  final String newPassword;

  Map<String, dynamic> toJson() => {'email': email, 'newPassword': newPassword};
}
