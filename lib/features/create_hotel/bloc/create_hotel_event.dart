part of 'create_hotel_bloc.dart';

sealed class CreateHotelEvent extends Equatable {
  const CreateHotelEvent();

  @override
  List<Object> get props => [];
}

class RemoveImageEvent extends CreateHotelEvent {
  final int index;
  const RemoveImageEvent(this.index);
}

class UploadPhotoButtonTapEvent extends CreateHotelEvent {}

class CreateHotelButtonTapEvent extends CreateHotelEvent {}

class UploadOnePhotoButtonTapEvent extends CreateHotelEvent {}

// ============== Submiters ==============

class DescriptionSubmittedEvent extends CreateHotelEvent {
  final String description;
  const DescriptionSubmittedEvent(this.description);
}

// ============== Change events ==============

class DescriptionChangedEvent extends CreateHotelEvent {
  final String description;
  const DescriptionChangedEvent(this.description);
}
