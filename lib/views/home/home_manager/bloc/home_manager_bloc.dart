import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/views/home/navigation/home_manager_navigator.dart';

part 'home_manager_event.dart';
part 'home_manager_state.dart';

class HomeManagerBloc extends Bloc<HomeManagerEvent, HomeManagerState> {
  final HomeManagerNavigator navigator;

  HomeManagerBloc({required this.navigator}) : super(HomeManagerInitial()) {
    on<HomeManagerEvent>((event, emit) {});

    on<AddHotelButtonTapEvent>((event, emit) {
      debugPrint('AddHotelButtonTapEvent');
    });
  }
}
