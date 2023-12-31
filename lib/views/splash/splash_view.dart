import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/resources/assets.dart';
import 'package:hostelway/resources/custom_colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.primary,
      body: Center(
        child: Assets.icons.launchImage.svg(
          width: 250.w,
          height: 250.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
