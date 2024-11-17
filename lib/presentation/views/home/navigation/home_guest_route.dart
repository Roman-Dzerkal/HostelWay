import 'package:flutter/material.dart';
import 'package:hostelway/presentation/views/home/home_guest_view.dart';
import 'package:hostelway/presentation/views/home/navigation/home_guest_navigator.dart';

class HomeGuestRoute extends PageRouteBuilder {
  HomeGuestRoute()
      : super(
          pageBuilder: (context, animation1, animation2) =>
              HomeGuestView(navigator: HomeGuestNavigator(context)),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
}
