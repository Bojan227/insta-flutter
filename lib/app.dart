import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pettygram_flutter/app_config.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/blocs/user/user_bloc.dart';
import 'package:pettygram_flutter/ui/home/home_screen.dart';

class App extends StatelessWidget {
  App({super.key});

  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    dio.options.baseUrl = 'https://pettygram-api.onrender.com';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UserBloc(dio: dio)..add(GetUsers()),
        ),
        BlocProvider(
          create: (ctx) => LoginBloc(dio: dio),
        )
      ],
      // create: (context) => UserBloc(dio: dio)..add(GetUsers()),
      child: const HomeScreen(),
    );
  }
}
