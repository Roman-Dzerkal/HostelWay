import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/views/home/home_guest/bloc/home_guest_bloc.dart';
import 'package:hostelway/views/home/navigation/home_guest_navigator.dart';
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
          rep: context.read<HotelsRepository>()),
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
                title: state.isSearching
                    ? _buildSearchField(bloc)
                    : const Text(''),
                actions: [
                  !state.isSearching
                      ? IconButton(
                          onPressed: () =>
                              bloc.add(OnTapSearchEvent(state.isSearching)),
                          icon: const Icon(Icons.search))
                      : IconButton(
                          onPressed: () =>
                              bloc.add(OnTapSearchEvent(state.isSearching)),
                          icon: const Icon(Icons.close))
                ]),
            body: /*state.isBusy
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    physics: const ScrollPhysics(
                      parent: BouncingScrollPhysics(),
                    ),
                    shrinkWrap: true,
                    itemCount: state.hotels.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () =>
                            bloc.add(OnTapHotelItemEvent(state.hotels[index])),
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
                  )
                  */
                FutureBuilder<List<HotelModel>>(
                    future: bloc.rep.fetchHotels(query: state.query),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        // if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text(
                            'No hotels found',
                            style: TextStyle(),
                          ),
                        );
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return Column(
                        children: [
                          for (HotelModel hotel in snapshot.data!)
                            ListTile(
                              onTap: () => bloc.add(OnTapHotelItemEvent(hotel)),
                              leading: Image.network(
                                hotel.photos[0],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                              title: Text(hotel.name),
                              subtitle: Text(hotel.city),
                              trailing: const Icon(Icons.arrow_forward_ios),
                            ),
                        ],
                      ); /*ListView.builder(
                        physics: const ScrollPhysics(
                          parent: BouncingScrollPhysics(),
                        ),
                        shrinkWrap: true,
                        itemCount: state.hotels.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            onTap: () => bloc
                                .add(OnTapHotelItemEvent(state.hotels[index])),
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
                      );*/
                      // } else {

                      // }
                    }));
      },
    );
  }

  Widget _buildSearchField(HomeGuestBloc bloc) {
    return TextField(
      //controller: TextEditingController(),
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
      ),
      onChanged: (value) {
        log(value);
        bloc.add(SetQueryEvent(value));
      },
    );
  }
}
