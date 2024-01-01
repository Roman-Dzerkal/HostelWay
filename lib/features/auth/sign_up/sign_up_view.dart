import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:hostelway/features/auth/sign_up/navigation/sign_in_navigator.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';
import 'package:toggle_switch/toggle_switch.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(navigator: SignUpNavigator(context)),
      child: const SignUpLayout(),
    );
  }
}

class SignUpLayout extends StatelessWidget {
  const SignUpLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SignUpBloc>();
    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.keyboard_arrow_left_outlined),
                onPressed: () => Navigator.pop(context),
              ),
              centerTitle: true,
              backgroundColor: CustomColors.primary,
              title: Text('Sign Up',
                  style: TextStyling.whiteText(18, FontWeight.bold)),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15, top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextField(
                          width: 170.w,
                          onChanged: (value) {
                            bloc.add(SignUpFirstNameChangedEvent(value));
                          },
                          borderRad: 10.r,
                          hintText: 'First Name',
                          keyboardType: TextInputType.text,
                          hintTextStyle:
                              TextStyling.greyText(14, FontWeight.normal),
                        ),
                        CustomTextField(
                          width: 170.w,
                          onChanged: (value) {
                            bloc.add(SignUpLastNameChangedEvent(value));
                          },
                          borderRad: 10.r,
                          hintText: 'Last Name',
                          keyboardType: TextInputType.text,
                          hintTextStyle:
                              TextStyling.greyText(14, FontWeight.normal),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextField(
                      onChanged: (value) {
                        bloc.add(SignUpEmailChangedEvent(value));
                      },
                      borderRad: 10.r,
                      hintText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      hintTextStyle:
                          TextStyling.greyText(14, FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextField(
                      hintText: 'Password',
                      onChanged: (value) {
                        bloc.add(SignUpPasswordChangedEvent(value));
                      },
                      onEyeTap: () {
                        bloc.add(const PasswordVisibilityChangedEvent());
                      },
                      borderRad: 10.r,
                      isObscure: state.isPasswordInvisible,
                      isPassword: true,
                      maxLines: 1,
                      keyboardType: TextInputType.text,
                      hintTextStyle:
                          TextStyling.greyText(14, FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextField(
                      onChanged: (value) {
                        bloc.add(SignUpConfirmPasswordChangedEvent(value));
                      },
                      borderRad: 10.r,
                      hintText: 'Confirm Password',
                      keyboardType: TextInputType.text,
                      isObscure: state.isConfirmPasswordInvisible,
                      isPassword: true,
                      onEyeTap: () {
                        bloc.add(const ConfirmPasswordVisibilityChangedEvent());
                      },
                      maxLines: 1,
                      hintTextStyle:
                          TextStyling.greyText(14, FontWeight.normal),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: BestButton(
                      onTap: () {
                        bloc.add(const SignUpButtonPressedEvent());
                      },
                      height: 60.h,
                      text: "Sign up",
                      backgroundColor: CustomColors.primary,
                      borderRadius: 100.r,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Text('Sign up as a',
                        style: TextStyling.greyText(14, FontWeight.normal)),
                  ),
                  ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex: state.initialLabelIndex,
                    cornerRadius: 20.0,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: state.roles,
                    activeBgColors: [
                      [CustomColors.primary],
                      [CustomColors.primary]
                    ],
                    onToggle: (index) {
                      bloc.add(SignUpRoleChangedEvent(index!));
                    },
                  ),
                ],
              ),
            ));
      },
    );
  }
}
