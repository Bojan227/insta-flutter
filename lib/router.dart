import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/ui/home/home_screen.dart';
import 'package:pettygram_flutter/ui/login/login_screen.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/user/user_bloc.dart';

class AppRouter {
  AppRouter();

  final SharedPreferencesConfig storageConfig =
      getIt<SharedPreferencesConfig>();

  final UserBloc userBloc = getIt<UserBloc>();
  final LoginBloc loginBloc = getIt<LoginBloc>();

  GoRouter onGenerateRouter() {
    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => userBloc,
                ),
                BlocProvider.value(
                  value: loginBloc,
                )
              ],
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider.value(
              value: loginBloc,
              child: const LoginScreen(),
            );
          },
        ),
      ],
      redirect: (context, state) {
        final String? token = storageConfig.getString('accessToken');

        final bool isLoggedIn = token != null;

        if (isLoggedIn) return '/';
      },
    );

    return _router;
  }
}
