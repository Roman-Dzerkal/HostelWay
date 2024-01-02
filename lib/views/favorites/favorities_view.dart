import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/views/favorites/bloc/favorites_bloc.dart';
import 'package:hostelway/widget_helpers/custom_navbar/guest_navbar.dart';
import 'package:hostelway/widget_helpers/custom_navbar/navigation/guest_navigator.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(),
      child: const FavoritesLayout(),
    );
  }
}

class FavoritesLayout extends StatelessWidget {
  const FavoritesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: GuestNavigationBar(
              currentIndex: 1, navigator: GuestBottomNavigator(context)),
          appBar: AppBar(
            title: const Text('Favorites'),
          ),
          body: const Center(
            child: Text('Favorites'),
          ),
        );
      },
    );
  }
}
