import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/utils/role_navigator.dart';
import 'package:hostelway/views/hotel_page/navigation/hotel_page_route.dart';

class HomeGuestNavigator extends RoleNavigator {
  HomeGuestNavigator(super.context);


   void goToHotelPage(HotelModel hotel) {
    navigator.push(HotelPageRoute(hotel));
  }
}
