import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/features/auth/forgot_password/models/forgot_password_error_state.dart';
import 'package:hostelway/features/auth/forgot_password/navigation/forgot_password_navigator.dart';
import 'package:hostelway/services/validation_service.dart';

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

    // Implement with Firebase Auth
    on<PasswordResetButtonTapEvent>((event, emit) async {});

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
