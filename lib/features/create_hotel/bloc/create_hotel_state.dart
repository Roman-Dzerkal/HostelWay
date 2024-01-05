part of 'create_hotel_bloc.dart';

sealed class CreateHotelState extends Equatable {
  const CreateHotelState(
      {this.name = '',
      this.description = '',
      this.city = '',
      this.facilities = const [],
      this.managerId = '',
      this.photos = const []});

  final String name, description, city;
  final String managerId;
  final List<String> photos;
  final List<String> facilities;

  CreateHotelState copyWith({
    String? name,
    String? description,
    String? city,
    String? managerId,
    List<String>? photos,
    List<String>? facilities,
  }) {
    return CreateHotelInitial(
      name: name ?? this.name,
      description: description ?? this.description,
      city: city ?? this.city,
      managerId: managerId ?? this.managerId,
      photos: photos ?? this.photos,
      facilities: facilities ?? this.facilities,
    );
  }

  @override
  List<Object> get props =>
      [name, description, city, managerId, photos, facilities];
}

final class CreateHotelInitial extends CreateHotelState {
  const CreateHotelInitial({
    super.name,
    super.description,
    super.city,
    super.managerId,
    super.photos,
    super.facilities,
  });
}
