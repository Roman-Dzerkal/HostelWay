import 'package:hostelway/domain/models/room_model.dart';
import 'package:hostelway/data/data_sources/room_service.dart';

class RoomsRepository {
  final RoomService service;
  RoomsRepository(this.service);

  Future<List<RoomModel>> fetchRooms(String hotelId) async {
    return await service.fetchRooms(hotelId);
  }

  Future<String> createRoom(Map<String, dynamic> data) async {
    return await service.createRoom(data);
  }
}
