import 'package:flutter/material.dart';
import 'package:hostelway/utils/role_navigator.dart';
import 'package:hostelway/views/hotel_map/hotel_map.dart';
import 'package:place_picker/place_picker.dart';

class HotelPageNavigator extends RoleNavigator {


  HotelPageNavigator(super.context);

  
   void openHotelGoogleMaps(LatLng latLng) {
    navigator.push(MaterialPageRoute(builder: (context)=> HotelMapView(latLng: latLng)));
  }
}
