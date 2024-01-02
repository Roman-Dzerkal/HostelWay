import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
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

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel({
    required this.firstName,
    required this.role,
    required this.lastName,
    required this.id,
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
