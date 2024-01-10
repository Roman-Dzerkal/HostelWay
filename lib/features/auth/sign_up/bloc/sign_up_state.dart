part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  final String email, password, confirmPassword, firstName, lastName;

  final bool isPasswordInvisible, isConfirmPasswordInvisible;

  final List<String> roles = const ['Manager', 'Guest'];

  final int initialLabelIndex;
  final String? errorEmailMessage;
  final String? errorPasswordMessage;
  final SignUpErrorState errorState;
  final String? errorFirstNameMessage;
  final String? errorLastNameMessage;
  final String? errorConfirmPasswordMessage;

  const SignUpState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.firstName = '',
    this.lastName = '',
    this.isPasswordInvisible = true,
    this.isConfirmPasswordInvisible = true,
    this.initialLabelIndex = 1,
    this.errorEmailMessage,
    this.errorPasswordMessage,
    required this.errorState,
    this.errorFirstNameMessage,
    this.errorLastNameMessage,
    this.errorConfirmPasswordMessage,
  });

  SignUpState copyWith(
      {String? email,
      String? password,
      String? confirmPassword,
      String? firstName,
      String? lastName,
      bool? isPasswordInvisible,
      bool? isConfirmPasswordInvisible,
      int? initialLabelIndex,
      SignUpErrorState? errorState,
      String? errorEmailMessage,
      String? errorPasswordMessage,
      String? errorFirstNameMessage,
      String? errorLastNameMessage,
      String? errorConfirmPasswordMessage}) {
    return SignUpInitial(
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isPasswordInvisible: isPasswordInvisible ?? this.isPasswordInvisible,
      isConfirmPasswordInvisible:
          isConfirmPasswordInvisible ?? this.isConfirmPasswordInvisible,
      initialLabelIndex: initialLabelIndex ?? this.initialLabelIndex,
      errorEmailMessage: errorEmailMessage ?? this.errorEmailMessage,
      errorPasswordMessage: errorPasswordMessage ?? this.errorPasswordMessage,
      errorState: errorState ?? this.errorState,
      errorFirstNameMessage:
          errorFirstNameMessage ?? this.errorFirstNameMessage,
      errorLastNameMessage: errorLastNameMessage ?? this.errorLastNameMessage,
      errorConfirmPasswordMessage:
          errorConfirmPasswordMessage ?? this.errorConfirmPasswordMessage,
    );
  }

  @override
  List<Object?> get props => [
        email,
        password,
        confirmPassword,
        isPasswordInvisible,
        isConfirmPasswordInvisible,
        initialLabelIndex,
        firstName,
        lastName,
        errorState,
        errorEmailMessage,
        errorPasswordMessage,
        errorFirstNameMessage,
        errorLastNameMessage,
        errorConfirmPasswordMessage,
      ];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial({
    super.email,
    super.password,
    super.confirmPassword,
    super.isPasswordInvisible,
    super.isConfirmPasswordInvisible,
    super.firstName,
    super.lastName,
    super.initialLabelIndex,
    required super.errorState,
    super.errorEmailMessage,
    super.errorPasswordMessage,
    super.errorFirstNameMessage,
    super.errorLastNameMessage,
    super.errorConfirmPasswordMessage,
  });
}
