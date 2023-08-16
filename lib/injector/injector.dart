import 'package:get_it/get_it.dart';
import 'package:pettygram_flutter/api/pettygram_provider.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/blocs/bookmarks/bookmarks_bloc.dart';
import 'package:pettygram_flutter/blocs/chat/bloc/chat_bloc.dart';

import 'package:pettygram_flutter/blocs/comments/comments_bloc.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/blocs/posts/post_bloc.dart';

import 'package:pettygram_flutter/blocs/user/cubit/user_cubit.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/blocs/users/users_bloc.dart';

import 'package:pettygram_flutter/storage/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future setupInjector(AppConfig config) async {
  // data/domain layer
  final SharedPreferencesConfig sharedConfig =
      await SharedPreferencesConfig().initSharedPreferences();
  getIt.registerSingleton<SharedPreferencesConfig>(sharedConfig);

  final PettygramProvider pettygramProvider = PettygramProvider(config);
  getIt.registerSingleton<PettygramProvider>(pettygramProvider);

  final PettygramRepository pettygramRepository = PettygramRepository();
  getIt.registerSingleton<PettygramRepository>(pettygramRepository);

  // application layer
  final UsersBloc usersBloc =
      UsersBloc(pettygramRepository: pettygramRepository);
  getIt.registerSingleton<UsersBloc>(usersBloc..add(GetUsers()));

  final LoginBloc loginBloc = LoginBloc(
      storageConfig: sharedConfig, pettygramRepository: pettygramRepository);
  getIt.registerSingleton<LoginBloc>(loginBloc);

  final UserBloc userBloc =
      UserBloc(pettygramRepository: pettygramRepository, storage: sharedConfig);
  getIt.registerSingleton<UserBloc>(userBloc);

  final UserCubit userCubit = UserCubit(
      pettygramRepository: pettygramRepository, storage: sharedConfig);
  getIt.registerSingleton<UserCubit>(userCubit);

  final PostBloc postBloc =
      PostBloc(pettygramRepository: pettygramRepository, storage: sharedConfig);
  getIt.registerSingleton<PostBloc>(
    postBloc
      ..add(
        const GetPosts(),
      ),
  );

  final CommentsBloc commentsBloc = CommentsBloc(
      pettygramRepository: pettygramRepository, storage: sharedConfig);
  getIt.registerLazySingleton<CommentsBloc>(() => commentsBloc);

  final BookmarksBloc bookmarksBloc = BookmarksBloc(
      pettygramRepository: pettygramRepository, storage: sharedConfig);
  getIt.registerLazySingleton<BookmarksBloc>(() => bookmarksBloc);

  final ChatBloc chatBloc = ChatBloc(storage: sharedConfig);
  getIt.registerSingleton<ChatBloc>(chatBloc);
}
