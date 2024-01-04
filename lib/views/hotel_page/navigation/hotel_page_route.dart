import 'package:flutter/material.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/views/hotel_page/hotel_page_view.dart';
import 'package:hostelway/views/hotel_page/navigation/hotel_page_navigator.dart';


class HotelPageRoute extends MaterialPageRoute {
  HotelPageRoute(HotelModel hotel, {Function(bool)? likeCallback})
      : super(
            builder: (context) => HotelPageView(
                  hotel: hotel,
                  navigator: HotelPageNavigator(context),
                  
                ));
}