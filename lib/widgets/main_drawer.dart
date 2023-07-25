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
        child: Column(
      children: [
        const DrawerHeader(
          child: Text('Pettygram'),
        ),
        TextButton(
          onPressed: () {
            if (token != null) Navigator.of(context).pop();

            context.go('/login');
          },
          child: const Text('Login'),
        ),
        TextButton(
          onPressed: () {
            getIt<SharedPreferencesConfig>().removeString('accessToken');
            context.go('/login');
          },
          child: const Text('Logout'),
        )
      ],
    ));
  }
}
