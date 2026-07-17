import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../data/models/forgot_pass_request.dart';
import '../../data/models/forgot_password_response.dart';
import '../repo/forgot_pass_repo_contract.dart';

@injectable
class ForgotPassUseCase {
  ForgotPassUseCase(this._repo);

  final ForgotPassRepoContract _repo;

  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPassRequest request,
  ) async {
    return _repo.forgotPassword(request);
  }
}
