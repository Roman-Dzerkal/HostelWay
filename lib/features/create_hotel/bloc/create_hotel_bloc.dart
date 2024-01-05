import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/features/create_hotel/navigation/create_hotel_navigator.dart';
import 'package:image_picker/image_picker.dart';

part 'create_hotel_event.dart';
part 'create_hotel_state.dart';

class CreateHotelBloc extends Bloc<CreateHotelEvent, CreateHotelState> {
  final CreateHotelNavigator navigator;
  CreateHotelBloc({required this.navigator}) : super(CreateHotelInitial()) {
    on<CreateHotelEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnTapAddPhotoEvent>((event, emit) async {
      ImagePicker imagePicker = ImagePicker();
      List<XFile> pickMultiImage = await imagePicker.pickMultipleMedia();
      emit(state.copyWith(photos: pickMultiImage.map((e) => File(e.path)).toList()));
    });
  }
}
