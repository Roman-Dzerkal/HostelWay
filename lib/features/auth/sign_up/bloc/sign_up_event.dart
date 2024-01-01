part of 'sign_up_bloc.dart';

sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpEmailChangedEvent extends SignUpEvent {
  final String email;

  const SignUpEmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChangedEvent extends SignUpEvent {
  final String password;

  const SignUpPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class SignUpConfirmPasswordChangedEvent extends SignUpEvent {
  final String confirmPassword;

  const SignUpConfirmPasswordChangedEvent(this.confirmPassword);

  @override
  List<Object> get props => [confirmPassword];
}

class SignUpButtonPressedEvent extends SignUpEvent {
  const SignUpButtonPressedEvent();
}

class PasswordVisibilityChangedEvent extends SignUpEvent {
  const PasswordVisibilityChangedEvent();
}

class ConfirmPasswordVisibilityChangedEvent extends SignUpEvent {
  const ConfirmPasswordVisibilityChangedEvent();
}

class SignUpRoleChangedEvent extends SignUpEvent {
  final int index;

  const SignUpRoleChangedEvent(this.index);

  @override
  List<Object> get props => [index];
}

class SignUpFirstNameChangedEvent extends SignUpEvent {
  final String firstName;

  const SignUpFirstNameChangedEvent(this.firstName);

  @override
  List<Object> get props => [firstName];
}

class SignUpLastNameChangedEvent extends SignUpEvent {
  final String lastName;

  const SignUpLastNameChangedEvent(this.lastName);

  @override
  List<Object> get props => [lastName];
}