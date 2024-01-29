import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/features/auth/sign_in/models/sign_in_error_state.dart';
import 'package:hostelway/features/auth/sign_in/navigation/sign_in_navigator.dart';
import 'package:hostelway/models/user_model.dart';
import 'package:hostelway/services/validation_service.dart';
import 'package:hostelway/utils/tost_util.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      emit(state.copyWith(isBusy: true));

      try {
        AuthResponse response =
            await Supabase.instance.client.auth.signInWithPassword(
          email: state.email,
          password: state.password,
        );

        Map<String, dynamic> user = await Supabase.instance.client
            .from('users')
            .select()
            .eq('user_id', response.user!.id)
            .single();

        if (user.isEmpty) {
          emit(state.copyWith(isBusy: false));
          ToastUtil.showError('User not found');
          return;
        }

        emit(state.copyWith(isBusy: false));
        UserModel userModel = UserModel.fromJson(user);
        authenticationBloc.add(AuthenticationSaveUserInformationEvent(
            userModel: userModel, voidCallback: navigator.goToHomePage));
      } catch (e) {
        emit(state.copyWith(isBusy: false));
        if (e is AuthException) {
          ToastUtil.showError(e.message);
        } else if (e is PostgrestException) {
          ToastUtil.showError(e.message);
        } else {
          ToastUtil.showError(e.toString());
        }
      }
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
