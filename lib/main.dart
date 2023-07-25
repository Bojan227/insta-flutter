import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pettygram_flutter/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final dio = Dio();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    dio.options.baseUrl = 'https://pettygram-api.onrender.com';

    return MaterialApp.router(
      routerConfig: AppRouter(dio: dio).onGenerateRouter(),
      title: 'Pettygram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
