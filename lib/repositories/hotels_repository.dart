import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/services/hotel_service.dart';

class HotelsRepository {
  final HotelService service;
  HotelsRepository(this.service);
  
  Future<List<HotelModel>> getHotels(){

  return service.getAllHotels() ;
  }
  
Future<bool> createHotel(HotelModel model) async {
    try {
      await service.createHotel(model);
      return true;
    } catch (e) {
      return false;
    }
  }

}
