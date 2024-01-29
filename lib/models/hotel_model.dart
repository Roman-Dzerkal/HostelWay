class HotelModel {
  final String name, description, city;
  final String managerId;
  final List<String> photos;
  final List<String> facilities;
  final double latitude, longitude;

  HotelModel(
      {required this.name,
      required this.description,
      required this.city,
      required this.facilities,
      required this.managerId,
      required this.latitude,
      required this.longitude,
      required this.photos});

  factory HotelModel.fromJson(Map<String, dynamic> json) => HotelModel(
        name: json['name'] as String,
        description: json['description'] as String,
        city: json['city'] as String,
        facilities: (json['facilities'] as List<dynamic>)
            .map((e) => e as String)
            .toList(),
        managerId: json['manager_id'] as String,
        photos: (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
        latitude: json['latitude'] as double,
        longitude: json['longitude'] as double,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'description': description,
        'city': city,
        'managerId': managerId,
        'photos': photos,
        'facilities': facilities,
        'latitude': latitude,
        'longitude': longitude,
      };
}
