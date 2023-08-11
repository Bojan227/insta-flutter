import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';
import 'package:pettygram_flutter/blocs/user/cubit/user_cubit.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/blocs/users/users_bloc.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/models/user.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/ui/comments/comments_screen.dart';
import 'package:pettygram_flutter/ui/create/create_screen.dart';
import 'package:pettygram_flutter/ui/edit/edit_screen.dart';
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
  final UserCubit userCubit = getIt<UserCubit>();
  final CommentsBloc commentsBloc = getIt<CommentsBloc>();

  GoRouter onGenerateRouter() {
    final GoRouter _router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return MultiBlocProvider(
                providers: [
                  BlocProvider.value(
                    value: usersBloc,
                  ),
                  BlocProvider.value(
                    value: postBloc,
                  ),
                  BlocProvider.value(
                    value: userBloc,
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
                  String userId = state.extra as String;

                  return MultiBlocProvider(providers: [
                    BlocProvider.value(
                      value: userBloc..add(GetUserPosts(userId: userId)),
                    ),
                    BlocProvider.value(
                      value: postBloc,
                    ),
                    BlocProvider.value(
                      value: usersBloc,
                    ),
                    BlocProvider.value(
                      value: userCubit..loadUser(userId),
                    ),
                  ], child: const UserDetails());
                },
                routes: [
                  GoRoute(
                    path: 'edit',
                    builder: (BuildContext context, GoRouterState state) {
                      User user = state.extra as User;
                      return MultiBlocProvider(
                        providers: [
                          BlocProvider.value(
                            value: usersBloc,
                          ),
                          BlocProvider.value(
                            value: userCubit,
                          ),
                          BlocProvider.value(
                            value: postBloc,
                          ),
                        ],
                        child: EditUserScreen(user: user),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'comments',
                builder: (BuildContext context, GoRouterState state) {
                  String postId = state.extra as String;
                  return MultiBlocProvider(
                    providers: [
                      BlocProvider.value(
                        value: commentsBloc
                          ..add(
                            GetComments(postId: postId),
                          ),
                      ),
                    ],
                    child: CommentsScreen(
                      postId: postId,
                    ),
                  );
                },
              ),
            ]),
        GoRoute(
          path: '/login',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider(
              create: (context) => loginBloc,
              child: LoginScreen(),
            );
          },
        ),
        GoRoute(
          path: '/create',
          builder: (BuildContext context, GoRouterState state) {
            return BlocProvider.value(
              value: postBloc,
              child: CreateScreen(),
            );
          },
        ),
      ],
      redirect: (context, state) {
        if (state.error is TypeError) {
          context.go('/login');
        }

        final String? token = storageConfig.getString('accessToken');

        final bool isLoginPath = state.path == '/login';
        final bool isLoggedIn = token != null;

        if (isLoggedIn && isLoginPath) return '/';
      },
    );

    return _router;
  }
}
