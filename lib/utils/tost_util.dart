import 'package:fluttertoast/fluttertoast.dart';
import 'package:hostelway/utils/custom_colors.dart';

class ToastUtil {
  ToastUtil();

  static void showError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: CustomColors.red,
        textColor: CustomColors.white,
        fontSize: 16.0);
  }
}
