import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'room_page_event.dart';
part 'room_page_state.dart';

class RoomPageBloc extends Bloc<RoomPageEvent, RoomPageState> {
  RoomPageBloc() : super(RoomPageInitial()) {
    on<RoomPageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
