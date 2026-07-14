import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/services/secure_storage/secure_storage_service.dart';
import '../../../../core/constants/app_keys/secure_storage_keys.dart';
import '../../api/login_api.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  LoginRepositoryImpl(this._loginApi, this._secureStorageService);

  final LoginApi _loginApi;
  final SecureStorageService _secureStorageService;

  @override
  Future<BaseResponse<UserEntity>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _loginApi.signIn({
        'email': email,
        'password': password,
      });

      // Saved for the current app session only (used by AuthInterceptor to
      // attach the bearer token to requests). There's no "remember me"
      // auto-login: the app always starts at the login screen.
      await _secureStorageService.write(
        key: SecureStorageKeys.token,
        value: result.token,
      );
      await _secureStorageService.write(
        key: SecureStorageKeys.userEmail,
        value: result.user.email,
      );

      return SuccessBaseResponse(data: result.user);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}
