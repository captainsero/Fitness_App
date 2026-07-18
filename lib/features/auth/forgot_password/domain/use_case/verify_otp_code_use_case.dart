import 'package:injectable/injectable.dart';
import '../../../../../config/base_response/base_response.dart';
import '../../data/models/forgot_password_response.dart';
import '../../data/models/verify_otp_code_request.dart';
import '../repo/forgot_pass_repo_contract.dart';

@injectable
class VerifyOTPCodeUseCase {
  VerifyOTPCodeUseCase(this.repo);

  final ForgotPasswordRepoContract repo;

  Future<BaseResponse<ForgotPasswordResponse>> call(
    VerifyOTPCodeRequestModel request,
  ) async {
    return repo.verifyResetCode(request);
  }
}
