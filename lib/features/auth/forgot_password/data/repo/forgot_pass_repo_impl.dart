import 'package:injectable/injectable.dart';

import '../../../../../config/base_response/base_response.dart';
import '../../domain/repo/forgot_pass_repo_contract.dart';
import '../data_source/forgot_pass_remote_data_source_contract.dart';
import '../models/forgot_pass_request.dart';
import '../models/forgot_password_response.dart';

@Injectable(as: ForgotPassRepoContract)
class ForgotPassRepoImpl implements ForgotPassRepoContract {
  final ForgotPassRemoteDataSourceContract _remoteDataSource;

  ForgotPassRepoImpl(this._remoteDataSource);

  @override
  Future<BaseResponse<ForgotPasswordResponse>> forgotPassword(
    ForgotPassRequest request,
  ) async {
    return _remoteDataSource.forgotPassword(request);
  }
}
