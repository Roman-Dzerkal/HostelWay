import 'package:hostelway/features/auth/sign_in/navigation/sign_in_route.dart';
import 'package:hostelway/utils/role_navigator.dart';

class ProfileNavigator extends RoleNavigator {
  ProfileNavigator(super.context);

  void goToLogin() {
    navigator.pushAndRemoveUntil(SignInRoute(), (route) => false);
  }
}
