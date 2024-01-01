part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  final String email, password, confirmPassword, firstName, lastName;

  final bool isPasswordInvisible, isConfirmPasswordInvisible;

  final List<String> roles = const ['Manager', 'Guest'];

  final int initialLabelIndex;

  const SignUpState(
      {this.email = '',
      this.password = '',
      this.confirmPassword = '',
      this.firstName = '',
      this.lastName = '',
      this.isPasswordInvisible = true,
      this.isConfirmPasswordInvisible = true,
      this.initialLabelIndex = 0});

  SignUpState copyWith(
      {String? email,
      String? password,
      String? confirmPassword,
      String? firstName,
      String? lastName,
      bool? isPasswordInvisible,
      bool? isConfirmPasswordInvisible,
      int? initialLabelIndex}) {
    return SignUpInitial(
        email: email ?? this.email,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        password: password ?? this.password,
        confirmPassword: confirmPassword ?? this.confirmPassword,
        isPasswordInvisible: isPasswordInvisible ?? this.isPasswordInvisible,
        isConfirmPasswordInvisible:
            isConfirmPasswordInvisible ?? this.isConfirmPasswordInvisible,
        initialLabelIndex: initialLabelIndex ?? this.initialLabelIndex);
  }

  @override
  List<Object> get props => [
        email,
        password,
        confirmPassword,
        isPasswordInvisible,
        isConfirmPasswordInvisible,
        initialLabelIndex,
        firstName,
        lastName
      ];
}

final class SignUpInitial extends SignUpState {
  const SignUpInitial(
      {super.email,
      super.password,
      super.confirmPassword,
      super.isPasswordInvisible,
      super.isConfirmPasswordInvisible,
      super.firstName,
      super.lastName,
      super.initialLabelIndex});
}
