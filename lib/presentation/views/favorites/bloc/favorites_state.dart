part of 'favorites_bloc.dart';

sealed class FavoritesState extends Equatable {
  const FavoritesState({required this.hotels});
  final List<HotelModel> hotels;

  FavoritesState copyWith({List<HotelModel>? hotels, bool? isBusy}) {
    return FavoritesInitial(hotels: hotels ?? this.hotels);
  }

  @override
  List<Object> get props => [hotels];
}

final class FavoritesInitial extends FavoritesState {
  const FavoritesInitial({required super.hotels});
}
