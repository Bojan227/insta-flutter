import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/ui/home/home_screen.dart';
import 'package:pettygram_flutter/ui/login/login_screen.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/user/user_bloc.dart';

class AppRouter {
  AppRouter({required this.dio});

  final Dio dio;

  GoRouter onGenerateRouter() {
    final UserBloc userBloc = UserBloc(dio: dio);
    final LoginBloc loginBloc = LoginBloc(dio: dio);

    final GoRouter _router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider.value(
                  value: userBloc..add(GetUsers()),
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
    );

    return _router;
  }
}
