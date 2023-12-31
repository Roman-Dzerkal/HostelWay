import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_guest_event.dart';
part 'home_guest_state.dart';

class HomeGuestBloc extends Bloc<HomeGuestEvent, HomeGuestState> {
  HomeGuestBloc() : super(HomeGuestInitial()) {
    on<HomeGuestEvent>((event, emit) {
    });
  }
}
