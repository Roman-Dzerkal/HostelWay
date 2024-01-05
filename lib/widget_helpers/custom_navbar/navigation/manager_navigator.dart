import 'package:hostelway/utils/role_navigator.dart';
import 'package:hostelway/views/home/navigation/home_manager_route.dart';
import 'package:hostelway/views/profile/navigation/profile_route.dart';

class ManagerBottomNavigator extends RoleNavigator {
  ManagerBottomNavigator(super.context);

  void goToMyHotels() {
    navigator.pushAndRemoveUntil(HomeManagerRoute(), (route) => false);
  }

 

  void goToProfile() {
    navigator.push(ProfileRoute());
  }

}
