part of 'sign_in_bloc.dart';

sealed class SignInState extends Equatable {
  final SignInErrorState errorState;
  final String email;
  final String password;
  final bool isPasswordInvisible;
  final String? errorEmailMessage;
  final String? errorPasswordMessage;

  const SignInState({
    this.email = '',
    required this.errorState,
    this.password = '',
    this.isPasswordInvisible = true,
    this.errorEmailMessage,
    this.errorPasswordMessage,
  });

  SignInState copyWith({
    String? email,
    String? password,
    bool? isPasswordInvisible,
    SignInErrorState? errorState,
    String? errorEmailMessage,
    String? errorPasswordMessage,
  }) {
    return SignInInitial(
      email: email ?? this.email,
      errorState: errorState ?? this.errorState,
      password: password ?? this.password,
      isPasswordInvisible: isPasswordInvisible ?? this.isPasswordInvisible,
      errorEmailMessage: errorEmailMessage ?? this.errorEmailMessage,
      errorPasswordMessage: errorPasswordMessage ?? this.errorPasswordMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        errorState,
        isPasswordInvisible,
        errorEmailMessage,
        errorPasswordMessage
      ];
}

final class SignInInitial extends SignInState {
  const SignInInitial({
    super.email,
    super.password,
    super.isPasswordInvisible,
    required super.errorState,
    super.errorEmailMessage,
    super.errorPasswordMessage,
  });
}
