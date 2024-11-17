import 'package:flutter/material.dart';
import 'package:hostelway/presentation/views/favorites/favorities_view.dart';

class FavoritesRoute extends PageRouteBuilder {
  FavoritesRoute()
      : super(
          pageBuilder: (context, animation1, animation2) =>
              const FavoritesView(),
          transitionDuration: Duration.zero,
          reverseTransitionDuration: Duration.zero,
        );
}
