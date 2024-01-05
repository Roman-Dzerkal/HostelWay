part of 'create_hotel_bloc.dart';

sealed class CreateHotelEvent extends Equatable {
  const CreateHotelEvent();

  @override
  List<Object> get props => [];
}

class CreateHotelButtonTapEvent extends CreateHotelEvent {
  final String name, description, city;
  final String managerId;
  final List<String> photos;
  final List<String> facilities;
  const CreateHotelButtonTapEvent(
      {required this.name,
      required this.description,
      required this.city,
      required this.facilities,
      required this.managerId,
      required this.photos});
}
