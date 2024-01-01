import 'package:hostelway/features/auth/sign_in/navigation/sign_in_route.dart';
import 'package:hostelway/utils/role_navigator.dart';


class WelcomeNavigator extends RoleNavigator {
  WelcomeNavigator(super.context);
  void goToSignInPage(){
    navigator.push(SignInRoute());
  }
}


 