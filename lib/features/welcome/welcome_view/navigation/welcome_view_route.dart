import 'package:flutter/material.dart';
import 'package:hostelway/features/welcome/welcome_view/welcome_view.dart';

class WelcomeViewRoute extends MaterialPageRoute {
  WelcomeViewRoute()
      : super(
          builder: (context) => const WelcomeView(),
        );
}
