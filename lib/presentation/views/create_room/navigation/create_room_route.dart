import 'package:flutter/material.dart';
import 'package:hostelway/presentation/views/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:hostelway/presentation/views/create_room/create_room_view.dart';

class CreateRoomRoute extends MaterialPageRoute {
  CreateRoomRoute(String hotelId)
      : super(
            builder: (context) => CreateRoomView(
                  hotelId: hotelId,
                  navigator: CreateHotelNavigator(context),
                ));
}
