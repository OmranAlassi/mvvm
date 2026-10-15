import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login/manger/cubit/login_cubit.dart';
import '../../features/auth/login/presentation/screens/login_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../injection_container.dart';
import 'app_route_const.dart';

abstract class AppRoute {
  static final GoRouter router = GoRouter(
    initialLocation: AppRouteConst.login,
    routes: [
      GoRoute(
        path: AppRouteConst.login,
        builder: (context, state) => BlocProvider(
          create: (context) => sl<LoginCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRouteConst.home,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}
