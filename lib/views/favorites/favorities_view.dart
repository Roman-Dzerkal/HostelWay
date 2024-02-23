import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/views/favorites/bloc/favorites_bloc.dart';
import 'package:hostelway/views/favorites/navigation/favotites_navigator.dart';
import 'package:hostelway/widget_helpers/custom_navbar/guest_navbar.dart';
import 'package:hostelway/widget_helpers/custom_navbar/navigation/guest_navigator.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesBloc(
          navigator: FavoritesNavigator(context),
          rep: context.read<HotelsRepository>())
        ..add(const FetchFavoriteHotels()),
      child: const FavoritesLayout(),
    );
  }
}

class FavoritesLayout extends StatelessWidget {
  const FavoritesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    FavoritesBloc bloc = context.read<FavoritesBloc>();
    return BlocBuilder<FavoritesBloc, FavoritesState>(
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            bottomNavigationBar: GuestNavigationBar(
                currentIndex: 1, navigator: GuestBottomNavigator(context)),
            appBar: AppBar(
              bottom: TabBar(
                indicatorColor: CustomColors.primary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(
                      child: Text("Hotels",
                          style: TextStyling.primaryText(14, FontWeight.bold))),
                  Tab(
                      child: Text("Rooms",
                          style: TextStyling.primaryText(14, FontWeight.bold))),
                ],
              ),
              title: const Text('Favorites'),
            ),
            body: TabBarView(
              children: [
                ListView.builder(
                  itemCount: state.hotels.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: () =>
                          bloc.add(OnTapHotelItemEvent(state.hotels[index])),
                      leading: state.hotels[index].photos.isNotEmpty
                          ? Image.network(
                              state.hotels[index].photos[0],
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            )
                          : null,
                      title: Text(state.hotels[index].name),
                      subtitle: Text(state.hotels[index].city),
                      trailing: const Icon(Icons.arrow_forward_ios),
                    );
                  },
                ),
                Text("Rooms")
              ],
            ),
          ),
        );
      },
    );
  }
}
