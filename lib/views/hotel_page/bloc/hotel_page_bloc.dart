import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/models/hotel_model.dart';

part 'hotel_page_event.dart';
part 'hotel_page_state.dart';

class HotelPageBloc extends Bloc<HotelPageEvent, HotelPageState> {
  HotelPageBloc(HotelModel model) : super(HotelPageInitial()) {
    on<HotelPageEvent>((event, emit) {});
    

  }
}
