import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';
import 'package:hostelway/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:hostelway/features/auth/sign_in/navigation/sign_in_navigator.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/services/overlay_service.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';
import 'package:hostelway/main.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignInBloc(
        navigator: SignInNavigator(context),
        authenticationBloc: BlocProvider.of<AuthenticationBloc>(context),
      ),
      child: const SignInLayout(),
    );
  }
}

class SignInLayout extends StatelessWidget {
  const SignInLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<SignInBloc>();
    return BlocConsumer<SignInBloc, SignInState>(
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
                    padding: const EdgeInsets.only(top: 15),
                    child: CustomTextField(
                      height: 80.h,
                      helperText: 'Email',
                      helperTextStyle:
                          TextStyling.blackText(14, FontWeight.w600),
                      onChanged: (value) {
                        bloc.add(SignInEmailChanged(value));
                      },
                      borderRad: 10.r,
                      hintText: 'Enter your email',
                      onSubmitted: (value) {
                        bloc.add(EmailFormSubmittedEvent(email: value));
                      },
                      keyboardType: TextInputType.emailAddress,
                      hintTextStyle:
                          TextStyling.greyText(14, FontWeight.normal),
                      errorText: state.errorState.isEmailError
                          ? state.errorEmailMessage
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: CustomTextField(
                      height: 80.h,
                      onChanged: (value) {
                        bloc.add(SignInPasswordChanged(value));
                      },
                      helperText: 'Password',
                      helperTextStyle: TextStyling.blackText(14, FontWeight.w600),
                      outlineInputBorderColor: CustomColors.grey,
                      borderRad: 10.r,
                      hintText: 'Enter your password',
                      keyboardType: TextInputType.text,
                      isObscure: state.isPasswordInvisible,
                      maxLines: 1,
                      isPassword: true,
                      onEyeTap: () {
                        bloc.add(SignInPasswordVisibleChanged());
                      },
                      onSubmitted: (value) {
                        bloc.add(PasswordFormSubmittedEvent(password: value));
                      },
                      hintTextStyle: TextStyling.greyText(14, FontWeight.normal),
                      errorText: state.errorState.isPasswordError
                          ? state.errorPasswordMessage
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: BestButton(
                      onTap: () {
                        bloc.add(const SignInSubmitted());
                      },
                      height: 60.h,
                      text: "Sign in",
                      backgroundColor: CustomColors.primary,
                      borderRadius: 100.r,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: InkWell(
                        onTap: () {
                          bloc.add(ForgotPasswordTextTapEvent());
                        },
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
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              bloc.add(SignUpTextTapEvent());
                            },
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
