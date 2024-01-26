part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class PasswordResetButtonTapEvent extends ForgotPasswordEvent {}

class EmailChangedEvent extends ForgotPasswordEvent {
  final String email;

  EmailChangedEvent(this.email);
}
