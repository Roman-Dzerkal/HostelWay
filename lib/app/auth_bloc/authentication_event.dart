part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitialEvent extends AuthenticationEvent {}

final class AuthenticationSaveUserInformationEvent extends AuthenticationEvent {
  final UserModel userModel;
  final VoidCallback voidCallback;

  const AuthenticationSaveUserInformationEvent(
      {required this.voidCallback, required this.userModel});

  @override
  List<Object> get props => [userModel];
}

final class AuthenticationLogoutEvent extends AuthenticationEvent {}
