import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../service/dio_consumer.dart';
import '../../features/auth/login/data/repo/login_repo_impl.dart';
import '../../features/auth/login/manger/cubit/login_cubit.dart';
import '../../features/home/presentation/screens/home_screen.dart';

import 'app_route_const.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';

abstract class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConst.login,
    routes: [
      GoRoute(
        path: AppRouteConst.login,

        builder: (context, state) => BlocProvider(
          create: (context) =>
              LoginCubit(LoginRepoImpl(api: DioConsumer(dio: Dio()))),
          child: LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteConst.home,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
