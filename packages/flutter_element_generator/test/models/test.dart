import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import 'user.dart';

part '../generates/models/test.g.dart';

@ElModel.all(toJsonUnderline: true)
class TestModel implements ElSerializeModel<TestModel> {
  final String stringField;
  final String? stringField2;
  @ElModelField(defaultValue: 'stringField3')
  final String stringField3;
  @ElModelField(defaultValue: 'stringField4')
  final String? stringField4;

  final num numField;
  final num? numField2;
  @ElModelField(defaultValue: 100.0)
  final num numField3;
  @ElModelField(defaultValue: 88)
  final num? numField4;

  final int intField;
  final int? intField2;
  @ElModelField(defaultValue: 20)
  final int intField3;
  @ElModelField(defaultValue: 300)
  final int? intField4;

  final double doubleField;
  final double? doubleField2;
  @ElModelField(defaultValue: 60.0)
  final double doubleField3;
  @ElModelField(defaultValue: 800.0)
  final double? doubleField4;

  final bool boolField;
  final bool? boolField2;
  @ElModelField(defaultValue: true)
  final bool boolField3;
  @ElModelField(defaultValue: true)
  final bool? boolField4;

  final List<String> listStringField;
  final List<String>? listStringField2;
  // @ElModelField(defaultValue: ['hello', 'world'])
  final List<String> listStringField3;
  final List<String>? listStringField4;

  final List? myList;
  final List<num> numList;
  final Map<String, dynamic> myMap;
  final UserModel? userModel;

  TestModel({
    required this.stringField,
    this.stringField2,
    required this.stringField3,
    this.stringField4,
    required this.numField,
    this.numField2,
    required this.numField3,
    this.numField4,
    required this.intField,
    this.intField2,
    required this.intField3,
    this.intField4,
    required this.doubleField,
    this.doubleField2,
    required this.doubleField3,
    this.doubleField4,
    required this.boolField,
    this.boolField2,
    required this.boolField3,
    this.boolField4,
    required this.listStringField,
    this.listStringField2,
    required this.listStringField3,
    this.listStringField4,
    this.myList,
    required this.numList,
    required this.myMap,
    this.userModel,
  });

  factory TestModel.fromJson(Map<String, dynamic>? json) {
    return _fromJson(json);
  }

  @override
  TestModel fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  String toString() => _toString();
}
