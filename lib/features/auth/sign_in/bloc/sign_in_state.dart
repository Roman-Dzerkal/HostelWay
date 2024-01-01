part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  final String email;
  final String password;
  final bool isPasswordInvisible;

  const SignInState({
    this.email = '',
    this.password = '',
    this.isPasswordInvisible = true,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordInvisible,
  }) {
    return SignInInitial(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordInvisible: isPasswordInvisible ?? this.isPasswordInvisible,
    );
  }

  @override
  List<Object> get props => [
        email,
        password,
        isPasswordInvisible,
      ];
}

final class SignInInitial extends SignInState {
  const SignInInitial({super.email, super.password, super.isPasswordInvisible});
}
