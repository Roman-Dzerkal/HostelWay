import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/views/favorites/navigation/favotites_navigator.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final HotelsRepository rep;
   final FavoritesNavigator navigator;
  FavoritesBloc({required this.navigator, required this.rep}) : super(const FavoritesInitial(hotels: [])) {
    on<FavoritesEvent>((event, emit) {});
    on<FetchFavoriteHotels>((event, emit) async {
      List<HotelModel> hotels = await rep.fetchFavoriteHotels();
      emit(state.copyWith(hotels: hotels));
    
    });
     on<OnTapHotelItemEvent>((event, emit) async {
      navigator.goToHotelPage(event.model);
    });
  }
}
