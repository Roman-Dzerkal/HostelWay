part of 'home_guest_bloc.dart';

sealed class HomeGuestState extends Equatable {
  const HomeGuestState();
  
  @override
  List<Object> get props => [];
}

final class HomeGuestInitial extends HomeGuestState {}
