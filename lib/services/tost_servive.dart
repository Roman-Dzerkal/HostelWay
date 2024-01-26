import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostelway/resources/custom_colors.dart';

class TostService {
  static void showTost(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: CustomColors.grey,
      textColor: CustomColors.white,
      fontSize: 16.0,
    );
  }
}
