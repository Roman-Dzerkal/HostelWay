part of 'welcome_bloc.dart';

sealed class WelcomeEvent extends Equatable {
  const WelcomeEvent();

  @override
  List<Object> get props => [];
}

final class WelcomePageChangedEvent extends WelcomeEvent {
  final int index;

  const WelcomePageChangedEvent({required this.index});
}

class WelcomePageNextButtonTapEvent extends WelcomeEvent {
  const WelcomePageNextButtonTapEvent();
}
