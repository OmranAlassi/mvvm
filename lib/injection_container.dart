import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/service/api_consumer.dart';
import 'core/service/api_interceptors.dart';
import 'core/service/dio_consumer.dart';
import 'core/utils/cache/cache_helper.dart';
import 'features/auth/login/data/repo/login_repo.dart';
import 'features/auth/login/data/repo/login_repo_impl.dart';
import 'features/auth/login/manger/cubit/login_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Auth
  // Cubit
  sl.registerFactory(() => LoginCubit(sl()));

  // Repo
  sl.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(api: sl()),
  );

  //! Core
  final cacheHelper = CacheHelper();
  await cacheHelper.init();
  sl.registerLazySingleton<CacheHelper>(() => cacheHelper);

  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  sl.registerLazySingleton<ApiInterceptor>(() => ApiInterceptor());
  sl.registerLazySingleton<LogInterceptor>(
    () => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true,
    ),
  );

  //! External
  sl.registerLazySingleton<Dio>(() => Dio());
}

