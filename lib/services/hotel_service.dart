import 'dart:core';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hostelway/models/hotel_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

typedef MyType = List<Map<String, dynamic>>;

class HotelService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<HotelModel>> getAllHotels() async {
    List<Map<String, dynamic>> select =
        await Supabase.instance.client.from('hotels').select();
    return select.map((e) => HotelModel.fromJson(e)).toList();
  }

  void addFavorites(String id) async {
    try {
      var single = await client
          .from('users')
          .select('favorite_hotels')
          .eq('user_id', client.auth.currentUser!.id)
          .single();

      List<String> favs = [];
      if (single.containsKey('favorite_hotels') &&
          single['favorite_hotels'] != null) {
        favs = List<String>.from(single['favorite_hotels']);
      }

      if (favs.contains(id)) {
        favs.remove(id);
      } else {
        favs.add(id);
      }
      client
          .from("users")
          .update({'favorite_hotels': favs})
          .eq('user_id', client.auth.currentUser!.id)
          .then((value) => debugPrint('added to favorites'));
    } catch (e) {
      if (e is PostgrestException) {
        debugPrint(e.message);
      } else {
        debugPrint("error in service");
      }
    }
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

  Future<List<HotelModel>> fetchFavoriteHotels() async {
    List<Map<String, dynamic>> hotels = List.empty(growable: true);
    List<String> favs = List.empty(growable: true);
    var list = await client
        .from("users")
        .select('favorite_hotels')
        .eq('user_id', client.auth.currentUser!.id)
        .single();

    favs = List<String>.from(list['favorite_hotels']);

    var temp = await client.from("hotels").select().inFilter('hotel_id', favs);
    hotels.addAll(temp);
    for (Map<String, dynamic> hotel in hotels) {
      String id = hotel['hotel_id'] as String;

      List<FileObject> hotelPhotos =
          await client.storage.from('hotels').list(path: id.toString());

      hotelPhotos.removeWhere((element) => element.metadata == null);

      var photoUrls = hotelPhotos.map((e) {
        return client.storage.from('hotels').getPublicUrl('$id/${e.name}');
      }).toList();
      hotel.addAll({'photos': photoUrls});
    }

    return hotels.map((e) => HotelModel.fromJson(e)).toList();
  }

  Future<List<HotelModel>> fetchHotels(
      {String userId = '', String query = ''}) async {
    List<Map<String, dynamic>> hotels = List.empty(growable: true);

    if (userId.isNotEmpty) {
      var t = await client.from('hotels').select().eq('manager_id', userId);

      if (t.isEmpty) {
        return [];
      }

      hotels.addAll(t);
    } else {
      try {
        var t;
        if (query == '') {
          t = await client.from('hotels').select();
        } else {
          t = await client.from('hotels').select().textSearch('name', query);
        }

        if (t.isEmpty) {
          return [];
        }
        hotels.addAll(t);
        log(hotels.length.toString());
      } on Exception catch (e) {
        log(e.toString());
      }
    }

    for (Map<String, dynamic> hotel in hotels) {
      String id = hotel['hotel_id'] as String;

      List<FileObject> hotelPhotos =
          await client.storage.from('hotels').list(path: id.toString());

      hotelPhotos.removeWhere((element) => element.metadata == null);

      var photoUrls = hotelPhotos.map((e) {
        return client.storage.from('hotels').getPublicUrl('$id/${e.name}');
      }).toList();
      hotel.addAll({'photos': photoUrls});
    }

    return hotels.map((e) => HotelModel.fromJson(e)).toList();
  }
}

//добавить параметр именованный необяз в функцию getAllHotels, принимает ид менеджер
// проверка если ид менеджера не пустой , то сделать запрос ко всем отелям и отфильтровать те, у кот. поле  мереджер ид совпадает с переданным 
// создать ивент по переходу на стр май хотелс . обращение к сервису для получения отелей менеджера . в сервис передать ид. через файербейз ауз инстанс каррент юзер ! uid 
//