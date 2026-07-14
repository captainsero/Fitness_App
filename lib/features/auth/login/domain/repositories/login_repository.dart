import '../../../../../config/base_response/base_response.dart';
import '../entities/user_entity.dart';

abstract class LoginRepository {
  Future<BaseResponse<UserEntity>> signIn({
    required String email,
    required String password,
  });
}
