import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hostelway/views/home/home_manager/bloc/home_manager_bloc.dart';
import 'package:hostelway/views/home/navigation/home_manager_navigator.dart';

class HomeManagerView extends StatelessWidget {
  const HomeManagerView({super.key, required HomeManagerNavigator navigator});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeManagerBloc(),
      child: const HomeManagerLayout(),
    );
  }
}

class HomeManagerLayout extends StatelessWidget {
  const HomeManagerLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeManagerBloc, HomeManagerState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('HomeManager'),
          ),
          body: const Center(
            child: Text('HomeManager'),
          ),
        );
      },
    );
  }
}
