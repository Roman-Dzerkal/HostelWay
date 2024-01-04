part of 'home_guest_bloc.dart';

sealed class HomeGuestEvent extends Equatable {
  const HomeGuestEvent();
  

  @override
  List<Object> get props => [];
}

class HomeGuestBlocInitialEvent extends HomeGuestEvent {
  const HomeGuestBlocInitialEvent();
}


class OnTapHotelItemEvent extends HomeGuestEvent {
  final HotelModel model;
  const OnTapHotelItemEvent(this.model);
}
