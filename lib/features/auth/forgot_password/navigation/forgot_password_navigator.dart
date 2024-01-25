import 'package:hostelway/utils/role_navigator.dart';

class ForgotPasswordNavigator extends RoleNavigator {
  ForgotPasswordNavigator(super.context);

  void goBack() {
    navigator.pop();
  }
}
