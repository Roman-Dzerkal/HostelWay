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
  final String id;
  const AddToFavoritesEvent(this.id);
}

class FetchRoomsEvent extends HotelPageEvent {
  final String hotelId;
  const FetchRoomsEvent(this.hotelId);
}

class CreateRoomButtonTapEvent extends HotelPageEvent {
  final String hotelId;
  const CreateRoomButtonTapEvent(this.hotelId);
}
