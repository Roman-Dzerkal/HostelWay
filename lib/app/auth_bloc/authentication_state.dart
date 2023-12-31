part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  final AuthModel? authModel;
  final UserModel? userModel;

  const AuthenticationState({required this.authModel, required this.userModel});

  AuthenticationState copyWith({AuthModel? authModel, UserModel? userModel}) {
    return AuthenticationInitial(
        authModel: authModel ?? this.authModel,
        userModel: userModel ?? this.userModel);
  }

  @override
  List<Object?> get props => [userModel, authModel];
}

final class AuthenticationInitial extends AuthenticationState {
  const AuthenticationInitial(
      {required super.authModel, required super.userModel});
}

final class AuthenticationIsAuthenticated extends AuthenticationState {
  const AuthenticationIsAuthenticated(
      {required super.authModel, required super.userModel});
}

final class AuthenticationIsUnthenticated extends AuthenticationState {
  const AuthenticationIsUnthenticated(
      {required super.authModel, required super.userModel});
}
