import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/utils/custom_colors.dart';

class CheckboxWithLabel extends StatelessWidget {
  const CheckboxWithLabel({
    super.key,
    required this.label,
    required this.value,
    this.onChanged,
  });

  final RichText label;
  final bool value;
  final void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onChanged != null) onChanged!(!value);
      },
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: SizedBox(
              width: 24.w,
              height: 24.w,
              child: Checkbox(
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: CustomColors.primary,
                value: value,
                onChanged: onChanged,
              ),
            ),
          ),
          SizedBox(
            width: 300.w,
            child: label,
          ),
        ],
      ),
    );
  }
}
