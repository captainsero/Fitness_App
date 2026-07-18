import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/forgot_password_response.dart';
import '../../data/models/reset_password_request.dart';
import '../repo/forgot_pass_repo_contract.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordUseCase(this.repo);

  final ForgotPasswordRepoContract repo;

  Future<BaseResponse<ForgotPasswordResponse>> call(
    ResetPasswordRequest request,
  ) async {
    return repo.resetPassword(request);
  }
}
