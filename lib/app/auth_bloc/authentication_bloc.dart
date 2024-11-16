import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/app/repository/auth_repository.dart';
import 'package:hostelway/models/auth_model.dart';
import 'package:hostelway/models/user_model.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required AuthorizationRepository authRepository})
      : _authRepository = authRepository,
        super(const AuthenticationInitial(authModel: null, userModel: null)) {
    on<AuthenticationInitialEvent>(_getUserInformation);

    on<AuthenticationSaveUserInformationEvent>(_saveUserInformation);

    on<AuthenticationLogoutEvent>(_logout);
  }

  final AuthorizationRepository _authRepository;

  void _getUserInformation(AuthenticationInitialEvent event,
      Emitter<AuthenticationState> emit) async {
    UserModel? user = await _authRepository.getUser();

    // TODO: Replace with Firebase Auth user's object
    if (user != null && ('Supabase.instance.client.auth.currentUser' != null)) {
      emit(AuthenticationIsAuthenticated(
          authModel: AuthModel(role: user.role), userModel: user));
    } else {
      emit(AuthenticationIsUnthenticated(
          authModel: null, userModel: state.userModel));
    }
  }

  void _saveUserInformation(AuthenticationSaveUserInformationEvent event,
      Emitter<AuthenticationState> emit) {
    emit(state.copyWith(userModel: event.userModel));
    event.voidCallback();
  }

  void _logout(AuthenticationLogoutEvent event,
      Emitter<AuthenticationState> emit) async {
    // TODO: Replace with Firebase Auth sign out method
    // await Supabase.instance.client.auth.signOut();
    add(AuthenticationInitialEvent());
  }
}
