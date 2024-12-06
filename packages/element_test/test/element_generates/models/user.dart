import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';

import 'animal.dart';

part '../generates/models/user.g.dart';

@ElModel.all()
class UserModel implements SerializeModel<UserModel> {
  final String? username;
  final int? age;
  final UserModel? child;
  final List<UserModel>? children;
  final Map<String, AnimalModel>? animalMap;
  final Map? mapField;

  const UserModel({
    this.username,
    this.age,
    this.child,
    this.children,
    this.animalMap,
    this.mapField,
  });

  @override
  UserModel fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
