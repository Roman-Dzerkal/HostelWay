import 'package:flutter/material.dart';
import 'package:hostelway/utils/custom_colors.dart';
import 'package:hostelway/presentation/widgets/custom_navbar/navigation/guest_navigator.dart';

class GuestNavigationBar extends StatelessWidget {
  final int currentIndex;
  final GuestBottomNavigator navigator;

  const GuestNavigationBar(
      {super.key, required this.currentIndex, required this.navigator});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedFontSize: 14,
      unselectedFontSize: 14,
      iconSize: 20,
      currentIndex: currentIndex,
      backgroundColor: CustomColors.white,
      selectedItemColor: CustomColors.primary,
      unselectedItemColor: CustomColors.grey,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      onTap: (value) {
        switch (value) {
          case 0:
            navigator.goToSearch();
            break;
          case 1:
            navigator.goToFavorite();
            break;
          case 2:
            navigator.goToBookings();
            break;
          case 3:
            navigator.goToProfile();
            break;
          default:
            throw Exception('Invalid index');
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border), label: 'Favorites'),
        BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Bookings'),
        BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined), label: 'Profile'),
      ],
    );
  }
}
