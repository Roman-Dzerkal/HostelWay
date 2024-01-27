import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/views/home/navigation/home_manager_navigator.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
part 'home_manager_event.dart';
part 'home_manager_state.dart';

class HomeManagerBloc extends Bloc<HomeManagerEvent, HomeManagerState> {
  final HomeManagerNavigator navigator;
  final HotelsRepository rep;
  HomeManagerBloc({required this.rep, required this.navigator})
      : super(HomeManagerInitial()) {
    on<HomeManagerEvent>((event, emit) {});

    on<AddHotelButtonTapEvent>((event, emit) {
      debugPrint('AddHotelButtonTapEvent');
      navigator.goToCreateHotelPage();
    });

    on<FetchHotelsEvent>((event, emit) async {
      List<HotelModel> hotels = await rep.getHotels(
          managerId: FirebaseAuth.instance.currentUser!.uid);
      emit(state.copyWith(hotels: hotels));
      hotels.forEach((element) {
        debugPrint('${element.city}+${element.description}+${element.name}+${element.facilities} ');
      });

      /*var hotels = await FirebaseFirestore.instance
          .collection('hotels')
          .where('managerId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();*/

      // TODO: remove debugPrint and add logic to show hotels
      /*for (var element in hotels.docs) {
        debugPrint(element.data().toString());
      }*/
    });
  }
}
