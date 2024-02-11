part of 'home_manager_bloc.dart';

sealed class HomeManagerState extends Equatable {
  final List<HotelModel> hotels;

  final bool isBusy;

  const HomeManagerState({required this.hotels, this.isBusy = false});

  HomeManagerState copyWith({List<HotelModel>? hotels, bool? isBusy}) {
    return HomeManagerInitial(
        hotels: hotels ?? this.hotels, isBusy: isBusy ?? this.isBusy);
  }

  @override
  List<Object> get props => [hotels, isBusy];
}

final class HomeManagerInitial extends HomeManagerState {
  const HomeManagerInitial({required super.hotels, super.isBusy});
}
