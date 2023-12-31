import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_manager_event.dart';
part 'home_manager_state.dart';

class HomeManagerBloc extends Bloc<HomeManagerEvent, HomeManagerState> {
  HomeManagerBloc() : super(HomeManagerInitial()) {
    on<HomeManagerEvent>((event, emit) {});
  }
}
