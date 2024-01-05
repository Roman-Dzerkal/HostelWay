import 'package:hostelway/features/create_hotel/navigation/create_hotel_route.dart';
import 'package:hostelway/utils/role_navigator.dart';

class HomeManagerNavigator extends RoleNavigator {
  HomeManagerNavigator(super.context);

  void goToCreateHotelPage() {
      navigator.push(CreateHotelRoute());}
}
