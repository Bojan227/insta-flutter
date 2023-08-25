import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../injector/injector.dart';
import '../../../storage/shared_preferences.dart';
import '../../../theme/custom_theme.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final String? token =
        getIt<SharedPreferencesConfig>().getString('accessToken');
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return Drawer(
        elevation: 3,
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.white54, Colors.white],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
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
