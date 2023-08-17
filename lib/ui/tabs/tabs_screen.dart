import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pettygram_flutter/blocs/theme/cubit/theme_cubit.dart';
import 'package:pettygram_flutter/ui/home/home_screen.dart';
import 'package:pettygram_flutter/ui/tabs/widgets/main_drawer.dart';

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
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: const Text('Pettygram'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_border),
            ),
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
        drawer: const MainDrawer(),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (value) => handleTabSwitch(value),
            selectedItemColor: Theme.of(context).colorScheme.onSecondary,
            unselectedItemColor: Colors.grey[400],
            showSelectedLabels: false,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Search"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.add_a_photo_rounded), label: "Add"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Notifications"),
              BottomNavigationBarItem(
                icon: Icon(Icons.circle),
                label: 'Profile',
              )
            ]),
        body: screens[selectedIndex],
      ),
    );
  }
}
