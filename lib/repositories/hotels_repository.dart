import 'package:hostelway/models/hotel_model.dart';
import 'package:hostelway/services/hotel_service.dart';

class HotelsRepository {
  final HotelService service;
  HotelsRepository(this.service);
  
  Future<List<HotelModel>> getHotels(){

  return service.getAllHotels() ;
  }
  
Future<String> createHotel(HotelModel model) async {
    try {
      return await service.createHotel(model);
    } catch (e) {
      return '';
    }
  }

}
