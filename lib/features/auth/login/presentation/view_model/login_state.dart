import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/handler/response_to_state_mapper.dart' show ResponseToStateMapper;
import '../../domain/entities/user_entity.dart';
import 'login_cubit.dart' show LoginCubit;

/// State emitted by [LoginCubit].
///
/// This is a typedef over the app-wide [BaseState] (see
/// `config/base_state`) so the login feature gets its own named state type
/// -- and keeps using the same loading/data/error handling every other
/// feature uses via [ResponseToStateMapper].
typedef LoginState = BaseState<UserEntity>;
