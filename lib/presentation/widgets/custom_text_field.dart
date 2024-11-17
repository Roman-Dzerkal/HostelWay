// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/utils/custom_colors.dart';
import 'package:hostelway/utils/text_styling.dart';

class CustomTextField extends StatelessWidget {
  final String? helperText;
  final bool isPassword, isObscure, readOnly, isSuffix, isNumber;
  final void Function()? onEyeTap, onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  final void Function(String)? onChanged;
  final Color? outlineInputBorderColor;
  final TextStyle? hintTextStyle, helperTextStyle;
  final String? value, suffixText;
  final TextInputType? keyboardType;
  final int? maxLines;
  final double height;
  final double? width, borderRad;
  final void Function(String)? onSubmitted;
  final Widget? suffix;
  final Iterable<String> autofillHints;
  final int? lengthLimitingText;
  final String? errorText;

  const CustomTextField({
    super.key,
    this.errorText,
    this.autofillHints = const [],
    this.keyboardType,
    this.helperText,
    this.isPassword = false,
    this.isObscure = false,
    this.onEyeTap,
    this.validator,
    this.controller,
    this.hintText,
    this.helperTextStyle,
    this.onChanged,
    this.readOnly = false,
    this.onTap,
    this.outlineInputBorderColor,
    this.hintTextStyle,
    this.value,
    this.isSuffix = false,
    this.suffixText,
    this.isNumber = false,
    this.maxLines,
    required this.height,
    this.width,
    this.borderRad,
    this.suffix,
    this.onSubmitted,
    this.lengthLimitingText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (helperText != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 5.h),
                child: Text(helperText!,
                    style: helperTextStyle ??
                        TextStyling.greyText(14, FontWeight.normal)),
              ),
            ],
          ),
        SizedBox(
          width: width,
          height: height,
          child: TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(lengthLimitingText),
            ],
            autofillHints: autofillHints,
            onFieldSubmitted: onSubmitted,
            maxLines: maxLines,
            onTap: onTap,
            readOnly: readOnly,
            obscuringCharacter: '*',
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            initialValue: value,
            keyboardType: keyboardType,
            obscureText: isObscure,
            style: TextStyling.blackText(16, FontWeight.w400),
            decoration: InputDecoration(
              errorText: errorText,
              contentPadding: EdgeInsets.only(left: 22.w, top: 16.h),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.all(Radius.circular(borderRad ?? 50.r)),
                borderSide: const BorderSide(
                  width: 1,
                  color: CustomColors.grey,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  strokeAlign: 0,
                  width: 1,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  strokeAlign: 0,
                  width: 1,
                  color: Colors.red,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              suffixIcon: suffix ??
                  (isPassword
                      ? IconButton(
                          onPressed: onEyeTap,
                          icon: Icon(
                            isObscure
                                ? Icons.visibility_off_outlined
                                : Icons.remove_red_eye_outlined,
                            color: CustomColors.black.withOpacity(.46),
                            size: 25.r,
                          ),
                        )
                      : null),
              suffix: isSuffix
                  ? Text(suffixText ?? '',
                      style: TextStyling.blackText(16, FontWeight.w500))
                  : null,
              filled: true,
              fillColor: CustomColors.white,
              hintText: hintText ?? (isPassword ? '***************' : hintText),
              hintStyle:
                  hintTextStyle ?? TextStyling.blackText(16, FontWeight.w400),
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 1,
                  color: CustomColors.grey,
                ),
                borderRadius: BorderRadius.circular(borderRad ?? 50.r),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
