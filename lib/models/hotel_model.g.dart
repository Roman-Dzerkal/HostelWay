// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelModel _$HotelModelFromJson(Map<String, dynamic> json) => HotelModel(
      name: json['name'] as String,
      description: json['description'] as String,
      city: json['city'] as String,
      facilities: (json['facilities'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      managerId: json['managerId'] as String,
      photos:
          (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$HotelModelToJson(HotelModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'city': instance.city,
      'managerId': instance.managerId,
      'photos': instance.photos,
      'facilities': instance.facilities,
    };
