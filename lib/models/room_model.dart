class RoomModel {
  final String name;
  final int hotelId;
  final int price;
  final int id;
  final String description;
  final String bookingStatus;

  RoomModel(
      {required this.name,
      required this.price,
      required this.id,
      required this.description,
      required this.bookingStatus,
      required this.hotelId});

  factory RoomModel.fromJson(Map<String, dynamic> json) => RoomModel(
      name: json['name'] as String,
      price: json['price'] as int,
      hotelId: json['hotel_id'] as int,
      bookingStatus: json['booking_status'] as String,
      description: json['description'] as String,
      id: json['room_id'] as int);

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'price': price,
        'hotelId': hotelId,
        'id': id,
        'description': description,
        'bookingStatus': bookingStatus
      };
}
