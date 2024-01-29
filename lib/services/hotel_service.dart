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

  Future<List<HotelModel>> fetchHotels({String userId = ''}) async {
    List<Map<String, dynamic>> hotels = List.empty(growable: true);

    if (userId.isNotEmpty) {
      var t = await client.from('hotels').select().eq('manager_id', userId);

      if (t.isEmpty) {
        return [];
      }

      hotels.addAll(t);
    }
    var t = await client.from('hotels').select();
    if (t.isEmpty) {
      return [];
    }

    hotels.addAll(t);

    for (Map<String, dynamic> hotel in hotels) {
      int id = hotel['hotel_id'] as int;

      List<FileObject> hotelPhotos =
          await client.storage.from('hotels').list(path: id.toString());

      var photoUrls = hotelPhotos.map((e) {
        return client.storage.from('hotels').getPublicUrl('$id/${e.name}');
      }).toList();
      hotel.addAll({'photos': photoUrls});
    }

    return hotels.map((e) => HotelModel.fromJson(e)).toList();
  }
}
