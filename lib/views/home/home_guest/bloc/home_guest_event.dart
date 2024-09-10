part of 'home_guest_bloc.dart';

sealed class HomeGuestEvent extends Equatable {
  const HomeGuestEvent();

  @override
  List<Object> get props => [];
}

class HomeGuestBlocInitialEvent extends HomeGuestEvent {
  const HomeGuestBlocInitialEvent();
}

class OnTapSearchEvent extends HomeGuestEvent {
  final bool isSearching;
  const OnTapSearchEvent(this.isSearching);
}
class SetQueryEvent extends HomeGuestEvent {
  final String query;
  const SetQueryEvent(this.query);
}
class OnTapHotelItemEvent extends HomeGuestEvent {
  final HotelModel model;
  const OnTapHotelItemEvent(this.model);
}

class FetchHotelsEvent extends HomeGuestEvent {
  final String query; 
  const FetchHotelsEvent(this.query);
}
