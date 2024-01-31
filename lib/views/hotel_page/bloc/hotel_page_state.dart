part of 'hotel_page_bloc.dart';

sealed class HotelPageState extends Equatable {
  /*final String role =
      Supabase.instance.client.auth.currentUser?.userMetadata?['role'];*/
  const HotelPageState();

  @override
  List<Object> get props => [];
}

final class HotelPageInitial extends HotelPageState {}
