import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/rendering.dart';
import 'package:hostelway/models/hotel_model.dart';

class HotelService {
  final instance = FirebaseFirestore.instance;

  Future<List<HotelModel>> getAllHotels({String managerId = ""}) async {
    QuerySnapshot<Map<String, dynamic>>? hotels;
    try {
      if (managerId.isNotEmpty) {
        hotels = await instance
            .collection('hotels')
            .where("managerId", isEqualTo: managerId)
            .get();
      } else {
        hotels = await instance.collection('hotels').get();
      }
    } catch (e) {
      if (e is FirebaseException) {
        debugPrint(e.toString());
      }
      else{
        debugPrint(e.toString());
      }
    }

    List<QueryDocumentSnapshot<Map<String, dynamic>>> docs = hotels!.docs;

    return docs.map((e) => HotelModel.fromJson(e.data())).toList();
  }

  Future<String> createHotel(HotelModel newHotel) async {
    CollectionReference hotels =
        FirebaseFirestore.instance.collection('hotels');

    var reference = await hotels.add({
      'name': newHotel.name,
      'description': newHotel.description,
      'managerId': newHotel.managerId,
      'facilities': newHotel.facilities,
      'city': newHotel.city
    });

    return reference.id;
  }
}

//добавить параметр именованный необяз в функцию getAllHotels, принимает ид менеджер
// проверка если ид менеджера не пустой , то сделать запрос ко всем отелям и отфильтровать те, у кот. поле  мереджер ид совпадает с переданным 
// создать ивент по переходу на стр май хотелс . обращение к сервису для получения отелей менеджера . в сервис передать ид. через файербейз ауз инстанс каррент юзер ! uid 
//