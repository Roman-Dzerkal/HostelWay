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

class FetchCurrentLocationEvent extends CreateHotelEvent {}

class LocationChangedEvent extends CreateHotelEvent {
  final LocationResult location;
  const LocationChangedEvent(this.location);
}

// ============== Submiters ==============

class DescriptionSubmittedEvent extends CreateHotelEvent {
  final String description;
  const DescriptionSubmittedEvent(this.description);
}


class NameSubmittedEvent extends CreateHotelEvent {
  final String name;
  const NameSubmittedEvent(this.name);
}

// ============== Change events ==============

class DescriptionChangedEvent extends CreateHotelEvent {
  final String description;
  const DescriptionChangedEvent(this.description);
}

class NameChangedEvent extends CreateHotelEvent {
  final String name;
  const NameChangedEvent(this.name);
}
