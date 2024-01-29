import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/features/auth/sign_up/bloc/sign_up_bloc.dart';
import 'package:hostelway/features/auth/sign_up/navigation/sign_in_navigator.dart';
import 'package:hostelway/main.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/services/overlay_service.dart';
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
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.isBusy) {
          OverlayService.instance.showBusyOverlay(
            context: context,
            size: size,
          );
        } else {
          OverlayService.instance.closeBusyOverlay(context);
        }
      },
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
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 16.sp, right: 16.sp, bottom: 30.sp),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                          height: 100.h,
                          width: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey[300],
                            image: state.avatar != null
                                ? DecorationImage(
                                    image: FileImage(File(state.avatar!.path)),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo_outlined),
                            onPressed: () {
                              bloc.add(const AvatarUploadButtonPressedEvent());
                            },
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15, top: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomTextField(
                            autofillHints: const [AutofillHints.givenName],
                            height: 80.h,
                            width: 170.w,
                            onChanged: (value) {
                              bloc.add(SignUpFirstNameChangedEvent(value));
                            },
                            borderRad: 10.r,
                            helperText: 'First Name',
                            hintText: 'John',
                            keyboardType: TextInputType.text,
                            helperTextStyle:
                                TextStyling.blackText(14, FontWeight.w600),
                            hintTextStyle:
                                TextStyling.greyText(14, FontWeight.normal),
                            onSubmitted: (value) {
                              bloc.add(FirstNameFormSubmittedEvent(
                                  firstName: value));
                            },
                            errorText: state.errorState.isFirstNameError
                                ? state.errorFirstNameMessage
                                : null,
                          ),
                          CustomTextField(
                            autofillHints: const [AutofillHints.familyName],
                            height: 80.h,
                            width: 170.w,
                            onChanged: (value) {
                              bloc.add(SignUpLastNameChangedEvent(value));
                            },
                            borderRad: 10.r,
                            helperText: 'Last Name',
                            helperTextStyle:
                                TextStyling.blackText(14, FontWeight.w600),
                            hintText: 'Doe',
                            keyboardType: TextInputType.text,
                            hintTextStyle:
                                TextStyling.greyText(14, FontWeight.normal),
                            onSubmitted: (value) {
                              bloc.add(
                                  LastNameFormSubmittedEvent(lastName: value));
                            },
                            errorText: state.errorState.isLastNameError
                                ? state.errorLastNameMessage
                                : null,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CustomTextField(
                        autofillHints: const [AutofillHints.email],
                        height: 80.h,
                        onChanged: (value) {
                          bloc.add(SignUpEmailChangedEvent(value));
                        },
                        borderRad: 10.r,
                        helperText: 'Email',
                        hintText: 'Enter your email',
                        helperTextStyle:
                            TextStyling.blackText(14, FontWeight.w600),
                        keyboardType: TextInputType.emailAddress,
                        hintTextStyle:
                            TextStyling.greyText(14, FontWeight.normal),
                        onSubmitted: (value) {
                          bloc.add(EmailFormSubmittedEvent(email: value));
                        },
                        errorText: state.errorState.isEmailError
                            ? state.errorEmailMessage
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: CustomTextField(
                        autofillHints: const [AutofillHints.password],
                        height: 80.h,
                        hintText: 'Enter your password',
                        helperText: 'Password',
                        helperTextStyle:
                            TextStyling.blackText(14, FontWeight.w600),
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
                        onSubmitted: (value) {
                          bloc.add(PasswordFormSubmittedEvent(password: value));
                        },
                        errorText: state.errorState.isPasswordError
                            ? state.errorPasswordMessage
                            : null,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: CustomTextField(
                        autofillHints: const [AutofillHints.password],
                        height: 80.h,
                        onChanged: (value) {
                          bloc.add(SignUpConfirmPasswordChangedEvent(value));
                        },
                        borderRad: 10.r,
                        hintText: 'Enter your password again',
                        helperText: 'Confirm Password',
                        helperTextStyle:
                            TextStyling.blackText(14, FontWeight.w600),
                        keyboardType: TextInputType.text,
                        isObscure: state.isConfirmPasswordInvisible,
                        isPassword: true,
                        onEyeTap: () {
                          bloc.add(
                              const ConfirmPasswordVisibilityChangedEvent());
                        },
                        maxLines: 1,
                        hintTextStyle:
                            TextStyling.greyText(14, FontWeight.normal),
                        onSubmitted: (value) {
                          bloc.add(ConfirmPasswordFormSubmittedEvent(
                              confirmPassword: value));
                        },
                        errorText: state.errorState.isConfirmPasswordError
                            ? state.errorConfirmPasswordMessage
                            : null,
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
                      activeBgColors: const [
                        [CustomColors.primary],
                        [CustomColors.primary]
                      ],
                      onToggle: (index) {
                        bloc.add(SignUpRoleChangedEvent(index!));
                      },
                    ),
                  ],
                ),
              ),
            ));
      },
    );
  }
}
