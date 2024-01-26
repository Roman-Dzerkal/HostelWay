part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class ProfileLogoutEvent extends ProfileEvent {
  const ProfileLogoutEvent();
}

class ProfileLoadEvent extends ProfileEvent {
  const ProfileLoadEvent();
}

class ProfilePhotoChangedEvent extends ProfileEvent {}

class ProfileSaveEvent  extends ProfileEvent {}