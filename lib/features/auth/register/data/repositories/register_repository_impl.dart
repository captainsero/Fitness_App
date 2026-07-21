import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../../../../config/services/secure_storage/secure_storage_service.dart';
import '../../../login/domain/entities/user_entity.dart';
import '../../api/register_api.dart';
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

      return SuccessBaseResponse(data: result.user);
    } on Exception catch (e) {
      return ErrorBaseResponse(error: e);
    }
  }
}
