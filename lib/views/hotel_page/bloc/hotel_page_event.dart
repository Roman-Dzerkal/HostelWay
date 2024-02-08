part of 'hotel_page_bloc.dart';

sealed class HotelPageEvent extends Equatable {
  const HotelPageEvent();

  @override
  List<Object> get props => [];
}

class OpenHotelPositionEvent extends HotelPageEvent {
  final LatLng latLng;
  const OpenHotelPositionEvent(this.latLng);
}

class AddToFavoritesEvent extends HotelPageEvent {
  final int id;
  const AddToFavoritesEvent(this.id);
}
class FetchRoomsEvent extends HotelPageEvent {
  final int hotelId;
  const FetchRoomsEvent(this.hotelId);
}
