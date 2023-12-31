import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue('manager')
  manager,

  @JsonValue('guest')
  guest
}
