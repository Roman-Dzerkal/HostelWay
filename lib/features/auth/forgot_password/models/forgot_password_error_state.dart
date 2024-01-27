class ForgotPasswordErrorState {
  bool isEmailError;
 
  ForgotPasswordErrorState({
    this.isEmailError = false,
   
  });

  ForgotPasswordErrorState copyWith({
    bool? isEmailError,
   
  }) {
    return ForgotPasswordErrorState(
      isEmailError: isEmailError ?? this.isEmailError,
      
    );
  }
}
