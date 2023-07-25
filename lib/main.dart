import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/router.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupInjector();
  // await getIt<SharedPreferencesConfig>().initSharedPreferences();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().onGenerateRouter(),
      title: 'Pettygram',
      theme: ThemeData().copyWith(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
