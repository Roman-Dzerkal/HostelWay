part of 'create_hotel_bloc.dart';

sealed class CreateHotelEvent extends Equatable {
  const CreateHotelEvent();

  @override
  List<Object> get props => [];
}

class OnTapAddPhotoEvent extends CreateHotelEvent {}
