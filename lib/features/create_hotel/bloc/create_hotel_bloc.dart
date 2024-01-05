import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/features/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/repositories/hotels_repository.dart';

part 'create_hotel_event.dart';
part 'create_hotel_state.dart';

class CreateHotelBloc extends Bloc<CreateHotelEvent, CreateHotelState> {
  final  CreateHotelNavigator navigator;
  final HotelsRepository hotelsRepository;
  CreateHotelBloc({required this.navigator, required this.hotelsRepository}) : super(const CreateHotelInitial()) {
    on<CreateHotelEvent>((event, emit) {
      // TODO: implement event handler
    });
     on<CreateHotelButtonTapEvent>((event, emit) {
       //emit(state.copyWith(city: event.city, description: event.description, facilities: event.facilities, managerId: event.managerId,name: event.name, photos: event.photos));
       hotelsRepository.createHotel(HotelModel(city: event.city, description: event.description, facilities: event.facilities, managerId: event.managerId,name: event.name, photos: event.photos));
    });
  }
}
