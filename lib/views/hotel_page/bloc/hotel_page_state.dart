part of 'hotel_page_bloc.dart';

sealed class HotelPageState extends Equatable {
  /*final String role =
      Supabase.instance.client.auth.currentUser?.userMetadata?['role'];*/
  final List<RoomModel> rooms;
  final bool isBusy;

  const HotelPageState({required this.rooms, this.isBusy = false});
  HotelPageState copyWith({List<RoomModel>? rooms, bool? isBusy}) {
    return HotelPageInitial(
        rooms: rooms ?? this.rooms, isBusy: isBusy ?? this.isBusy);
  }

  @override
  List<Object> get props => [rooms, isBusy];
}

final class HotelPageInitial extends HotelPageState {
  const HotelPageInitial({required super.rooms, super.isBusy});
}
