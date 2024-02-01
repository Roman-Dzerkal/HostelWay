import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hostelway/features/auth/sign_up/models/sign_up_error_state.dart';
import 'package:hostelway/features/auth/sign_up/navigation/sign_in_navigator.dart';
import 'package:hostelway/services/validation_service.dart';
import 'package:hostelway/utils/tost_util.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpNavigator navigator;

  SignUpBloc({required this.navigator})
      : super(SignUpInitial(errorState: SignUpErrorState())) {
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

    on<AvatarUploadButtonPressedEvent>((event, emit) async {
      emit(state.copyWith(isBusy: true));
      ImagePicker picker = ImagePicker();
      XFile? file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        emit(state.copyWith(avatar: file, isBusy: false));
      }
    });

    on<SignUpButtonPressedEvent>((event, emit) async {
      if (validForm(emit) == false) {
        return;
      } else if (state.password != state.confirmPassword) {
        emit(state.copyWith(
          errorState: state.errorState.copyWith(
            isConfirmPasswordError: true,
          ),
          errorConfirmPasswordMessage: 'Password does not match',
        ));
        return;
      }

      emit(state.copyWith(isBusy: true));

      try {
        AuthResponse response = await Supabase.instance.client.auth
            .signUp(email: state.email, password: state.password, data: {
          'display_name': '${state.firstName} ${state.lastName}',
          'role': state.roles[state.initialLabelIndex].toLowerCase(),
        });

        /* if (state.avatar != null) {
            FirebaseStorage.instance
                .ref('avatars/${FirebaseAuth.instance.currentUser!.uid}')
                .putFile(File(state.avatar!.path))
                .then((p0) {
              debugPrint(p0.state.toString());
            });
          } */

        await Supabase.instance.client.from('users').insert({
          'user_id': response.user!.id,
          'first_name': state.firstName,
          'last_name': state.lastName,
          'role': state.roles[state.initialLabelIndex].toLowerCase(),
          'favorites': <int>[],
        });
        emit(state.copyWith(isBusy: false));
        ToastUtil.showError('User created successfully');
        navigator.returnToSignIn();
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

    on<ConfirmPasswordFormSubmittedEvent>((event, emit) {
      if (ValidationService.validatePassword(event.confirmPassword, null) !=
          null) {
        emit(state.copyWith(
            errorState: state.errorState.copyWith(isConfirmPasswordError: true),
            errorConfirmPasswordMessage: ValidationService.validatePassword(
                event.confirmPassword, null)));
      } else {
        emit(state.copyWith(
          errorState: state.errorState.copyWith(isConfirmPasswordError: false),
        ));
      }
    });
    on<FirstNameFormSubmittedEvent>((event, emit) {
      if (ValidationService.validatePassword(event.firstName, null) != null) {
        emit(state.copyWith(
            errorState: state.errorState.copyWith(isFirstNameError: true),
            errorFirstNameMessage:
                ValidationService.validatePassword(event.firstName, null)));
      } else {
        emit(state.copyWith(
          errorState: state.errorState.copyWith(isFirstNameError: false),
        ));
      }
    });
    on<LastNameFormSubmittedEvent>((event, emit) {
      if (ValidationService.validatePassword(event.lastName, null) != null) {
        emit(state.copyWith(
            errorState: state.errorState.copyWith(isLastNameError: true),
            errorLastNameMessage:
                ValidationService.validatePassword(event.lastName, null)));
      } else {
        emit(state.copyWith(
          errorState: state.errorState.copyWith(isLastNameError: false),
        ));
      }
    });
  }
  bool validForm(Emitter<SignUpState> emit) {
    var validateEmail = ValidationService.validateEmail(state.email);
    var validatePassword =
        ValidationService.validatePassword(state.password, null);
    var validateFirstName =
        ValidationService.validateFirstName(state.firstName);
    var validateLastName = ValidationService.validateLastName(state.lastName);
    var validateConfirmPassword =
        ValidationService.validatePassword(state.confirmPassword, null);

    emit(state.copyWith(
      errorEmailMessage: validateEmail,
      errorPasswordMessage: validatePassword,
      errorConfirmPasswordMessage: validateConfirmPassword,
      errorFirstNameMessage: validateFirstName,
      errorLastNameMessage: validateLastName,
      errorState: state.errorState.copyWith(
        isEmailError: validateEmail != null,
        isPasswordError: validatePassword != null,
        isConfirmPasswordError: validateConfirmPassword != null,
        isFirstNameError: validateFirstName != null,
        isLastNameError: validateLastName != null,
      ),
    ));

    return !(validateEmail != null) &&
        !(validatePassword != null) &&
        !(validateConfirmPassword != null) &&
        !(validateFirstName != null) &&
        !(validateLastName != null);
  }
}
