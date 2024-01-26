import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hostelway/models/hotel_model.dart';

class HotelService {
  final instance = FirebaseFirestore.instance;

  Future<List<HotelModel>> getAllHotels() async {
    QuerySnapshot<Map<String, dynamic>> hotels =
        await instance.collection('hotels').get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = hotels.docs;

    return docs.map((e) => HotelModel.fromJson(e.data())).toList();
  }
  Future<String> createHotel(HotelModel newHotel) async {
    CollectionReference hotels = FirebaseFirestore.instance.collection('hotels');

      var reference = await hotels.add({ 'name': newHotel.name,
      'description': newHotel.description,
      'managerId': newHotel.managerId,
      'facilities': newHotel.facilities,
      'city':newHotel.city });
    
    return reference.id;
  }
}
