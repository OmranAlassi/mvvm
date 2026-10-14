import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../service/dio_consumer.dart';
import '../../features/auth/data/repo/auth_repo_impl.dart';
import '../../features/auth/manger/cubit/auth_cubit.dart';
import '../../features/home/presentation/screens/home_screen.dart';

import 'app_route_const.dart';
import '../../features/auth/presentation/screens/login_screen.dart';

abstract class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConst.login,
    routes: [
      GoRoute(
        path: AppRouteConst.login,

        builder: (context, state) => BlocProvider(
          create: (context) =>
              AuthCubit(AuthRepoImpl(api: DioConsumer(dio: Dio()))),
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
