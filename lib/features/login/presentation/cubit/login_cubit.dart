import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/login_repository.dart';

@injectable
class LoginCubit extends Cubit<BaseState<UserEntity>> {
  LoginCubit(this._loginRepository) : super(const BaseState());

  final LoginRepository _loginRepository;

  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(const BaseState(isLoading: true));

    final response = await _loginRepository.signIn(
      email: email,
      password: password,
    );

    emit(ResponseToStateMapper.handle(response));
  }
}
