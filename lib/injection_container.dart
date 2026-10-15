import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'core/service/api_consumer.dart';
import 'core/service/dio_consumer.dart';
import 'core/utils/cache/cache_helper.dart';
import 'features/auth/login/data/repo/login_repo_impl.dart';
import 'features/auth/login/data/repo/login_repo.dart';
import 'features/auth/login/manger/cubit/login_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Features - Auth

  // Cubit
  sl.registerFactory(() => LoginCubit(sl()));

  // Repo
  sl.registerLazySingleton<LoginRepo>(
    () => LoginRepoImpl(api: sl<ApiConsumer>()),
  );
  // Data

  //! Core
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: sl()));
  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  await CacheHelper().init();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
}
