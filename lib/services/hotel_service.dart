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

  Future<String> createHotel(Map<String, dynamic> data) async {
    var single = await Supabase.instance.client
        .from('hotels')
        .insert({
          'city': data['city'],
          'description': data['description'],
          'facilities': data['facilities'],
          'latitude': data['latitude'],
          'longitude': data['longitude'],
          'manager_id': data['manager_id'],
          'name': data['name'],
        })
        .select()
        .single();

    return single['hotel_id'].toString();
  }

  /* Future<String> createHotel() async {
    Map<String, dynamic> hotel =
        await _client.from('hotels').insert({}).select().single();
    return (hotel['id'] as int).toString();
  } */
}
