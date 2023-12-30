import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/resources/custom_colors.dart';

class TextStyling {
  static TextStyle blackText(
    double fontSize,
    FontWeight fontWeight, {
    bool? underline,
  }) {
    return TextStyle(
      color: CustomColors.black,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      locale: const Locale('ru', 'Ru'),
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle whiteText(
    double fontSize,
    FontWeight fontWeight,
  ) {
    return TextStyle(
      color: CustomColors.white,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      locale: const Locale('ru', 'Ru'),
    );
  }
}
