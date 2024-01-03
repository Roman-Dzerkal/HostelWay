import 'package:flutter/material.dart';
import 'package:hostelway/views/bookings/bookings_view.dart';

class BookingsRoute extends PageRouteBuilder {
  BookingsRoute()
      : super(
          pageBuilder: (context, animation1, animation2) =>
              const BookingsView(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
}
