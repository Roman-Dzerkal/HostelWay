import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/domain/models/hotel_model.dart';
import 'package:hostelway/domain/repositories/hotels_repository.dart';
import 'package:hostelway/presentation/views/home/navigation/home_manager_navigator.dart';

part 'home_manager_event.dart';
part 'home_manager_state.dart';

class HomeManagerBloc extends Bloc<HomeManagerEvent, HomeManagerState> {
  final HomeManagerNavigator navigator;
  final HotelsRepository repository;

  HomeManagerBloc({required this.navigator, required this.repository})
      : super(HomeManagerInitial(hotels: List.empty(growable: true))) {
    on<HomeManagerEvent>((event, emit) {});

    on<AddHotelButtonTapEvent>((event, emit) {
      debugPrint('AddHotelButtonTapEvent');
      navigator.goToCreateHotelPage();
    });
    on<OnTapHotelItemEvent>((event, emit) async {
      navigator.goToHotelPage(event.model);
    });

    on<FetchHotelsEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));

      // await repository.test();

      // TODO: Replace with Firebase Auth user's ID
      List<HotelModel> hotels = await repository.fetchHotels(userId: '');
      emit(state.copyWith(hotels: hotels, isBusy: false));
    });
  }
}
