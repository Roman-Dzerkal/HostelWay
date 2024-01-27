import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelway/features/auth/forgot_password/models/forgot_password_error_state.dart';
import 'package:hostelway/features/auth/forgot_password/navigation/forgot_password_navigator.dart';
import 'package:hostelway/services/validation_service.dart';
import 'package:hostelway/utils/tost_util.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordNavigator navigator;

  ForgotPasswordBloc(this.navigator)
      : super(ForgotPasswordInitial(errorState: ForgotPasswordErrorState())) {
    on<ForgotPasswordEvent>((event, emit) {});

    on<ForgotPasswordEmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordResetButtonTapEvent>((event, emit) async {
      // TODO: implement fields validation
      if (validForm(emit) == false) {
        return;
      }
      emit(state.copyWith(isBusy: true));

      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: state.email);
        emit(state.copyWith(isBusy: false));
        ToastUtil.showError(
            'Password reset link has been sent to your email address');
        navigator.goBack();
      } catch (e) {
        emit(state.copyWith(isBusy: false));
        if (e is FirebaseAuthException) {
          ToastUtil.showError(e.message!);
        } else if (e is FirebaseException) {
          ToastUtil.showError(e.message!);
        } else {
          ToastUtil.showError(e.toString());
        }
      }
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
  }

  bool validForm(Emitter<ForgotPasswordState> emit) {
    var validateEmail = ValidationService.validateEmail(state.email);

    emit(state.copyWith(
      errorEmailMessage: validateEmail,
    ));

    return !(validateEmail != null);
  }
}
