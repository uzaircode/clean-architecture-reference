import 'package:clean_architecture_rivaan/core/secrets/app_secrets.dart';
import 'package:clean_architecture_rivaan/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_rivaan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/usecases/user_login.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_rivaan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // Datasources
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    //Usecases
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    //Blocs
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
      ),
    );
}
