import 'package:clean_architecture_rivaan/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:clean_architecture_rivaan/core/secrets/app_secrets.dart';
import 'package:clean_architecture_rivaan/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:clean_architecture_rivaan/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/repository/auth_repository.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/usecases/current_user.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/usecases/user_login.dart';
import 'package:clean_architecture_rivaan/features/auth/domain/usecases/user_sign_up.dart';
import 'package:clean_architecture_rivaan/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:clean_architecture_rivaan/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:clean_architecture_rivaan/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/repositories/blog_repository.dart';
import 'package:clean_architecture_rivaan/features/blog/domain/usecases/upload_blog.dart';
import 'package:clean_architecture_rivaan/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
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
    // Usecases
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
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userLogin: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  // Datasources
  serviceLocator
    ..registerFactory<BlogRemoteDataSource>(
      () => BlogRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    // Repository
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
      ),
    )
    // Usecases
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    // Bloc
    ..registerLazySingleton(
      () => BlogBloc(
        serviceLocator(),
      ),
    );
}

//changing the order wont cause the issues :)