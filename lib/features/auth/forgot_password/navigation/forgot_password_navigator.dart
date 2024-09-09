import 'package:hostelway/features/auth/otp_verifyer/navigation/otp_verifyer_route.dart';
import 'package:hostelway/utils/role_navigator.dart';

class ForgotPasswordNavigator extends RoleNavigator {
  ForgotPasswordNavigator(super.context);

  void goCheckOtp() {
    navigator.push(OtpVerifyerRoute());
  }
}
