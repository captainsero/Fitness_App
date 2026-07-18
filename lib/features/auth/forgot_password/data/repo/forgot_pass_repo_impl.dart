import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/handler/secure_storage_handler.dart';
import '../../../../../config/services/secure_storage/secure_storage_service.dart';
import '../../../../../core/constants/app_keys/secure_storage_keys.dart';
import '../../domain/repo/forgot_pass_repo_contract.dart';
import '../data_source/forgot_pass_remote_data_source_contract.dart';
import '../models/forgot_pass_request.dart';
import '../models/forgot_password_response.dart';
import '../models/reset_password_request.dart';
import '../models/verify_otp_code_request.dart';

@Injectable(as: ForgotPasswordRepoContract)
class ForgotPassRepoImpl implements ForgotPasswordRepoContract {
  ForgotPassRepoImpl({
    required this.remoteDataSource,
    required this.secureStorage,
  });

  final ForgotPassRemoteDataSourceContract remoteDataSource;

  final SecureStorageService secureStorage;

  @override
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPasswordRequest request,
  ) async {
    return remoteDataSource.forgotPassword(request);
  }

  @override
  Future<BaseResponse<ForgotPasswordResponse>> resetPassword(
    ResetPasswordRequest request,
  ) async {
    final email = await secureStorage.read(key: SecureStorageKeys.userEmail);
    final emailHandler = SecureStorageHandler.handle(email);
    request.email = emailHandler;
    return remoteDataSource.resetPassword(request);
  }

  @override
  Future<BaseResponse<ForgotPasswordResponse>> verifyResetCode(
    VerifyOTPCodeRequestModel request,
  ) async {
    return remoteDataSource.verifyResetCode(request);
  }
}
