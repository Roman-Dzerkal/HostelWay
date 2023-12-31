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
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle whiteText(
    double fontSize,
    FontWeight fontWeight,
    bool? underline,
  ) {
    return TextStyle(
      color: CustomColors.white,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle primaryText(
    double fontSize,
    FontWeight fontWeight,
    bool? underline,
  ) {
    return TextStyle(
      color: CustomColors.primary,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle secondaryText(
    double fontSize,
    FontWeight fontWeight,
    bool? underline,
  ) {
    return TextStyle(
      color: CustomColors.secondary,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle redText(
    double fontSize,
    FontWeight fontWeight,
    bool? underline,
  ) {
    return TextStyle(
      color: CustomColors.red,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }

  static TextStyle greyText(
    double fontSize,
    FontWeight fontWeight,
    bool? underline,
  ) {
    return TextStyle(
      color: CustomColors.grey,
      fontSize: fontSize.sp,
      fontWeight: fontWeight,
      fontFamily: 'Inter',
      decoration:
          (underline ?? false) ? TextDecoration.underline : TextDecoration.none,
    );
  }
}
