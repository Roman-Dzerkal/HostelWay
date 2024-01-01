import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(),
      child: const SignInLayout(),
    );
  }
}

class SignInLayout extends StatelessWidget {
  const SignInLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: CustomColors.lightGrey,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              backgroundColor: CustomColors.primary,
              title: Text('Sign In',
                  style: TextStyling.whiteText(18, FontWeight.bold)),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                    child: CustomTextField(
                      borderRad: 10.r,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      hintTextStyle: TextStyling.greyText(14, FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextField(outlineInputBorderColor: CustomColors.grey,
                      borderRad: 10.r,
                      hintText: 'Password',
                      keyboardType: TextInputType.text,
                      isObscure: true,
                      maxLines: 1,
                      isPassword: true,
                      hintTextStyle: TextStyling.greyText(14, FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: BestButton(
                      height: 60.h,
                      text: "Sign in",
                      backgroundColor: CustomColors.primary,
                      borderRadius: 100.r,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot your password?',
                          style: TextStyling.blackText(14, FontWeight.normal),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Don`t have an account? ',
                          style: TextStyling.blackText(14, FontWeight.normal)),
                      TextSpan(
                          text: 'Sign up',
                          style: TextStyling.primaryText(14, FontWeight.bold)),
                    ])),
                  )
                ],
              ),
            ));
      },
    );
  }
}
