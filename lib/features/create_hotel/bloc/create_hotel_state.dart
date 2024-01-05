part of 'create_hotel_bloc.dart';

sealed class CreateHotelState extends Equatable {
  final List<File> photos;

  const CreateHotelState({
    this.photos = const [],
  });

  CreateHotelState copyWith({
    List<File>? photos,
  }) {
    return CreateHotelInitial(
      photos: photos ?? this.photos,
    );
  }

  @override
  List<Object> get props => [photos];
}

final class CreateHotelInitial extends CreateHotelState {
  const CreateHotelInitial({
    super.photos,
  });
}
