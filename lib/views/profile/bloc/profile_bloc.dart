import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/views/profile/navigation/profile_navigator.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileNavigator navigator;
  final AuthorizationRepository authRepository;

  ProfileBloc({required this.navigator, required this.authRepository})
      : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});

    on<ProfileLogoutEvent>((event, emit) {
      navigator.goToLogin();
    });
  }
}
