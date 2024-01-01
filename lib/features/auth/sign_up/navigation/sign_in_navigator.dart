import 'package:hostelway/utils/role_navigator.dart';

class SignUpNavigator extends RoleNavigator {
  SignUpNavigator(super.context);

  void returnToSignIn() {
    navigator.pop();
  }
}
