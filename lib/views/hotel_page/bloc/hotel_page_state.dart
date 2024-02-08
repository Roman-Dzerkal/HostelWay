part of 'hotel_page_bloc.dart';

sealed class HotelPageState extends Equatable {
  /*final String role =
      Supabase.instance.client.auth.currentUser?.userMetadata?['role'];*/
  final List<RoomModel> rooms;
  const HotelPageState({required this.rooms});
  HotelPageState copyWith({List<RoomModel>? rooms, bool? isBusy}) {
    return HotelPageInitial(rooms: rooms ?? this.rooms);
  }

  @override
  List<Object> get props => [rooms];
}

final class HotelPageInitial extends HotelPageState {
  const HotelPageInitial({required super.rooms});
}
