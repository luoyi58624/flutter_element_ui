import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/models/user.g.dart';

@ElModel.all()
class UserModel implements ElSerializeModel<UserModel> {
  final String? username;
  final int? age;

  UserModel({
    this.username,
    this.age,
  });

  @override
  UserModel fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}
