import 'package:freezed_annotation/freezed_annotation.dart';

part 'demo.freezed.dart';

@freezed
@JsonSerializable()
class Person with _$Person {
  const factory Person({
    required String firstName,
    required String lastName,
    required int age,
  }) = _Person;

  factory Person.fromJson(Map<String, Object?> json) => _$PersonFromJson(json);
}
