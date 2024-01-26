import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hostelway/features/auth/forgot_password/navigation/forgot_password_navigator.dart';
import 'package:hostelway/utils/tost_util.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final ForgotPasswordNavigator navigator;

  ForgotPasswordBloc(this.navigator) : super(const ForgotPasswordInitial()) {
    on<ForgotPasswordEvent>((event, emit) {});

    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordResetButtonTapEvent>((event, emit) async {
      // TODO: implement fields validation

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
  }
}
