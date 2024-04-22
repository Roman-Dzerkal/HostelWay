part of 'home_guest_bloc.dart';

sealed class HomeGuestState extends Equatable {
  final List<HotelModel> hotels;
  final bool isSearching;
  final bool isBusy;
  final String query;
  const HomeGuestState(
      {required this.hotels, this.isBusy = false, this.isSearching = false,  this.query=''});

  HomeGuestState copyWith(
      {List<HotelModel>? hotels, bool? isBusy, bool? isSearching, String? query}) {
    return HomeGuestInitial(
        hotels: hotels ?? this.hotels,
        isBusy: isBusy ?? this.isBusy,
        isSearching: isSearching ?? this.isSearching,
        query: query??this.query);
  }

  @override
  List<Object> get props => [hotels, isBusy, isSearching,query];
}

final class HomeGuestInitial extends HomeGuestState {
  const HomeGuestInitial(
      {required super.hotels, super.isBusy, super.isSearching, required super.query});
}
