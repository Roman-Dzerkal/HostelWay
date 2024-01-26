import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/models/user_model.dart';
import 'package:hostelway/utils/tost_util.dart';
import 'package:hostelway/views/profile/navigation/profile_navigator.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileNavigator navigator;
  final AuthorizationRepository authRepository;

  ProfileBloc({required this.navigator, required this.authRepository})
      : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<ProfileLoadEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));
      UserModel? user = await authRepository.getUser();
      emit(ProfileInitial(
        firstName: user!.firstName,
        lastName: user.lastName,
        isBusy: false,
        photoUrl: FirebaseAuth.instance.currentUser?.photoURL ?? '',
      ));
    });

    on<ProfileLogoutEvent>((event, emit) {
      navigator.goToLogin();
    });

    on<ProfileSaveEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));

      try {
        if (state.image != null) {
          Reference ref = FirebaseStorage.instance.ref().child(
              'users/${FirebaseAuth.instance.currentUser!.uid}/avatar${state.image!.path.substring(state.image!.path.lastIndexOf('.'))}');
          await ref.putFile(
              File(state.image!.path),
              SettableMetadata(
                contentType: 'image/jpeg',
              ));

          String url = await ref.getDownloadURL();

          await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
        }
      } catch (e) {
        emit(state.copyWith(isBusy: false));
        if (e is FirebaseException) {
          ToastUtil.showError(e.message!);
        } else {
          ToastUtil.showError(e.toString());
        }
      }

      emit(state.copyWith(isBusy: false));
    });

    on<ProfilePhotoChangedEvent>((event, emit) async {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(state.copyWith(image: image, photoUrl: ''));
      }
    });
  }
}
