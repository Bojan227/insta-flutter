import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/user_posts/user_post_bloc.dart';

import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/ui/home/home_screen.dart';
import 'package:pettygram_flutter/ui/tabs/tabs_screen.dart';
import 'package:pettygram_flutter/ui/login/login_screen.dart';
import 'package:pettygram_flutter/ui/user/user_details.dart';

import 'blocs/login/login_bloc.dart';
import 'blocs/user/user_bloc.dart';

class AppRouter {
  AppRouter();

  final SharedPreferencesConfig storageConfig =
      getIt<SharedPreferencesConfig>();

  final UserBloc userBloc = getIt<UserBloc>();
  final LoginBloc loginBloc = getIt<LoginBloc>();
  final UserPostBloc userPostBloc = getIt<UserPostBloc>();

  GoRouter onGenerateRouter() {
    final GoRouter _router = GoRouter(
      initialLocation: '/',
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
                child: const TabsScreen(),
              );
            },
            routes: [
              GoRoute(
                path: 'profile',
                builder: (BuildContext context, GoRouterState state) {
                  User user = state.extra as User;

                  return BlocProvider.value(
                    value: userPostBloc
                      ..add(
                        GetUserPosts(userId: user.id!),
                      ),
                    child: UserDetails(user: user),
                  );
                },
              ),
            ]),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider.value(
              value: loginBloc,
              child: LoginScreen(),
            );
          },
        ),
      ],
      redirect: (context, state) {
        final String? token = storageConfig.getString('accessToken');

        final bool isLoginPath = state.path == '/login';
        final bool isLoggedIn = token != null;

        if (isLoggedIn && isLoginPath) return '/';
      },
    );

    return _router;
  }
}
