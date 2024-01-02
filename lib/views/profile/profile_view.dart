import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/enums/role_enums.dart';
import 'package:hostelway/utils/role_navigator.dart';
import 'package:hostelway/views/profile/bloc/profile_bloc.dart';
import 'package:hostelway/widget_helpers/custom_navbar/guest_navbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: ProfileLayout(),
    );
  }
}

class ProfileLayout extends StatelessWidget {
  const ProfileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text('Profile'),
          ),
          body: Center(
            child: Text('Profile'),
          ),
        );
      },
    );
  }
}
