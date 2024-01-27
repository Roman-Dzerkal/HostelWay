part of 'home_manager_bloc.dart';

sealed class HomeManagerState extends Equatable {

  final List<HotelModel> hotels;

  const HomeManagerState({this.hotels = const []});

  HomeManagerState copyWith({
    List<HotelModel>? hotels,
  }) {
    return HomeManagerInitial(
      hotels: hotels ?? this.hotels,
    );
  }
  @override
  List<Object> get props => [];
}

final class HomeManagerInitial extends HomeManagerState {
const HomeManagerInitial({super.hotels});
}
