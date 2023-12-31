import 'package:json_annotation/json_annotation.dart';

part 'hotel_model.g.dart';

@JsonSerializable()
class HotelModel {
  final String name, description, city;
  final int price;
  final Map<String, dynamic> rating;
  final double longitude, latitude;

  HotelModel({
    required this.name,
    required this.description,
    required this.city,
    required this.price,
    required this.rating,
    required this.longitude,
    required this.latitude,
  });

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);
}
