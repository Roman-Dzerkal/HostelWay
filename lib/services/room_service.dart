import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hostelway/models/room_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<RoomModel>> fetchRooms(int hotelId) async {
    List<Map<String, dynamic>> rooms = List.empty(growable: true);
    var t;
    if ((Supabase.instance.client.auth.currentUser?.userMetadata?['role']
            as String) ==
        "guest") {
      t = await client
          .from('rooms')
          .select()
          .eq('hotel_id', hotelId)
          .eq('booking_status', 'free');
    } else {
      t = await client.from('rooms').select().eq('hotel_id', hotelId);
    }

    if (t.isEmpty) {
      return [];
    }

    rooms.addAll(t);

    return rooms.map((e) => RoomModel.fromJson(e)).toList();
  }
}
