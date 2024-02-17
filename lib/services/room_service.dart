import 'dart:core';

import 'package:hostelway/models/room_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<RoomModel>> fetchRooms(String hotelId) async {
    List<Map<String, dynamic>> rooms = List.empty(growable: true);
    List<Map<String, dynamic>> t = List.empty(growable: true);
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

    for (Map<String, dynamic> room in rooms) {
      String id = room['room_id'] as String;

      List<FileObject> roomPhotos = await client.storage
          .from('hotels')
          .list(path: '${room['hotel_id']}/${id.toString()}');

      roomPhotos.removeWhere((element) => element.metadata == null);

      var photoUrls = roomPhotos.map((e) {
        return client.storage.from('hotels').getPublicUrl('${room['hotel_id']}/$id/${e.name}');
      }).toList();
      room.addAll({'photos': photoUrls});
    }

    return rooms.map((e) => RoomModel.fromJson(e)).toList();
  }

  Future<String> createRoom(Map<String, dynamic> data) async {
    var single = await Supabase.instance.client
        .from('rooms')
        .insert({
          'name': data['name'],
          'description': data['description'],
          'hotel_id': data['hotel_id'],
          'price': data['price'],
          'booking_status': data['booking_status'],
        })
        .select()
        .single();

    return single['room_id'].toString();
  }
}
