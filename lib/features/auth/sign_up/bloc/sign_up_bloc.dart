import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelway/features/auth/sign_up/navigation/sign_in_navigator.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpNavigator navigator;

  SignUpBloc({required this.navigator}) : super(const SignUpInitial()) {
    on<SignUpEvent>((event, emit) {});

    on<SignUpEmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<SignUpPasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<SignUpConfirmPasswordChangedEvent>((event, emit) {
      emit(state.copyWith(confirmPassword: event.confirmPassword));
    });

    on<SignUpButtonPressedEvent>((event, emit) async {
      try {
        var credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: state.email, password: state.password);

        if (credential.user != null) {
          await FirebaseAuth.instance.currentUser!.sendEmailVerification();
        }
      } catch (e) {
        return;
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .set({
        'id': FirebaseAuth.instance.currentUser?.uid,
        'firstName': state.firstName,
        'lastName': state.lastName,
        'role': state.roles[state.initialLabelIndex].toLowerCase(),
      });

      navigator.returnToSignIn();
    });

    on<PasswordVisibilityChangedEvent>((event, emit) {
      emit(state.copyWith(isPasswordInvisible: !state.isPasswordInvisible));
    });

    on<ConfirmPasswordVisibilityChangedEvent>((event, emit) {
      emit(state.copyWith(
          isConfirmPasswordInvisible: !state.isConfirmPasswordInvisible));
    });

    on<SignUpRoleChangedEvent>((event, emit) {
      emit(state.copyWith(initialLabelIndex: event.index));
    });

    on<SignUpFirstNameChangedEvent>((event, emit) {
      emit(state.copyWith(firstName: event.firstName));
    });

    on<SignUpLastNameChangedEvent>((event, emit) {
      emit(state.copyWith(lastName: event.lastName));
    });
  }
}
