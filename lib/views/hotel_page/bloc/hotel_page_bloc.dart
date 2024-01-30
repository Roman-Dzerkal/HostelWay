import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/views/hotel_page/navigation/hotel_page_navigator.dart';
import 'package:place_picker/place_picker.dart';

part 'hotel_page_event.dart';
part 'hotel_page_state.dart';

class HotelPageBloc extends Bloc<HotelPageEvent, HotelPageState> {
  final HotelPageNavigator navigator;
  final HotelModel model;
  HotelPageBloc({required this.navigator, required this.model})
      : super(HotelPageInitial()) {
    on<HotelPageEvent>((event, emit) {});
    on<OpenHotelPositionEvent>((event, emit) {
      debugPrint("Event OpenHotelPositionEvent launched ......");
      navigator.openHotelGoogleMaps(event.latLng);
    });
  }
}
