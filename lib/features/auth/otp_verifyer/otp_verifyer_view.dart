import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/features/auth/otp_verifyer/bloc/otp_verifyer_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:hostelway/resources/custom_colors.dart';

class OtpVerifyerView extends StatelessWidget {
  const OtpVerifyerView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OtpVerifyerBloc(),
      child: const OtpVerifyerLayout(),
    );
  }
}

class OtpVerifyerLayout extends StatelessWidget {
  const OtpVerifyerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<OtpVerifyerBloc>();
    return BlocConsumer<OtpVerifyerBloc, OtpVerifyerState>(
      listener: (context, state) {
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('OtpVerifyer', style: TextStyle(),),
          ),
          body: Center(
              child: OtpTextField(
            borderColor: Colors.black,
            focusedBorderColor: CustomColors.primary,
            borderWidth: 1.0,
            showFieldAsBox: true,
            onSubmit: (value) => bloc.add(OtpVerifyerSubmitEvent(value)),
            onCodeChanged: (value) =>
                bloc.add(OtpVerifyerChangeOtpEvent(value)),
            numberOfFields: 6,
          )),
        );
      },
    );
  }
}
