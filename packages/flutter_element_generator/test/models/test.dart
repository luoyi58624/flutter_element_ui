import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import 'animal.dart';
import 'user.dart';

part '../generates/models/test.g.dart';

@ElModel.all(toJsonUnderline: true)
class TestModel implements ElSerializeModel<TestModel> {
  @ElModelField(jsonKey: 'custom_string')
  final String stringField;
  final String? stringField2;
  @ElModelField(defaultValue: 'hello')
  final String stringField3;
  @ElModelField(defaultValue: 'hello')
  final String? stringField4;

  final num numField;
  final num? numField2;
  @ElModelField(defaultValue: 10.0)
  final num numField3;
  @ElModelField(defaultValue: 10)
  final num? numField4;

  final int intField;
  final int? intField2;
  @ElModelField(defaultValue: 10)
  final int intField3;
  @ElModelField(defaultValue: 20)
  final int? intField4;

  final double doubleField;
  final double? doubleField2;
  @ElModelField(defaultValue: 10.0)
  final double doubleField3;
  @ElModelField(defaultValue: 10.0)
  final double? doubleField4;

  final bool boolField;
  final bool? boolField2;
  @ElModelField(defaultValue: true)
  final bool boolField3;
  @ElModelField(defaultValue: true, jsonKey: 'custom_bool')
  final bool? boolField4;

  @ElModelField(defaultValue: [
    1,
    'hello',
    false,
    ['hihi']
  ])
  final List listField;
  @ElModelField(defaultValue: [1, 'hello', false])
  final List? listField2;
  final List<String> listStringField;
  final List<String>? listStringField2;

  @ElModelField(defaultValue: ['hello', 'world'])
  final List<String> listStringField3;
  @ElModelField(ignore: ElModel(generateEquals: true))
  final List<String>? listStringField4;
  @ElModelField(ignore: ElModel(generateEquals: true))
  final List<int> listIntField;
  @ElModelField(ignore: ElModel(generateEquals: true))
  final List<int>? listIntField2;

  @ElModelField(defaultValue: [1, 2, 3, 4, 5])
  final List<int> listIntField3;
  final List<int>? listIntField4;
  final List<double> listDoubleField;
  final List<double>? listDoubleField2;
  @ElModelField(defaultValue: [1, 2, 3, 4, 5])
  final List<double> listDoubleField3;
  final List<double>? listDoubleField4;

  @ElModelField(defaultValue: {'hihi'})
  final Set setField;
  final Set? setField2;
  final Map<String, dynamic> mapField;
  @ElModelField(
    defaultValue: {
      'name': 'hihi',
      'child': {'age': 20}
    },
  )
  final Map<String, dynamic>? mapField2;

  final UserModel userModel;
  @ElModelField(
    defaultValue: UserModel(
        username: 'hihi',
        age: 30,
        child: UserModel(username: 'xx', age: 14),
        children: [
          UserModel(username: 'one', age: 18),
          UserModel(username: 'two', age: 4),
        ],
        animalMap: {
          'one': AnimalModel(name: '旺财', type: '小狗'),
          'two': AnimalModel(name: '小白', type: '猫咪'),
        }),
  )
  final UserModel? userModel2;
  @ElModelField(jsonKey: 'my_animal_model')
  final AnimalModel myAnimal;
  @ElModelField(defaultValue: AnimalModel(name: '旺财', type: '小狗'))
  final AnimalModel? myDog;
  @ElModelField(
    defaultValue: [
      AnimalModel(name: '旺财', type: '小狗'),
      AnimalModel(name: '小白', type: '猫咪'),
    ],
  )
  final List<AnimalModel> animalList;

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
    required this.listField,
    this.listField2,
    required this.listStringField,
    this.listStringField2,
    required this.listStringField3,
    this.listStringField4,
    required this.listIntField,
    this.listIntField2,
    required this.listIntField3,
    this.listIntField4,
    required this.listDoubleField,
    this.listDoubleField2,
    required this.listDoubleField3,
    this.listDoubleField4,
    required this.setField,
    this.setField2,
    required this.mapField,
    this.mapField2,
    required this.userModel,
    this.userModel2,
    required this.myAnimal,
    this.myDog,
    required this.animalList,
  });

  factory TestModel.fromJson(Map<String, dynamic>? json) {
    return _fromJson(json);
  }

  @override
  TestModel fromJson(Map<String, dynamic>? json) => _fromJson(json);

  @override
  Map<String, dynamic> toJson() => _toJson();

  @override
  bool operator ==(Object other) => _equals(other);

  @override
  int get hashCode => _hashCode;

  @override
  String toString() => _toString();
}
