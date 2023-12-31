part of 'home_manager_bloc.dart';

sealed class HomeManagerState extends Equatable {
  const HomeManagerState();
  
  @override
  List<Object> get props => [];
}

final class HomeManagerInitial extends HomeManagerState {}
