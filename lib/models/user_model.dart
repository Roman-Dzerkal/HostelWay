class UserModel {
  final String firstName;
  final String lastName;
  final String id;
  final String role;

  UserModel copyWith({
    String? firstName,
    String? role,
    String? lastName,
    String? id,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      role: role ?? this.role,
      lastName: lastName ?? this.lastName,
      id: id ?? this.id,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstName: json['first_name'] as String,
      role: json['role'] as String,
      lastName: json['last_name'] as String,
      id: json['user_id'] as String,
    );
  }

  UserModel({
    required this.firstName,
    required this.role,
    required this.lastName,
    required this.id,
  });

  Map<String, dynamic> toJson(UserModel instance) {
    return <String, dynamic>{
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'id': instance.id,
      'role': instance.role,
    };
  }
}
