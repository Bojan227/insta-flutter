import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/widgets/circle_image.dart';
import 'package:pettygram_flutter/widgets/main_drawer.dart';
import 'package:pettygram_flutter/widgets/stories.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final String? token =
      getIt<SharedPreferencesConfig>().getString('accessToken');

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const StoriesWidget(),
      BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginSuccess) {
            return Text(state.login.token.toString());
          } else {
            return const Text("Not Logged in");
          }
        },
      ),
      Text(token ?? 'no token')
    ]);
  }
}
