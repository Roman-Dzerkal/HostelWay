part of 'sign_in_bloc.dart';

sealed class SignInEvent extends Equatable {
  const SignInEvent();

  @override
  List<Object> get props => [];
}

class SignInEmailChanged extends SignInEvent {
  final String email;

  const SignInEmailChanged(this.email);
}

class SignInPasswordChanged extends SignInEvent {
  final String password;

  const SignInPasswordChanged(this.password);
}

class SignInSubmitted extends SignInEvent {
  const SignInSubmitted();
}

class SignInWithGooglePressed extends SignInEvent {}

class SignInWithFacebookPressed extends SignInEvent {}

class SignUpTextTapEvent extends SignInEvent {}

class SignInPasswordVisibleChanged extends SignInEvent {}

class EmailFormSubmittedEvent extends SignInEvent {
  final String email;

  const EmailFormSubmittedEvent({
    required this.email,
  });
}

class PasswordFormSubmittedEvent extends SignInEvent {
  final String password;

  const PasswordFormSubmittedEvent({
    required this.password,
  });
}