part of 'home_guest_bloc.dart';

sealed class HomeGuestState extends Equatable {
  final List<HotelModel> hotels;

  const HomeGuestState({this.hotels = const []});

  HomeGuestState copyWith({
    List<HotelModel>? hotels,
  }) {
    return HomeGuestInitial(
      hotels: hotels ?? this.hotels,
    );
  }

  @override
  List<Object> get props => [hotels];
}

final class HomeGuestInitial extends HomeGuestState {
  const HomeGuestInitial({super.hotels});
}
