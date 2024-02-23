part of 'favorites_bloc.dart';

sealed class FavoritesEvent extends Equatable {
  const FavoritesEvent();


  @override
  List<Object> get props => [];
}


class OnTapHotelItemEvent extends FavoritesEvent {
  final HotelModel model;
  const OnTapHotelItemEvent(this.model);
}

class FetchFavoriteHotels extends FavoritesEvent {
  const FetchFavoriteHotels();
}