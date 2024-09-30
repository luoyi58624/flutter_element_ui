import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/modals/user.g.dart';

@ElModel.all()
class UserModel implements ElSerialize {
  final String? username;
  final int? age;

  UserModel({
    this.username,
    this.age,
  });

  @override
  ElSerialize fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();
}