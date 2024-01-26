class CreateHotelErrorState {
  bool isNameError;
  bool isDescriptionError;

  CreateHotelErrorState({
    this.isNameError = false,
    this.isDescriptionError = false,
  });

  CreateHotelErrorState copyWith({
    bool? isNameError,
    bool? isDescriptionError,
  }) {
    return CreateHotelErrorState(
      isNameError: isNameError ?? this.isNameError,
      isDescriptionError: isDescriptionError ?? this.isDescriptionError,
    );
  }
}
