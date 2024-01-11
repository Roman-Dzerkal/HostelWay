import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/features/auth/sign_in/models/sign_in_error_state.dart';
import 'package:hostelway/features/auth/sign_in/navigation/sign_in_navigator.dart';
import 'package:hostelway/models/user_model.dart';
import 'package:hostelway/services/validation_service.dart';
import 'package:hostelway/utils/tost_util.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final SignInNavigator navigator;
  final AuthenticationBloc authenticationBloc;

  SignInBloc({
    required this.navigator,
    required this.authenticationBloc,
  }) : super(SignInInitial(errorState: SignInErrorState())) {
    on<SignInEvent>((event, emit) {});

    on<SignInEmailChanged>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignInPasswordChanged>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignInSubmitted>((event, emit) async {
      if (validForm(emit) == false) {
        return;
      }
      try {
        emit(state.copyWith(isBusy: true));

        try {
          var userCredentials = await FirebaseAuth.instance
              .signInWithEmailAndPassword(
                  email: state.email, password: state.password);

          if (!(userCredentials.user?.emailVerified ?? false)) {
            debugPrint('Please verify your email.');
            return;
          }

          var doc = await FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get();
          emit(state.copyWith(isBusy: false));
          UserModel userModel = UserModel.fromJson(doc.data()!);
          authenticationBloc.add(AuthenticationSaveUserInformationEvent(
              userModel: userModel, voidCallback: navigator.goToHomePage));
        } catch (e) {
          emit(state.copyWith(isBusy: false));
          ToastUtil.showError(e.toString());
        }
      } catch (e) {}
    });

    on<SignInWithGooglePressed>((event, emit) {});

    on<SignInWithFacebookPressed>((event, emit) {});

    on<SignUpTextTapEvent>((event, emit) {
      navigator.goToSignUpPage();
    });

    on<SignInPasswordVisibleChanged>((event, emit) {
      emit(state.copyWith(isPasswordInvisible: !state.isPasswordInvisible));
    });

    on<EmailFormSubmittedEvent>((event, emit) {
      if (ValidationService.validateEmail(event.email) != null) {
        emit(state.copyWith(
            errorState: state.errorState.copyWith(isEmailError: true),
            errorEmailMessage: ValidationService.validateEmail(event.email)));
      } else {
        emit(state.copyWith(
          errorState: state.errorState.copyWith(isEmailError: false),
        ));
      }
    });

    on<PasswordFormSubmittedEvent>((event, emit) {
      if (ValidationService.validatePassword(event.password, null) != null) {
        emit(state.copyWith(
            errorState: state.errorState.copyWith(isPasswordError: true),
            errorPasswordMessage:
                ValidationService.validatePassword(event.password, null)));
      } else {
        emit(state.copyWith(
          errorState: state.errorState.copyWith(isPasswordError: false),
        ));
      }
    });
  }

  bool validForm(Emitter<SignInState> emit) {
    var validateEmail = ValidationService.validateEmail(state.email);
    var validatePassword =
        ValidationService.validatePassword(state.password, null);

    emit(state.copyWith(
      errorEmailMessage: validateEmail,
      errorPasswordMessage: validatePassword,
      errorState: state.errorState.copyWith(
        isEmailError: validateEmail != null,
        isPasswordError: validatePassword != null,
      ),
    ));

    return !(validateEmail != null) && !(validatePassword != null);
  }
}
