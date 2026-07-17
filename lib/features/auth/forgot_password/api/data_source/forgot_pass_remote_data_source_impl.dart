import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/data_source/forgot_pass_remote_data_source_contract.dart';
import '../../data/models/forgot_pass_request.dart';
import '../../data/models/forgot_password_response.dart';
import '../api_client/forgot_password_api_client.dart';

@Injectable(as: ForgotPassRemoteDataSourceContract)
class ForgotPassRemoteDataSourceImpl
    implements ForgotPassRemoteDataSourceContract {
  ForgotPassRemoteDataSourceImpl({required ForgotPasswordApiClient apiClient})
    : _apiClient = apiClient;

  final ForgotPasswordApiClient _apiClient;

  @override
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPassRequest request,
  ) async {
    try {
      final response = await _apiClient.forgotPassword(body: request.toJson());

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
}
