part of 'room_page_bloc.dart';

sealed class RoomPageState extends Equatable {
  const RoomPageState();
  
  @override
  List<Object> get props => [];
}

final class RoomPageInitial extends RoomPageState {}
