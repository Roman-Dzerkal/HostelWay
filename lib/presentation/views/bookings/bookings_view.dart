import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/presentation/views/bookings/bloc/bookings_bloc.dart';
import 'package:hostelway/presentation/widgets/custom_navbar/guest_navbar.dart';
import 'package:hostelway/presentation/widgets/custom_navbar/navigation/guest_navigator.dart';

class BookingsView extends StatelessWidget {
  const BookingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingsBloc(),
      child: const BookingsLayout(),
    );
  }
}

class BookingsLayout extends StatelessWidget {
  const BookingsLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingsBloc, BookingsState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: GuestNavigationBar(
              currentIndex: 2, navigator: GuestBottomNavigator(context)),
          appBar: AppBar(
            title: const Text('Bookings'),
          ),
          body: const Center(
            child: Text('Bookings'),
          ),
        );
      },
    );
  }
}
