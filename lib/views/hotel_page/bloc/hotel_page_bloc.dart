import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/views/hotel_page/navigation/hotel_page_navigator.dart';
import 'package:place_picker/place_picker.dart';

part 'hotel_page_event.dart';
part 'hotel_page_state.dart';

class HotelPageBloc extends Bloc<HotelPageEvent, HotelPageState> {
  final HotelPageNavigator navigator;
  final HotelModel model;
  final HotelsRepository rep;
  HotelPageBloc(
      {required this.navigator, required this.model, required this.rep})
      : super(HotelPageInitial()) {
    on<HotelPageEvent>((event, emit) {});
    
    on<OpenHotelPositionEvent>((event, emit) {
      navigator.openHotelGoogleMaps(event.latLng);
    });

    on<AddToFavoritesEvent>((event, emit) {
      rep.addFavorites(event.id);
    });
  }
}
