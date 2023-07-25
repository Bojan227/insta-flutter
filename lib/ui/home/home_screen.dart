import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/login/login_bloc.dart';
import 'package:pettygram_flutter/injector/injector.dart';
import 'package:pettygram_flutter/storage/shared_preferences.dart';
import 'package:pettygram_flutter/widgets/stories.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final String? token =
        getIt<SharedPreferencesConfig>().getString('accessToken');

    return Scaffold(
      drawer: SafeArea(
        child: Drawer(
            child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                if (token != null) Navigator.of(context).pop();

                context.go('/login');
              },
              child: const Text('Login'),
            )
          ],
        )),
      ),
      appBar: AppBar(
        title: const Text('Pettygram'),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.send))
        ],
      ),
      body: Column(children: [
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
      ]),
    );
  }
}
