import 'package:get_it/get_it.dart';
import 'package:pettygram_flutter/api/pettygram_provider.dart';
import 'package:pettygram_flutter/api/pettygram_repo_impl.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/blocs/user_posts/user_post_bloc.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

GetIt getIt = GetIt.instance;

Future setupInjector(AppConfig config) async {
  final SharedPreferencesConfig sharedConfig =
      await SharedPreferencesConfig().initSharedPreferences();
  getIt.registerSingleton<SharedPreferencesConfig>(sharedConfig);

  final PettygramProvider pettygramProvider = PettygramProvider(config);
  getIt.registerSingleton<PettygramProvider>(pettygramProvider);

  final PettygramRepository pettygramRepository = PettygramRepository();
  getIt.registerSingleton<PettygramRepository>(pettygramRepository);

  final UserBloc usersBloc = UserBloc(pettygramRepository: pettygramRepository);
  getIt.registerSingleton<UserBloc>(usersBloc..add(GetUsers()));

  final LoginBloc loginBloc = LoginBloc(
      storageConfig: sharedConfig, pettygramRepository: pettygramRepository);
  getIt.registerSingleton<LoginBloc>(loginBloc);

  final UserPostBloc userPostsBloc =
      UserPostBloc(pettygramRepository: pettygramRepository);
  getIt.registerSingleton<UserPostBloc>(userPostsBloc);
}
