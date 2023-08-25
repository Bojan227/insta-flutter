import 'package:flutter/material.dart';

import '../../../theme/custom_theme.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key, required this.selectedIndex, required this.handleTabSwitch});

  final int selectedIndex;
  final void Function(int index) handleTabSwitch;

  @override
  Widget build(BuildContext context) {
    final customTheme = Theme.of(context).extension<CustomTheme>()!;

    return BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: customTheme.background,
        currentIndex: selectedIndex,
        onTap: (value) => handleTabSwitch(value),
        selectedItemColor: customTheme.onSecondary,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_a_photo_rounded), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Notifications"),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ]);
  }
}
