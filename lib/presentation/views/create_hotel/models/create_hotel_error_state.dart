class CreateHotelErrorState {
  bool isNameError;
  bool isDescriptionError;
  bool isLocationError;

  CreateHotelErrorState({
    this.isNameError = false,
    this.isDescriptionError = false,
    this.isLocationError = false,
  });

  CreateHotelErrorState copyWith({
    bool? isNameError,
    bool? isDescriptionError,
    bool? isLocationError,
  }) {
    return CreateHotelErrorState(
      isNameError: isNameError ?? this.isNameError,
      isDescriptionError: isDescriptionError ?? this.isDescriptionError,
      isLocationError: isLocationError ?? this.isLocationError,
    );
  }
}
