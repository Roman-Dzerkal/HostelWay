import 'package:flutter/material.dart';
import 'package:hostelway/presentation/views/home/home_manager_view.dart';
import 'package:hostelway/presentation/views/home/navigation/home_manager_navigator.dart';

class HomeManagerRoute extends PageRouteBuilder {
  HomeManagerRoute()
      : super(
          pageBuilder: (context, animation1, animation2) {
            return HomeManagerView(
                navigator: HomeManagerNavigator(context));
          },
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
}
