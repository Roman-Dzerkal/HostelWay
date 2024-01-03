import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/views/hotel_page/bloc/hotel_page_bloc.dart';



class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HotelPageBloc(),
      child: const FavoritesLayout(),
    );
  }
}

class FavoritesLayout extends StatelessWidget {
  const FavoritesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder< HotelPageBloc, HotelPageState>(
      builder: (context, state) {
        return Scaffold(
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
