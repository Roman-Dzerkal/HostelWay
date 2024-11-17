part of 'bookings_bloc.dart';

sealed class BookingsState extends Equatable {
  const BookingsState();
  
  @override
  List<Object> get props => [];
}

final class BookingsInitial extends BookingsState {}
