import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/domain/models/user_model.dart';
import 'package:hostelway/presentation/views/auth/sign_in/models/sign_in_error_state.dart';
import 'package:hostelway/presentation/views/auth/sign_in/navigation/sign_in_navigator.dart';
import 'package:hostelway/data/data_sources/validation_service.dart';
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
      String errorMessage = '';
      UserCredential user;
      if (validForm(emit) == false) {
        return;
      }
      emit(state.copyWith(isBusy: true));
      try {
        user = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: state.email,
          password: state.password,
        );
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'user-not-found':
            errorMessage = 'User with this email not found.';
            break;
          case 'wrong-password':
            errorMessage = 'Wrong password';
            break;
          case 'invalid-credential':
            errorMessage =
                'Invalid credentials. Please check your input or try again.';
            break;
          default:
            errorMessage = 'System error: ${e.code} - ${e.message}';
            break;
        }
        if (errorMessage.isNotEmpty) {
          ToastUtil.showError(errorMessage);
        }
        return;
      }
      try {
        final doc = await FirebaseFirestore.instance
            .collection('User')
            .doc(user.user!.uid)
            .get();

        UserModel userModel = UserModel.fromJson(doc.data()!);
        emit(state.copyWith(isBusy: false));
        authenticationBloc.add(AuthenticationSaveUserInformationEvent(
            userModel: userModel, voidCallback: navigator.goToHomePage));
        //ToastUtil.showError( '${doc.data()?['first_name']}');
      } on Exception catch (e) {
        //print("Error getting document: $e");
        ToastUtil.showError("$e");
      }
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
