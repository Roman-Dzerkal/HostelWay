// ignore_for_file: must_be_immutable

part of 'welcome_bloc.dart';

sealed class WelcomeState extends Equatable {
  final PageController pageController =
      PageController(initialPage: 0, keepPage: true, viewportFraction: 1.0);
  ScrollController scrollController =
      ScrollController(debugLabel: 'WelcomeScrollController');

  final bool busy;

  WelcomeState({this.busy = false});

  WelcomeState copyWith({bool? busy}) {
    return WelcomeInitial(busy: busy ?? this.busy);
  }

  @override
  List<Object> get props => [busy];
}

final class WelcomeInitial extends WelcomeState {
  WelcomeInitial({super.busy});
}
