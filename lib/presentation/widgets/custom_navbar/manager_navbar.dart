import 'package:flutter/material.dart';
import 'package:hostelway/utils/custom_colors.dart';
import 'package:hostelway/presentation/widgets/custom_navbar/navigation/manager_navigator.dart';

class ManagerNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ManagerBottomNavigator navigator;
  const ManagerNavigationBar({super.key, required this.currentIndex, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: CustomColors.white,
      selectedItemColor: CustomColors.primary,
      unselectedItemColor: CustomColors.grey,
      onTap: (value) {
        switch (value) {
          case 0:
            navigator.goToMyHotels();
            break;
          case 1:
            navigator.goToProfile();
            break;
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
