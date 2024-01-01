import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/app/auth_bloc/authentication_bloc.dart';

class RoleNavigator {
  final NavigatorState _navigator;
  final AuthenticationBloc _authBloc;

  NavigatorState get navigator => _navigator;

  RoleNavigator(BuildContext context)
      : _navigator = Navigator.of(context),
        _authBloc = BlocProvider.of<AuthenticationBloc>(context);

  bool isGuest() {
    return _authBloc.state.userModel?.role == 'guest';
  }
}
