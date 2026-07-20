// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/auth/login/api/login_api.dart' as _i633;
import '../../features/auth/login/data/repositories/login_repository_impl.dart'
    as _i470;
import '../../features/auth/login/domain/repositories/login_repository.dart'
    as _i176;
import '../../features/auth/login/presentation/view_model/login_cubit.dart'
    as _i1000;
import '../../features/auth/register/api/register_api.dart' as _i397;
import '../../features/auth/register/data/repositories/register_repository_impl.dart'
    as _i200;
import '../../features/auth/register/domain/repositories/register_repository.dart'
    as _i57;
import '../../features/auth/register/presentation/view_model/register_cubit.dart'
    as _i318;
import '../auth_interceptor/auth_interceptor.dart' as _i988;
import '../dio/dio_module.dart' as _i977;
import '../services/launcher_service/launcher_service.dart' as _i293;
import '../services/launcher_service/launcher_service_impl.dart' as _i316;
import '../services/secure_storage/secure_storage_service.dart' as _i349;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i349.SecureStorageService>(
      () => _i349.SecureStorageService(),
    );
    gh.factory<_i293.LauncherService>(() => _i316.LauncherServiceImpl());
    gh.lazySingleton<_i988.AuthInterceptor>(
      () => _i988.AuthInterceptor(gh<_i349.SecureStorageService>()),
    );
    gh.singleton<_i361.Dio>(() => dioModule.dio(gh<_i988.AuthInterceptor>()));
    gh.lazySingleton<_i633.LoginApi>(() => _i633.LoginApi(gh<_i361.Dio>()));
    gh.lazySingleton<_i397.RegisterApi>(
      () => _i397.RegisterApi(gh<_i361.Dio>()),
    );
    gh.factory<_i57.RegisterRepository>(
      () => _i200.RegisterRepositoryImpl(
        gh<_i397.RegisterApi>(),
        gh<_i349.SecureStorageService>(),
      ),
    );
    gh.factory<_i176.LoginRepository>(
      () => _i470.LoginRepositoryImpl(
        gh<_i633.LoginApi>(),
        gh<_i349.SecureStorageService>(),
      ),
    );
    gh.factory<_i1000.LoginCubit>(
      () => _i1000.LoginCubit(gh<_i176.LoginRepository>()),
    );
    gh.factory<_i318.RegisterCubit>(
      () => _i318.RegisterCubit(gh<_i57.RegisterRepository>()),
    );
    return this;
  }
}

class _$DioModule extends _i977.DioModule {}
