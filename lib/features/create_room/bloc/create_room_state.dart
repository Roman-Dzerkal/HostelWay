part of 'create_room_bloc.dart';

sealed class CreateRoomState extends Equatable {
  const CreateRoomState(
      {this.name = '',
      this.description = '',
      this.errorDescriptionMessage = '',
      this.errorNameMessage = '',
      this.hotelId = '',
      this.price = 0,
      this.photos = const [],
      this.localPhotos = const [],
      required this.errorState,
      this.isBusy = false});

  final String name, description;
  final String hotelId;
  final List<String> photos;
  final List<XFile> localPhotos;
  final int price;
  final String errorNameMessage;
  final String errorDescriptionMessage;
  final CreateRoomErrorState errorState;

  final bool isBusy;

  CreateRoomState copyWith({
    String? name,
    String? description,
    int ? price,
    String? hotelId,
    List<String>? photos,
    List<XFile>? localPhotos,
    String? errorNameMessage,
    String? errorDescriptionMessage,
    CreateRoomErrorState? errorState,
    bool? isBusy,
  }) {
    return CreateRoomInitial(
      price: price??this.price,
      errorState: errorState ?? this.errorState,
      name: name ?? this.name,
      description: description ?? this.description,
      hotelId: hotelId ?? this.hotelId,
      photos: photos ?? this.photos,
      localPhotos: localPhotos ?? this.localPhotos,
      errorNameMessage: errorNameMessage ?? this.errorNameMessage,
      errorDescriptionMessage:
          errorDescriptionMessage ?? this.errorDescriptionMessage,
      isBusy: isBusy ?? this.isBusy,
    );
  }

  @override
  List<Object> get props => [
        name,
        description,
        price,
        hotelId,
        photos,
        localPhotos,
        errorNameMessage,
        errorDescriptionMessage,
        errorState,
        isBusy,
      ];
}

final class CreateRoomInitial extends CreateRoomState {
  CreateRoomInitial({
    super.name,
    super.description,
    super.price,
    super.hotelId,
    super.photos,
    super.localPhotos,
    super.errorNameMessage,
    super.errorDescriptionMessage,
    required super.errorState,
    super.isBusy,
  });
}
