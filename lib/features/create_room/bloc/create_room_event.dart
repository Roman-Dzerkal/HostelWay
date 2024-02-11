part of 'create_room_bloc.dart';

sealed class CreateRoomEvent extends Equatable {
  const CreateRoomEvent();

  @override
  List<Object> get props => [];
}

class RemoveImageEvent extends CreateRoomEvent {
  final int index;
  const RemoveImageEvent(this.index);
}

class CreateRoomButtonTapEvent extends CreateRoomEvent {


}

class UploadOnePhotoButtonTapEvent extends CreateRoomEvent {}

class UploadPhotoButtonTapEvent extends CreateRoomEvent {}

class DescriptionSubmittedEvent extends CreateRoomEvent {
  final String description;
  const DescriptionSubmittedEvent(this.description);
}

class NameSubmittedEvent extends CreateRoomEvent {
  final String name;
  const NameSubmittedEvent(this.name);
}

// ============== Change events ==============

class DescriptionChangedEvent extends CreateRoomEvent {
  final String description;
  const DescriptionChangedEvent(this.description);
}

class NameChangedEvent extends CreateRoomEvent {
  final String name;
  const NameChangedEvent(this.name);
}

class PriceChangedEvent extends CreateRoomEvent {
  final int price;
  const PriceChangedEvent(this.price);
}