import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/models/user_model.dart';
import 'package:hostelway/utils/tost_util.dart';
import 'package:hostelway/views/profile/navigation/profile_navigator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileNavigator navigator;
  final AuthorizationRepository authRepository;
  GoTrueClient authClient = Supabase.instance.client.auth;
  ProfileBloc({required this.navigator, required this.authRepository})
      : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<TestEvent>((event, emit) async {
      String targetUser = 'd88bfb74-b04f-4ffb-a0aa-851db86c0e6c';
      SupabaseClient adminClient = SupabaseClient(
          const String.fromEnvironment('SUPABASE_URL'),
          const String.fromEnvironment('SUPABASE_SERVICE_ROLE_KEY'));
      await adminClient.auth.admin.updateUserById(targetUser,
          attributes: AdminUserAttributes(userMetadata: {
            'aboba_list': List<String>.from(['a', 'b', 'c', 'd'])
          }));
    });

    on<ProfileLoadEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));
      UserModel? user = await authRepository.getUser();
      emit(ProfileInitial(
        firstName: user!.firstName,
        lastName: user.lastName,
        isBusy: false,
        photoUrl: Supabase
                .instance.client.auth.currentUser?.userMetadata?['avatar'] ??
            '',
        email: Supabase.instance.client.auth.currentUser!.email ?? '',
      ));
    });

    on<ProfileLogoutEvent>((event, emit) {
      navigator.goToLogin();
    });

    on<ProfileSaveEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));

      try {
        /* if (state.image != null) {
          Reference ref = FirebaseStorage.instance.ref().child(
              'users/${FirebaseAuth.instance.currentUser!.uid}/avatar${state.image!.path.substring(state.image!.path.lastIndexOf('.'))}');
          await ref.putFile(
              File(state.image!.path),
              SettableMetadata(
                contentType: 'image/jpeg',
              ));

          String url = await ref.getDownloadURL();

          await FirebaseAuth.instance.currentUser!.updatePhotoURL(url);
        } */
      } catch (e) {
        emit(state.copyWith(isBusy: false));
        if (e is StorageException) {
          ToastUtil.showError(e.message);
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
