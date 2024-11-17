class RoomModel {
  final String name;
  final String hotelId;
  final int price;
  final String id;
  final String description;
  final String bookingStatus;
  final List<String> photos;

  RoomModel(
      {required this.name,
      required this.price,
      required this.id,
      required this.description,
      required this.bookingStatus,
      required this.hotelId,
      required this.photos});

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
      name: json['name'] as String,
      price: json['price'] as int,
      hotelId: json['hotel_id'] as String,
      bookingStatus: json['booking_status'] as String,
      description: json['description'] as String,
      photos:
            (json['photos'] as List<dynamic>).map((e) => e as String).toList(),
      id: json['room_id'] as String);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'price': price,
        'hotelId': hotelId,
        'id': id,
        'photos': photos,
        'description': description,
        'bookingStatus': bookingStatus
      };
}
