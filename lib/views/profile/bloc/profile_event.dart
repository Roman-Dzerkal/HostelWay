part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLogoutEvent extends ProfileEvent {
  const ProfileLogoutEvent();
}
