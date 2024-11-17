import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/domain/models/hotel_model.dart';
import 'package:hostelway/domain/repositories/hotels_repository.dart';
import 'package:hostelway/presentation/views/home/navigation/home_guest_navigator.dart';
part 'home_guest_event.dart';
part 'home_guest_state.dart';

class HomeGuestBloc extends Bloc<HomeGuestEvent, HomeGuestState> {
  final HotelsRepository rep;
  final HomeGuestNavigator navigator;
  HomeGuestBloc({required this.navigator, required this.rep})
      : super(HomeGuestInitial(hotels: List.empty(growable: true), query: '')) {
    on<HomeGuestEvent>((event, emit) {});
    on<HomeGuestBlocInitialEvent>((event, emit) async {});
    on<OnTapSearchEvent>((event, emit) async {
      emit(state.copyWith(isSearching: !event.isSearching));
      if(state.isSearching==false){
        emit(state.copyWith(query: ""));
      }

    });
     on<SetQueryEvent>((event, emit) async {
      emit(state.copyWith(query: event.query));
    });
    on<OnTapHotelItemEvent>((event, emit) async {
      navigator.goToHotelPage(event.model);
    });

    on<FetchHotelsEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));
      List<HotelModel> hotels = await rep.fetchHotels(query: event.query);
      emit(state.copyWith(hotels: hotels, isBusy: false));
    });
  }
}
