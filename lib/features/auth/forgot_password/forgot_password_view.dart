import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hostelway/features/auth/forgot_password/bloc/forgot_password_bloc.dart';
import 'package:hostelway/features/auth/forgot_password/navigation/forgot_password_navigator.dart';
import 'package:hostelway/resources/custom_colors.dart';
import 'package:hostelway/resources/text_styling.dart';
import 'package:hostelway/widget_helpers/best_button.dart';
import 'package:hostelway/widget_helpers/custom_text_field.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ForgotPasswordBloc(ForgotPasswordNavigator(context)),
      child: const ForgotPasswordLayout(),
    );
  }
}

class ForgotPasswordLayout extends StatelessWidget {
  const ForgotPasswordLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<ForgotPasswordBloc>();
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        
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
              title: Text('Forgot Password',
                  style: TextStyling.whiteText(18, FontWeight.bold)),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: CustomTextField(
                        borderRad: 10.r,
                        helperTextStyle:
                            TextStyling.blackText(14, FontWeight.w600),
                        hintTextStyle:
                            TextStyling.greyText(14, FontWeight.normal),
                        height: 80.h,
                        hintText: 'Your Email Address',
                        helperText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        onSubmitted: (value) {
                          bloc.add(EmailFormSubmittedEvent(email: value));
                        },
                        onChanged: (value) {
                          bloc.add(ForgotPasswordEmailChangedEvent(value));
                        },
                        errorText: state.errorState.isEmailError
                            ? state.errorEmailMessage
                            : null,),
                        
                  ),
                  BestButton(
                      onTap: () {
                        bloc.add(PasswordResetButtonTapEvent());
                      },
                      borderRadius: 100.r,
                      height: 60.h,
                      text: 'Reset Password',
                      backgroundColor: CustomColors.primary)
                ],
              ),
            ));
      },
    );
  }
}
