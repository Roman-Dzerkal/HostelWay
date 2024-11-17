class SignInErrorState {
  bool isEmailError;
  bool isPasswordError;

  SignInErrorState({
    this.isEmailError = false,
    this.isPasswordError = false,
  });

  SignInErrorState copyWith({
    bool? isEmailError,
    bool? isPasswordError,
  }) {
    return SignInErrorState(
      isEmailError: isEmailError ?? this.isEmailError,
      isPasswordError: isPasswordError ?? this.isPasswordError,
    );
  }
}
