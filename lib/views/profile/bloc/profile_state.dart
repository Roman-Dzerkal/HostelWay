part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  final bool isBusy;

  final String firstName;
  final String lastName;
  final String photoUrl;

  final XFile? image;

  const ProfileState({
    this.isBusy = false,
    this.firstName = '',
    this.lastName = '',
    this.photoUrl = '',
    this.image,
  });

  ProfileState copyWith({
    bool? isBusy,
    String? firstName,
    String? lastName,
    String? photoUrl,
    XFile? image,
  }) {
    return ProfileInitial(
      isBusy: isBusy ?? this.isBusy,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      photoUrl: photoUrl ?? this.photoUrl,
      image: image ?? this.image,
    );
  }

  @override
  List<Object?> get props => [firstName, lastName, isBusy, photoUrl, image];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial({
    super.firstName,
    super.lastName,
    super.isBusy,
    super.photoUrl,
    super.image,
  });
}
