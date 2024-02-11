import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/views/home/home_manager/bloc/home_manager_bloc.dart';
import 'package:hostelway/views/home/navigation/home_manager_navigator.dart';
import 'package:hostelway/widget_helpers/custom_navbar/manager_navbar.dart';
import 'package:hostelway/widget_helpers/custom_navbar/navigation/manager_navigator.dart';

class HomeManagerView extends StatelessWidget {
  const HomeManagerView({super.key, required HomeManagerNavigator navigator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeManagerBloc(
          navigator: HomeManagerNavigator(context),
          repository: context.read<HotelsRepository>())
        ..add(const FetchHotelsEvent()),
      child: const HomeManagerLayout(),
    );
  }
}

class HomeManagerLayout extends StatelessWidget {
  const HomeManagerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    HomeManagerBloc bloc = context.read<HomeManagerBloc>();
    return BlocBuilder<HomeManagerBloc, HomeManagerState>(
      builder: (context, state) {
        return Scaffold(
            floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  bloc.add(const AddHotelButtonTapEvent());
                },
                backgroundColor: CustomColors.primary,
                child: const Icon(Icons.add, color: CustomColors.white)),
            bottomNavigationBar: ManagerNavigationBar(
                currentIndex: 0, navigator: ManagerBottomNavigator(context)),
            appBar: AppBar(
              title: const Text('HomeManager'),
            ),
            body: state.isBusy
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
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
                  ));
      },
    );
  }
}
