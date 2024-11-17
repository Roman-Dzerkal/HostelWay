// ignore_for_file: must_be_immutable

part of 'create_hotel_bloc.dart';

sealed class CreateHotelState extends Equatable {
  CreateHotelState(
      {this.name = '',
      this.description = '',
      this.city = '',
      this.errorDescriptionMessage = '',
      this.errorNameMessage = '',
      this.facilities = const ['Wifi', 'Parking', 'Pool', 'Breakfast'],
      this.managerId = '',
      this.photos = const [],
      this.localPhotos = const [],
      required this.errorState,
      this.currentUserLocation,
      // this.hotelLocation,
      this.errorLocationMessage = '',
      this.isBusy = false});

  final String name, description, city;
  final String managerId;
  final List<String> photos;
  List<XFile> localPhotos;
  final List<String> facilities;

  final String errorNameMessage;
  final String errorDescriptionMessage;
  final String errorLocationMessage;
  final CreateHotelErrorState errorState;

  final bool isBusy;

  final Position? currentUserLocation;
  // final LocationResult? hotelLocation;

  CreateHotelState copyWith({
    String? name,
    String? description,
    String? city,
    String? managerId,
    List<String>? photos,
    List<XFile>? localPhotos,
    List<String>? facilities,
    String? errorNameMessage,
    String? errorDescriptionMessage,
    CreateHotelErrorState? errorState,
    bool? isBusy,
    Position? currentUserLocation,
    // LocationResult? hotelLocation,
    String? errorLocationMessage,
  }) {
    return CreateHotelInitial(
      errorState: errorState ?? this.errorState,
      name: name ?? this.name,
      description: description ?? this.description,
      city: city ?? this.city,
      managerId: managerId ?? this.managerId,
      photos: photos ?? this.photos,
      localPhotos: localPhotos ?? this.localPhotos,
      facilities: facilities ?? this.facilities,
      errorNameMessage: errorNameMessage ?? this.errorNameMessage,
      errorDescriptionMessage:
          errorDescriptionMessage ?? this.errorDescriptionMessage,
      isBusy: isBusy ?? this.isBusy,
      currentUserLocation: currentUserLocation ?? this.currentUserLocation,
      // hotelLocation: hotelLocation ?? this.hotelLocation,
      errorLocationMessage: errorLocationMessage ?? this.errorLocationMessage,
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        city,
        managerId,
        photos,
        facilities,
        localPhotos,
        errorNameMessage,
        errorDescriptionMessage,
        errorState,
        isBusy,
        currentUserLocation,
        // hotelLocation,
        errorLocationMessage,
      ];
}

final class CreateHotelInitial extends CreateHotelState {
  CreateHotelInitial({
    super.name,
    super.description,
    super.city,
    super.managerId,
    super.photos,
    super.localPhotos,
    super.facilities,

    super.errorNameMessage,
    super.errorDescriptionMessage,

    required super.errorState,
    super.isBusy,

    super.currentUserLocation,
    // super.hotelLocation,
    super.errorLocationMessage,
  });
}
