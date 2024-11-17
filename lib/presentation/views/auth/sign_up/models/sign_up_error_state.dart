class SignUpErrorState {
  bool isEmailError;
  bool isPasswordError;
  bool isConfirmPasswordError;
  bool isFirstNameError;
  bool isLastNameError;

  SignUpErrorState({
    this.isEmailError = false,
    this.isPasswordError = false,
    this.isConfirmPasswordError = false,
    this.isFirstNameError = false,
    this.isLastNameError = false,
  });

  SignUpErrorState copyWith({
    bool? isEmailError,
    bool? isPasswordError,
    bool? isConfirmPasswordError,
    bool? isFirstNameError,
    bool? isLastNameError,
  }) {
    return SignUpErrorState(
      isEmailError: isEmailError ?? this.isEmailError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
      isConfirmPasswordError:
          isConfirmPasswordError ?? this.isConfirmPasswordError,
      isFirstNameError: isFirstNameError ?? this.isFirstNameError,
      isLastNameError: isLastNameError ?? this.isLastNameError,
    );
  }
}
