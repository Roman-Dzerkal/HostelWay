import 'dart:core';

import 'package:hostelway/domain/models/hotel_model.dart';

typedef MyType = List<Map<String, dynamic>>;


/// TODO: Implement with Firebase
class HotelService {
  Future<List<HotelModel>> getAllHotels() async {
    return [];
  }

  void addFavorites(String id) async {}

  Future<String> createHotel(Map<String, dynamic> data) async {
    return '';
  }

  Future<List<HotelModel>> fetchFavoriteHotels() async {
    return [];
  }

  Future<List<HotelModel>> fetchHotels({
    String userId = '',
    String query = '',
  }) async {
    return [];
  }
}

//добавить параметр именованный необяз в функцию getAllHotels, принимает ид менеджер
// проверка если ид менеджера не пустой , то сделать запрос ко всем отелям и отфильтровать те, у кот. поле  мереджер ид совпадает с переданным 
// создать ивент по переходу на стр май хотелс . обращение к сервису для получения отелей менеджера . в сервис передать ид. через файербейз ауз инстанс каррент юзер ! uid 
//