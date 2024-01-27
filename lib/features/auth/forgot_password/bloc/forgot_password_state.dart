part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordState extends Equatable {
  final bool isBusy;
  final String? errorEmailMessage;
  final String email;
  final ForgotPasswordErrorState errorState;

  const ForgotPasswordState({
    this.errorEmailMessage,
    this.email = '',
    this.isBusy = false,
    required this.errorState
  });

  ForgotPasswordState copyWith({
    String? email,
    bool? isBusy,
    ForgotPasswordErrorState? errorState,
    String? errorEmailMessage,

  }) {
    return ForgotPasswordInitial(
      email: email ?? this.email,
      isBusy: isBusy ?? this.isBusy,
      errorEmailMessage: errorEmailMessage ?? this.errorEmailMessage,
      errorState: errorState ?? this.errorState,
    );
  }

  @override
  List<Object?> get props => [
        email,
        isBusy,
        errorState,
        errorEmailMessage,
      ];
}

final class ForgotPasswordInitial extends ForgotPasswordState {
  ForgotPasswordInitial({
    super.email,
    super.isBusy,
    required super.errorState,
    super.errorEmailMessage,
  });
}
