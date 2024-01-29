import 'package:hostelway/services/hotel_service.dart';

class HotelsRepository {
  final HotelService service;
  HotelsRepository(this.service);

  List getHotels() {
    return [];
  }

  Future<String> createHotel(Map<String, dynamic> data) async {
    return await service.createHotel(data);
  }
}
