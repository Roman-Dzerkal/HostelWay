import 'dart:core';

import 'package:hostelway/models/hotel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HotelService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<HotelModel>> getAllHotels() async {
    List<Map<String, dynamic>> select =
        await Supabase.instance.client.from('hotels').select();
    return select.map((e) => HotelModel.fromJson(e)).toList();
  }

  Future<String> createHotel(HotelModel newHotel) async {
    var single = await Supabase.instance.client
        .from('hotels')
        .insert({
          'name': newHotel.name,
          'description': newHotel.description,
          'managerId': newHotel.managerId,
          'facilities': newHotel.facilities,
          'city': newHotel.city
        })
        .select()
        .single();

    return single['id'].toString();
  }

  /* Future<String> createHotel() async {
    Map<String, dynamic> hotel =
        await _client.from('hotels').insert({}).select().single();
    return (hotel['id'] as int).toString();
  } */
}
