import '../../../../../config/base_state/base_state.dart';
import '../../../../../config/handler/response_to_state_mapper.dart' show ResponseToStateMapper;
import '../../../login/domain/entities/user_entity.dart';
import '../../../login/presentation/view_model/login_state.dart' show LoginState;
import 'register_cubit.dart' show RegisterCubit;

/// State emitted by [RegisterCubit].
///
/// Same pattern as [LoginState] -- a typedef over the app-wide
/// [BaseState] so the register feature gets its own named state type
/// while still using the shared loading/data/error handling every
/// other feature uses via [ResponseToStateMapper].
typedef RegisterState = BaseState<UserEntity>;
