class ForgotPassRequest {
  const ForgotPassRequest({required this.email});

  final String email;
  Map<String, dynamic> toJson() => {'email ': email};
}
