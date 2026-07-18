import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../config/base_state/base_state.dart';

import '../../../../../config/handler/response_to_state_mapper.dart';
import '../../domain/repositories/register_repository.dart';
import 'register_state.dart';

@injectable
class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._registerRepository) : super(const BaseState());

  final RegisterRepository _registerRepository;

  Future<void> register({
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
    emit(const BaseState(isLoading: true));

    final response = await _registerRepository.signUp(
      firstName: firstName,
      lastName: lastName,
      email: email,
      password: password,
      rePassword: rePassword,
      gender: gender,
      age: age,
      weight: weight,
      height: height,
      goal: goal,
      activityLevel: activityLevel,
    );

    emit(ResponseToStateMapper.handle(response));
  }
}
