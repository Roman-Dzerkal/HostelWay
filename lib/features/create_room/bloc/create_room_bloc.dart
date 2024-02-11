import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/features/create_room/models/create_room_error_state.dart';
import 'package:hostelway/features/create_room/navigation/create_room_navigator.dart';
import 'package:hostelway/repositories/rooms_repository.dart';
import 'package:hostelway/services/tost_servive.dart';
import 'package:hostelway/services/validation_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  final CreateRoomNavigator navigator;
  final RoomsRepository roomsRepository;
  final String hotelId;
  CreateRoomBloc({required this.navigator, required this.roomsRepository, required this.hotelId})
      : super(CreateRoomInitial(errorState: CreateRoomErrorState())) {
    on<CreateRoomEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CreateRoomButtonTapEvent>((event, emit) => _createRoom(event, emit));
    on<UploadPhotoButtonTapEvent>((event, emit) => _uploadPhoto(event, emit));
    on<RemoveImageEvent>((event, emit) => _removeImage(event, emit));
    on<UploadOnePhotoButtonTapEvent>(
        (event, emit) => _uploadOnePhoto(event, emit));
    on<DescriptionChangedEvent>(
        (event, emit) => _descriptionChanged(event, emit));
    on<NameChangedEvent>((event, emit) => _nameChanged(event, emit));
  }

  Future<void> _createRoom(
      CreateRoomButtonTapEvent event, Emitter<CreateRoomState> emit) async {
    if (validForm(emit) == false) {
      return;
    }
    emit(state.copyWith(isBusy: true));

    if (state.localPhotos.isEmpty) {
      emit(state.copyWith(isBusy: false));
      TostService.showTost('Please upload at least one photo');
      return;
    }

    String roomId = await roomsRepository.createRoom({
      'description': state.description,
      'hotel_id': hotelId,
      'name': state.name,
      'price': state.price,
      'booking_status': 'free'
    });

    /*if (state.localPhotos.isNotEmpty) {
      for (XFile element in state.localPhotos) {
        await Supabase.instance.client.storage
            .from('hotels')
            .upload('$hotelId/${element.name}', File(element.path));
      }
    }*/
    emit(state.copyWith(isBusy: false));
    navigator.goToHotelList();
  }

  Future<void> _uploadPhoto(
      UploadPhotoButtonTapEvent event, Emitter<CreateRoomState> emit) async {
    ImagePicker picker = ImagePicker();
    List<XFile> response = await picker.pickMultiImage();
    emit(state.copyWith(localPhotos: response));
  }

  void _removeImage(RemoveImageEvent event, Emitter<CreateRoomState> emit) {
    List<XFile> newLocalPhotos = state.localPhotos;
    newLocalPhotos.removeAt(event.index);
    emit(state.copyWith(localPhotos: newLocalPhotos));
  }

  Future<void> _uploadOnePhoto(
      UploadOnePhotoButtonTapEvent event, Emitter<CreateRoomState> emit) async {
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
      DescriptionChangedEvent event, Emitter<CreateRoomState> emit) {
    emit(state.copyWith(isBusy: true));
    emit(state.copyWith(description: event.description, isBusy: false));
  }

  bool validForm(Emitter<CreateRoomState> emit) {
    var validateDescription =
        ValidationService.validateDescription(state.description, null);
    var validateHotelName = ValidationService.validateFirstName(state.name);

    emit(state.copyWith(
      errorDescriptionMessage: validateDescription,
      errorNameMessage: validateHotelName,
      errorState: state.errorState.copyWith(
        isDescriptionError: validateDescription != null,
        isNameError: validateHotelName != null,
      ),
    ));

    return !(validateDescription != null) && !(validateHotelName != null);
  }

  _nameChanged(NameChangedEvent event, Emitter<CreateRoomState> emit) {
    emit(state.copyWith(name: event.name));
  }
}
