import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/blocs/theme/cubit/theme_cubit.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/router.dart';
import 'package:pettygram_flutter/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appConfig = AppConfig(apiBaseUrl: 'https://pettygram-api.onrender.com');

  await setupInjector(appConfig);

  runApp(BlocProvider(
    create: (context) => ThemeCubit(),
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: context.watch<ThemeCubit>().state.currentMode == Mode.light
          ? ThemeMode.light
          : ThemeMode.dark,
      routerConfig: appRouter.onGenerateRouter(),
      title: 'Pettygram',
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }

  @override
  void dispose() {
    super.dispose();

    appRouter.userBloc.close();
    appRouter.userCubit.close();
    appRouter.postBloc.close();
    appRouter.usersBloc.close();
    appRouter.commentsBloc.close();
    appRouter.bookmarksBloc.close();
  }
}
