import '../../../../../config/base_response/base_response.dart';
import '../../../login/domain/entities/user_entity.dart';

abstract class RegisterRepository {
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
  });
}
