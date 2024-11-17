import 'package:hostelway/utils/role_navigator.dart';

class CreateRoomNavigator extends RoleNavigator {
  CreateRoomNavigator(super.context);

  void goToHotelList() {
    navigator.pop();
  }
}
