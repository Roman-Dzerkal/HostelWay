part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordResetButtonTapEvent extends ForgotPasswordEvent {}

class EmailFormSubmittedEvent extends ForgotPasswordEvent {
  final String email;

  const EmailFormSubmittedEvent({
    required this.email,
  });
}

class ForgotPasswordEmailChangedEvent extends ForgotPasswordEvent {
  final String email;

  const ForgotPasswordEmailChangedEvent(this.email);
}
