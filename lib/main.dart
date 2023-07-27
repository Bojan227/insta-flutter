import 'package:flutter/material.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const appConfig = AppConfig(apiBaseUrl: 'https://pettygram-api.onrender.com');

  await setupInjector(appConfig);

  runApp(const MyApp());
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
      routerConfig: appRouter.onGenerateRouter(),
      title: 'Pettygram',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    appRouter.loginBloc.close();
    appRouter.userPostBloc.close();
  }
}
