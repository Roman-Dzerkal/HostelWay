import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String firstName;
  final String role;

  UserModel copyWith({
    String? firstName,
    String? role,
  }) {
    return UserModel(
      firstName: firstName ?? this.firstName,
      role: role ?? this.role,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  UserModel({
    required this.firstName,
    required this.role,
  });

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
