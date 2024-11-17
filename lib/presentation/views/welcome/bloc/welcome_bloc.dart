import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/presentation/views/welcome/navigation/welcome_navigator.dart';

part 'welcome_event.dart';
part 'welcome_state.dart';

class WelcomeBloc extends Bloc<WelcomeEvent, WelcomeState> {
  final WelcomeNavigator navigator;
  WelcomeBloc(this.navigator) : super(WelcomeInitial()) {

    on<WelcomeEvent>((event, emit) {});
    on<WelcomePageGetStartedButtonTapEvent>((event, emit) {
      navigator.goToSignInPage();
    },);
  }
}
