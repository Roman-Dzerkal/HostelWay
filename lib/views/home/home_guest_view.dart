import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/views/home/home_guest/bloc/home_guest_bloc.dart';
import 'package:hostelway/views/home/navigation/home_guest_navigator.dart';
import 'package:hostelway/widget_helpers/custom_hotel_item.dart';
import 'package:hostelway/widget_helpers/custom_navbar/guest_navbar.dart';
import 'package:hostelway/widget_helpers/custom_navbar/navigation/guest_navigator.dart';

class HomeGuestView extends StatelessWidget {
  const HomeGuestView({super.key, required this.navigator});
  final HomeGuestNavigator navigator;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
       create: (context) => HomeGuestBloc(
          navigator: HomeGuestNavigator(context),
          rep: context.read<HotelsRepository>())
        ..add(const FetchHotelsEvent()),
      child: HomeGuestLayout(navigator: navigator),
    );
  }
}

class HomeGuestLayout extends StatelessWidget {
  const HomeGuestLayout({super.key, required this.navigator});
  final HomeGuestNavigator navigator;

  @override
  Widget build(BuildContext context) {
    HomeGuestBloc bloc = context.read<HomeGuestBloc>();
    return BlocBuilder<HomeGuestBloc, HomeGuestState>(
      builder: (context, state) {
        return Scaffold(
            bottomNavigationBar: GuestNavigationBar(
                currentIndex: 0, navigator: GuestBottomNavigator(context)),
            appBar: AppBar(
              title: const Text('HomeGuest'),
            ),
            /*body: ListView(
              children: state.hotels
                  .map((HotelModel hotel) => CustomHotelItem(hotel, 100.h, ()=> bloc.add(OnTapHotelItemEvent(state.hotels.first))))
                  .toList(),
            )*/
              body: state.isBusy
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: state.hotels.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () => bloc.add(OnTapHotelItemEvent(state.hotels[index])),
                        leading: Image.network(
                          state.hotels[index].photos[0],
                          width: 60,
                          height: 60,
                          fit: BoxFit.cover,
                        ),
                        title: Text(state.hotels[index].name),
                        subtitle: Text(state.hotels[index].city),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      );
                    },
                  ));
      },
    );
  }
}
