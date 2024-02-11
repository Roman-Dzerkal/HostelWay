class UserModel {
  final String firstName;
  final String lastName;
  final String id;
  final String role;
  final List<String> favs;

  UserModel copyWith(
      {String? firstName,
      String? role,
      String? lastName,
      String? id,
      List<String>? favs}) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      role: role ?? this.role,
      lastName: lastName ?? this.lastName,
      id: id ?? this.id,
      favs: favs ?? this.favs
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] as String,
      role: json['role'] as String,
      lastName: json['last_name'] as String,
      id: json['user_id'] as String,
      //favs: json['favorite_hotels'] as List<int>
      favs: List<String>.from(json["favorite_hotels"])
    );
  }

  UserModel({
    required this.firstName,
    required this.role,
    required this.lastName,
    required this.id,
    required this.favs
  });

  Map<String, dynamic> toJson(UserModel instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'id': instance.id,
      'role': instance.role,
      'favorite_hotels': instance.favs
    };
  }
}
