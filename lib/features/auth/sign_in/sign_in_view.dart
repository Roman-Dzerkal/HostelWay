import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/features/auth/sign_in/bloc/sign_in_bloc.dart';
import 'package:hostelway/resources/custom_colors.dart';

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
          appBar: AppBar(
            backgroundColor: CustomColors.primary,
            title: const Text('Sign In'),
          ),
          body: const Center(
            child: Text('Sign In'),
          ),
        );
      },
    );
  }
}
