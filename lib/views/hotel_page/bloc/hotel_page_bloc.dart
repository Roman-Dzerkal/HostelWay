import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'hotel_page_event.dart';
part 'hotel_page_state.dart';

class HotelPageBloc extends Bloc<HotelPageEvent, HotelPageState> {
  HotelPageBloc() : super(HotelPageInitial()) {
    on<HotelPageEvent>((event, emit) {});
  }
}
