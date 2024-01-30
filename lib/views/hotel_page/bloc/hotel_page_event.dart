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
