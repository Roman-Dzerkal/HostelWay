import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/features/auth/sign_in/models/sign_in_error_state.dart';
import 'package:hostelway/features/auth/sign_in/navigation/sign_in_navigator.dart';
import 'package:hostelway/services/validation_service.dart';

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

    // TODO: Implement with Firebase Auth
    on<SignInSubmitted>((event, emit) async {
      final UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
    });

    on<SignInWithGooglePressed>((event, emit) async {
      /* GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(
              scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ],
              clientId:
                  '493144528853-d48v0rkd6o3nboa6imo7ie4ba1jsbq03.apps.googleusercontent.com')
          .signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        AuthResponse response = await Supabase.instance.client.auth
            .signInWithIdToken(
                provider: OAuthProvider.google,
                idToken: googleSignInAuthentication.idToken!,
                accessToken: googleSignInAuthentication.accessToken!);
        print(response.user!.toJson());
      } */
    });

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

    on<ForgotPasswordTextTapEvent>((event, emit) {
      navigator.goToForgotPasswordPage();
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
