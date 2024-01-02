import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/views/home/home_guest/bloc/home_guest_bloc.dart';
import 'package:hostelway/views/home/navigation/home_guest_navigator.dart';
import 'package:hostelway/widget_helpers/custom_hotel_item.dart';
import 'package:hostelway/widget_helpers/custom_navbar/guest_navbar.dart';
import 'package:hostelway/widget_helpers/custom_navbar/navigation/guest_navigator.dart';

class HomeGuestView extends StatelessWidget {
  const HomeGuestView({super.key, required HomeGuestNavigator navigator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeGuestBloc(context.read<HotelsRepository>())
        ..add(const HomeGuestBlocInitialEvent()),
      child: const HomeGuestLayout(),
    );
  }
}

class HomeGuestLayout extends StatelessWidget {
  const HomeGuestLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeGuestBloc, HomeGuestState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: GuestNavigationBar(
                currentIndex: 0, navigator: GuestBottomNavigator(context)),
            appBar: AppBar(
              title: const Text('HomeGuest'),
            ),
            body: ListView(
              children: state.hotels
                  .map((HotelModel hotel) => CustomHotelItem(hotel, 200.h))
                  .toList(),
            ));
      },
    );
  }
}
