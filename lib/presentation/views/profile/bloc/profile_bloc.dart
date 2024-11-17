import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/domain/models/user_model.dart';
import 'package:hostelway/presentation/views/profile/navigation/profile_navigator.dart';
import 'package:image_picker/image_picker.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileNavigator navigator;
  final AuthorizationRepository authRepository;

  ProfileBloc({required this.navigator, required this.authRepository})
      : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<FirstNameChangeEvent>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });
    on<LastNameChangeEvent>((event, emit) {
      emit(state.copyWith(lastName: event.lastName));
    });

    on<TestEvent>((event, emit) async {});

    on<ProfileLoadEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));
      UserModel? user = await authRepository.getUser();
      emit(ProfileInitial(
        firstName: user!.firstName,
        lastName: user.lastName,
        isBusy: false,
        photoUrl: '', // TODO: replace with user's avatar URL
        email: '', // TODO: replace with user's avatar email
      ));
    });

    on<ProfileLogoutEvent>((event, emit) {
      navigator.goToLogin();
    });

    on<ProfileSaveEvent>((event, emit) async {});

    on<ProfilePhotoChangedEvent>((event, emit) async {
      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        emit(state.copyWith(image: image, photoUrl: ''));
      }
    });
  }
}
