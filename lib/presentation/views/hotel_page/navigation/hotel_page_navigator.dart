import 'package:hostelway/presentation/views/create_room/navigation/create_room_route.dart';
import 'package:hostelway/utils/role_navigator.dart';
// import 'package:place_picker/place_picker.dart';

class HotelPageNavigator extends RoleNavigator {
  HotelPageNavigator(super.context);

  void goToRoomPage(String hotelId) {
    navigator.push(CreateRoomRoute(hotelId));
  }

  /* void openHotelGoogleMaps(LatLng latLng) {
    navigator.push(
        MaterialPageRoute(builder: (context) => HotelMapView(latLng: latLng)));
  } */
}
