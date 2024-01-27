import 'package:json_annotation/json_annotation.dart';

part 'hotel_model.g.dart';

@JsonSerializable()
class HotelModel {
  final String name, description, city;
  final String managerId;
  final List<String>? photos;
  final List<String> facilities;

  HotelModel(
      {required this.name,
      required this.description,
      required this.city,
      required this.facilities,
      required this.managerId,
      this.photos});

  factory HotelModel.fromJson(Map<String, dynamic> json) =>
      _$HotelModelFromJson(json);

  Map<String, dynamic> toJson() => _$HotelModelToJson(this);
}
