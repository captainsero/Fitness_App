class VerifyOTPCodeRequestModel {
  const VerifyOTPCodeRequestModel({required this.resetCode});

  final String resetCode;
  Map<String, dynamic> toJson() => {'resetCode': resetCode};
}
