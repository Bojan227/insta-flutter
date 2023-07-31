import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/blocs/users/users_bloc.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/ui/create/create_screen.dart';
import 'package:pettygram_flutter/ui/tabs/tabs_screen.dart';
import 'package:pettygram_flutter/ui/login/login_screen.dart';
import 'package:pettygram_flutter/ui/user/user_details.dart';

import 'blocs/login/login_bloc.dart';

class AppRouter {
  AppRouter();

  final SharedPreferencesConfig storageConfig =
      getIt<SharedPreferencesConfig>();

  final UsersBloc usersBloc = getIt<UsersBloc>();
  final LoginBloc loginBloc = getIt<LoginBloc>();
  final UserBloc userBloc = getIt<UserBloc>();
  final PostBloc postBloc = getIt<PostBloc>();

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
                    create: (context) => usersBloc,
                  ),
                  BlocProvider(
                    create: (context) => postBloc,
                  ),
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
                    value: userBloc
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
        GoRoute(
          path: '/create',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider.value(
              value: userBloc,
              child: CreateScreen(),
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
