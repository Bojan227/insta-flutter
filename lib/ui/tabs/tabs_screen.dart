import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/theme/cubit/theme_cubit.dart';
import 'package:pettygram_flutter/ui/home/home_screen.dart';
import 'package:pettygram_flutter/ui/notifications/widgets/notifications_drawer.dart';
import 'package:pettygram_flutter/ui/tabs/widgets/bottom_nav_bar.dart';
import 'package:pettygram_flutter/ui/tabs/widgets/main_drawer.dart';
import 'package:pettygram_flutter/ui/tabs/widgets/notifications_icon.dart';

import '../../utils/enums.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int selectedIndex = 0;

  void handleTabSwitch(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<Widget> screens = [
    const HomeScreen(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
    const Placeholder(),
  ];

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: const ValueKey("dismiss_key"),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        context.go('/create');
      },
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Pettygram'),
          actions: [
            NotificationsIcon(scaffoldKey: _scaffoldKey),
            IconButton(
              onPressed: () {
                context.read<ThemeCubit>().toggleTheme();
              },
              icon: Icon(
                  context.read<ThemeCubit>().state.currentMode == Mode.light
                      ? Icons.dark_mode_rounded
                      : Icons.sunny),
            ),
            IconButton(
              onPressed: () {
                context.push('/chat');
              },
              icon: const Icon(Icons.send),
            )
          ],
        ),
        endDrawer: const NotificationsDrawer(),
        drawer: const MainDrawer(),
        bottomNavigationBar: BottomNavBar(
            selectedIndex: selectedIndex, handleTabSwitch: handleTabSwitch),
        body: screens[selectedIndex],
      ),
    );
  }
}
