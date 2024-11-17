class CreateRoomErrorState {
  bool isNameError;
  bool isDescriptionError;
  bool isLocationError;

  CreateRoomErrorState({
    this.isNameError = false,
    this.isDescriptionError = false,
    this.isLocationError = false,
  });

  CreateRoomErrorState copyWith({
    bool? isNameError,
    bool? isDescriptionError,
    bool? isLocationError,
  }) {
    return CreateRoomErrorState(
      isNameError: isNameError ?? this.isNameError,
      isDescriptionError: isDescriptionError ?? this.isDescriptionError,
      isLocationError: isLocationError ?? this.isLocationError,
    );
  }
}
