import 'package:flutter/material.dart';
import 'package:hostelway/views/profile/profile_view.dart';

class ProfileRoute extends PageRouteBuilder {
  ProfileRoute()
      : super(
          pageBuilder: (context, animation1, animation2) => const ProfileView(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
}
