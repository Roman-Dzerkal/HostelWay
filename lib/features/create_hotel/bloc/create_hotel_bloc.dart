import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hostelway/features/create_hotel/models/create_hotel_error_state.dart';
import 'package:hostelway/features/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:hostelway/repositories/hotels_repository.dart';
import 'package:hostelway/services/tost_servive.dart';
import 'package:hostelway/services/validation_service.dart';
import 'package:image_picker/image_picker.dart';

part 'create_hotel_event.dart';
part 'create_hotel_state.dart';

class CreateHotelBloc extends Bloc<CreateHotelEvent, CreateHotelState> {
  final CreateHotelNavigator navigator;
  final HotelsRepository hotelsRepository;
  CreateHotelBloc({required this.navigator, required this.hotelsRepository})
      : super(CreateHotelInitial(
          errorState: CreateHotelErrorState(),
        )) {
    on<CreateHotelEvent>((event, emit) {});
    on<CreateHotelButtonTapEvent>((event, emit) => _createHotel(event, emit));
    on<UploadPhotoButtonTapEvent>((event, emit) => _uploadPhoto(event, emit));
    on<RemoveImageEvent>((event, emit) => _removeImage(event, emit));
    on<UploadOnePhotoButtonTapEvent>(
        (event, emit) => _uploadOnePhoto(event, emit));
    on<DescriptionChangedEvent>(
        (event, emit) => _descriptionChanged(event, emit));
    on<NameChangedEvent>((event, emit) => _nameChanged(event, emit));

    // on<LocationChangedEvent>((event, emit) {
    // emit(state.copyWith(hotelLocation: event.location));
    // });
  }

  Future<void> _createHotel(
      CreateHotelButtonTapEvent event, Emitter<CreateHotelState> emit) async {
    if (validForm(emit) == false) {
      return;
    }
    emit(state.copyWith(isBusy: true));

    if (state.localPhotos.isEmpty) {
      emit(state.copyWith(isBusy: false));
      TostService.showTost('Please upload at least one photo');
      return;
    }

    if (state.localPhotos.isNotEmpty) {
      for (XFile element in state.localPhotos) {
        // TODO: Replace with user's avatar
      }
    }
    emit(state.copyWith(isBusy: false));
    navigator.goToHotelList();
  }

  Future<void> _uploadPhoto(
      UploadPhotoButtonTapEvent event, Emitter<CreateHotelState> emit) async {
    ImagePicker picker = ImagePicker();
    List<XFile> response = await picker.pickMultiImage();
    emit(state.copyWith(localPhotos: response));
  }

  void _removeImage(RemoveImageEvent event, Emitter<CreateHotelState> emit) {
    List<XFile> newLocalPhotos = state.localPhotos;
    newLocalPhotos.removeAt(event.index);
    emit(state.copyWith(localPhotos: newLocalPhotos));
  }

  Future<void> _uploadOnePhoto(UploadOnePhotoButtonTapEvent event,
      Emitter<CreateHotelState> emit) async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      debugPrint('file is null');
      return;
    }
    emit(state.copyWith(isBusy: true));
    List<XFile> currentLocalPhotos = state.localPhotos;
    currentLocalPhotos.add(file);
    emit(state.copyWith(localPhotos: currentLocalPhotos, isBusy: false));

    debugPrint('${currentLocalPhotos.length}+${currentLocalPhotos.first.name}');
  }

  void _descriptionChanged(
      DescriptionChangedEvent event, Emitter<CreateHotelState> emit) {
    emit(state.copyWith(isBusy: true));
    emit(state.copyWith(description: event.description, isBusy: false));
  }

  bool validForm(Emitter<CreateHotelState> emit) {
    var validateDescription =
        ValidationService.validateDescription(state.description, null);
    var validateHotelName = ValidationService.validateFirstName(state.name);
    var validateLocation = ValidationService.validateLocation(
        /* state.hotelLocation!.formattedAddress ?? '' */ '');

    emit(state.copyWith(
      errorDescriptionMessage: validateDescription,
      errorNameMessage: validateHotelName,
      errorState: state.errorState.copyWith(
        isDescriptionError: validateDescription != null,
        isNameError: validateHotelName != null,
        isLocationError: validateLocation != null,
      ),
    ));

    return !(validateDescription != null) &&
        !(validateHotelName != null) &&
        !(validateLocation != null);
  }

  _nameChanged(NameChangedEvent event, Emitter<CreateHotelState> emit) {
    emit(state.copyWith(name: event.name));
  }
}
