import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/views/home/navigation/home_guest_navigator.dart';
part 'home_guest_event.dart';
part 'home_guest_state.dart';

class HomeGuestBloc extends Bloc<HomeGuestEvent, HomeGuestState> {
  final HotelsRepository rep;
  final HomeGuestNavigator navigator;
  HomeGuestBloc({required this.navigator, required this.rep}) : super(HomeGuestInitial(hotels: List.empty(growable: true))) {
    on<HomeGuestEvent>((event, emit) {});
    on<HomeGuestBlocInitialEvent>((event, emit) async {
    
    });
    on<OnTapHotelItemEvent>((event, emit) async {
      navigator.goToHotelPage(event.model);
    });

    on<FetchHotelsEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));
      List<HotelModel> hotels = await rep.fetchHotels();
      emit(state.copyWith(hotels: hotels, isBusy: false));
    });
  }
}
