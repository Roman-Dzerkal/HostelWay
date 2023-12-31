// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      price: json['price'] as int,
      rating: json['rating'] as Map<String, dynamic>,
      longitude: (json['longitude'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
    );

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'price': instance.price,
      'rating': instance.rating,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
    };
