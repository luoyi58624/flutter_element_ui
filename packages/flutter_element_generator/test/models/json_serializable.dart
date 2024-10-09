import 'package:json_annotation/json_annotation.dart';

part '../generates/models/json_serializable.g.dart';

@JsonSerializable()
class Person {
  final String firstName;
  final String lastName;
  final double doubleField;

  @JsonKey(defaultValue: [
    'hello',
    'world',
    ['xx']
  ])
  final List listField;

  @JsonKey(defaultValue: {
    'name': 'hihi',
    'child': {'age': 20}
  })
  final Map mapField;
  final DateTime? time;
  final Son? son;

  Person({
    required this.firstName,
    required this.lastName,
    required this.doubleField,
    required this.listField,
    required this.mapField,
    this.time,
    this.son,
  });

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);

  Map<String, dynamic> toJson() => _$PersonToJson(this);
}

@JsonSerializable()
class Son {
  final String name;

  Son({required this.name});

  factory Son.fromJson(Map<String, dynamic> json) => _$SonFromJson(json);

  Map<String, dynamic> toJson() => _$SonToJson(this);
}
