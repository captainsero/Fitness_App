import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/services/secure_storage/secure_storage_service.dart';

import '../../../../../core/constants/app_keys/secure_storage_keys.dart';
import '../../api/register_api.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../../domain/repositories/register_repository.dart';

@Injectable(as: RegisterRepository)
class RegisterRepositoryImpl implements RegisterRepository {
  RegisterRepositoryImpl(this._registerApi, this._secureStorageService);

  final RegisterApi _registerApi;
  final SecureStorageService _secureStorageService;

  @override
  Future<BaseResponse<UserEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String gender,
    required int age,
    required int weight,
    required int height,
    required String goal,
    required String activityLevel,
  }) async {
    try {
      final result = await _registerApi.signUp({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'rePassword': rePassword,
        'gender': gender,
        'age': age,
        'weight': weight,
        'height': height,
        'goal': goal,
        'activityLevel': activityLevel,
      });

      // Same session-only persistence LoginRepositoryImpl uses -- signing
      // up logs the user straight in (the API returns a token), so the
      // remaining onboarding steps (age/height/goal) run as an
      // authenticated user.
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
