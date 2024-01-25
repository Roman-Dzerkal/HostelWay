part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  final bool isBusy;

  final String email;

  const ForgotPasswordState({
    this.email = '',
    this.isBusy = false,
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isBusy,
  }) {
    return ForgotPasswordInitial(
      email: email ?? this.email,
      isBusy: isBusy ?? this.isBusy,
    );
  }

  @override
  List<Object> get props => [
        email,
        isBusy,
      ];
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial({
    super.email,
    super.isBusy,
  });
}
