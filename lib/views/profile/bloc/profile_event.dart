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

class LastNameChangeEvent extends ProfileEvent {
  final String lastName;
  const LastNameChangeEvent(this.lastName);
}
class FirstNameChangeEvent extends ProfileEvent {
  final String firstName;
  const FirstNameChangeEvent(this.firstName);
}
class ProfilePhotoChangedEvent extends ProfileEvent {}

class ProfileSaveEvent extends ProfileEvent {}

class TestEvent extends ProfileEvent {}
