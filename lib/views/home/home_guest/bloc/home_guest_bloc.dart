import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';

part 'home_guest_event.dart';
part 'home_guest_state.dart';

class HomeGuestBloc extends Bloc<HomeGuestEvent, HomeGuestState> {
  final HotelsRepository rep;
  HomeGuestBloc(this.rep) : super(const HomeGuestInitial()) {
    on<HomeGuestEvent>((event, emit) {});
    on<HomeGuestBlocInitialEvent>((event, emit) async {
      List<HotelModel> hotels = await rep.getHotels();
      emit(state.copyWith(hotels: hotels));
    });
    on<OnTapHotelItemEvent>((event, emit) async {
      event.model;
    });
  }
}
