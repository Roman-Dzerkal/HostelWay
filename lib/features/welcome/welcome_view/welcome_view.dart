import 'package:flutter/material.dart';
import 'package:hostelway/resources/custom_colors.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CustomColors.white,
      body: SafeArea(
        child: Center(),
      ),
    );
  }
}
