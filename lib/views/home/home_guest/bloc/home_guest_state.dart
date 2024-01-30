part of 'home_guest_bloc.dart';

sealed class HomeGuestState extends Equatable {
  final List<HotelModel> hotels;

  final bool isBusy;

  const HomeGuestState({required this.hotels, this.isBusy = false});


 HomeGuestState copyWith({List<HotelModel>? hotels, bool? isBusy}) {
    return HomeGuestInitial(
        hotels: hotels ?? this.hotels, isBusy: isBusy ?? this.isBusy);
  }

  @override
  List<Object> get props => [hotels, isBusy];
}

final class HomeGuestInitial extends HomeGuestState {
  const HomeGuestInitial({required super.hotels, super.isBusy});
}
