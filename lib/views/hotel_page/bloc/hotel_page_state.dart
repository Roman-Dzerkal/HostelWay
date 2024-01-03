part of 'hotel_page_bloc.dart';

sealed class HotelPageState extends Equatable {
  const HotelPageState();
  
  @override
  List<Object> get props => [];
}

final class HotelPageInitial extends HotelPageState {}
