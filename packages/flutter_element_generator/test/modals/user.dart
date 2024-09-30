import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/modals/user.g.dart';

@ElModel.all()
class UserModel implements ElSerialize<UserModel> {
  final String? username;
  final int? age;

  UserModel({
    this.username,
    this.age,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  UserModel fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();
}
