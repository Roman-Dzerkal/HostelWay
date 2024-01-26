part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {

  final bool isBusy;

  final String firstName;
  final String lastName;

  const ProfileState({
    this.isBusy = false,
    this.firstName = '',
    this.lastName = '',
  });

  ProfileState copyWith({
    bool? isBusy,
    String? firstName,
    String? lastName,
  }) {
    return ProfileInitial(
      isBusy: isBusy ?? this.isBusy,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, isBusy];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({
    super.firstName,
    super.lastName,
    super.isBusy,
  });
}
