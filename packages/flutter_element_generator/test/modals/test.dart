import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import 'user.dart';

part '../generates/modals/test.g.dart';

@ElModel.all(toJsonUnderline: true)
class TestModel implements ElSerialize {
  final String id;
  final String? username;
  final num books;
  final num? users;
  @ElModelField(jsonKey: 'user_age', defaultValue: 20)
  final int age;
  final int? money;
  final bool isSon;
  final bool? isDog;
  final double width;
  final double? maxHeight;
  final List<String> peoples;
  final List? myList;
  final List<num> numList;
  final Map<String, dynamic> myMap;
  final UserModel userModel;

  TestModel({
    required this.id,
    this.username,
    required this.books,
    this.users,
    required this.age,
    this.money,
    required this.isSon,
    this.isDog,
    required this.width,
    this.maxHeight,
    required this.peoples,
    this.myList,
    required this.numList,
    required this.myMap,
    required this.userModel,
  });

  factory TestModel.fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  ElSerialize fromJson(Map<String, dynamic> json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}


