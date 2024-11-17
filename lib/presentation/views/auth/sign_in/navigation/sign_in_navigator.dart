import 'package:hostelway/presentation/views/auth/forgot_password/navigation/forgot_password_route.dart';
import 'package:hostelway/presentation/views/auth/sign_up/navigation/sign_in_route.dart';
import 'package:hostelway/utils/role_navigator.dart';
import 'package:hostelway/presentation/views/home/navigation/home_guest_route.dart';
import 'package:hostelway/presentation/views/home/navigation/home_manager_route.dart';

class SignInNavigator extends RoleNavigator {
  SignInNavigator(super.context);

  void goToSignUpPage() {
    navigator.push(SignUpRoute());
  }

  void goToHomePage() {
    if (isGuest()) {
      navigator.pushAndRemoveUntil(HomeGuestRoute(), (route) => false);
    } else {
      navigator.pushAndRemoveUntil(HomeManagerRoute(), (route) => false);
    }
  }

  void goToForgotPasswordPage() {
    navigator.push(ForgotPasswordRoute());
  }
}
