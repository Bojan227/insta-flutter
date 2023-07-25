import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../injector/injector.dart';
import '../storage/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String? token =
        getIt<SharedPreferencesConfig>().getString('accessToken');

    return Drawer(
        elevation: 3,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0xffF58529),
            Color(0xffDD2A7B),
            Color(0xff8134AF),
            Color(0xff515BD4)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Pettygram',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ],
                ),
              ),
              ListTile(
                title: const Text(
                  'Login',
                ),
                onTap: () {
                  if (token != null) Navigator.of(context).pop();

                  context.go('/login');
                },
              ),
              ListTile(
                title: const Text(
                  'Logout',
                ),
                onTap: () {
                  getIt<SharedPreferencesConfig>().removeString('accessToken');
                  context.go('/login');
                },
              ),
            ],
          ),
        ));
  }
}
