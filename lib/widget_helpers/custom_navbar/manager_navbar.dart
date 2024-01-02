import 'package:flutter/material.dart';
import 'package:hostelway/resources/custom_colors.dart';

class ManagerNavigationBar extends StatelessWidget {
  final int currentIndex;

  const ManagerNavigationBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: CustomColors.white,
      selectedItemColor: CustomColors.primary,
      unselectedItemColor: CustomColors.grey,
      onTap: (value) {
        switch (value) {
          case 1:
            break;
          default:
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'My hotels'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined), label: 'Profile'),
      ],
    );
  }
}
