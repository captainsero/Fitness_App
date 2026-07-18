import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/data_source/forgot_pass_remote_data_source_contract.dart';
import '../../data/models/forgot_pass_request.dart';
import '../../data/models/forgot_password_response.dart';
import '../../data/models/reset_password_request.dart';
import '../../data/models/verify_otp_code_request.dart';
import '../api_client/forgot_password_api_client.dart';

@Injectable(as: ForgotPassRemoteDataSourceContract)
class ForgotPassRemoteDataSourceImpl
    implements ForgotPassRemoteDataSourceContract {
  ForgotPassRemoteDataSourceImpl({required ForgotPasswordApiClient apiClient})
    : _apiClient = apiClient;

  final ForgotPasswordApiClient _apiClient;

  @override
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    try {
      final response = await _apiClient.forgotPassword(body: request);

      return SuccessBaseResponse<ForgotPasswordResponse>(data: response);
    } on DioException catch (e) {
      return ErrorBaseResponse<ForgotPasswordResponse>(error: e);
    } catch (e, stackTrace) {
      log(
        'Unexpected error in forgotPassword',
        error: e,
        stackTrace: stackTrace,
      );

      return ErrorBaseResponse<ForgotPasswordResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordResponse>> verifyResetCode(
    VerifyOTPCodeRequestModel request,
  ) async {
    try {
      final response = await _apiClient.verifyResetCode(resetCode: request);

      return SuccessBaseResponse<ForgotPasswordResponse>(data: response);
    } on DioException catch (e) {
      return ErrorBaseResponse<ForgotPasswordResponse>(error: e);
    } catch (e, stackTrace) {
      log(
        'Unexpected error in verifyResetCode',
        error: e,
        stackTrace: stackTrace,
      );

      return ErrorBaseResponse<ForgotPasswordResponse>(error: e);
    }
  }

  @override
  Future<BaseResponse<ForgotPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    try {
      final response = await _apiClient.resetPassword(newPassword: request);

      return SuccessBaseResponse<ForgotPasswordResponse>(data: response);
    } on DioException catch (e) {
      return ErrorBaseResponse<ForgotPasswordResponse>(error: e);
    } catch (e, stackTrace) {
      log(
        'Unexpected error in resetPassword',
        error: e,
        stackTrace: stackTrace,
      );

      return ErrorBaseResponse<ForgotPasswordResponse>(error: e);
    }
  }
}
