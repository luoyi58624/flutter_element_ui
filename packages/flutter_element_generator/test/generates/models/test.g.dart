// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/test.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

final TestModel $testModel = TestModel(
  stringField: '',
  stringField3: 'hello',
  stringField4: 'hello',
  numField: 0.0,
  numField3: 10.0,
  numField4: 10,
  intField: 0,
  intField3: 10,
  intField4: 20,
  doubleField: 0.0,
  doubleField3: 10.0,
  doubleField4: 10.0,
  boolField: false,
  boolField3: true,
  boolField4: true,
  listField: [
    1,
    'hello',
    false,
    ['hihi']
  ],
  listField2: [1, 'hello', false],
  listStringField: [],
  listStringField3: ['hello', 'world'],
  listIntField: [],
  listIntField3: [1, 2, 3, 4, 5],
  listDoubleField: [],
  listDoubleField3: [1, 2, 3, 4, 5],
  setField: {'hihi'},
  mapField: {},
  mapField2: {
    'name': 'hihi',
    'child': {'age': 20}
  },
  userModel: $userModel,
);

TestModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $testModel;
  return TestModel(
    stringField: ElJsonUtil.$string(json, 'custom_string') ?? '',
    stringField2: ElJsonUtil.$string(json, 'stringField2'),
    stringField3: ElJsonUtil.$string(json, 'stringField3') ?? 'hello',
    stringField4: ElJsonUtil.$string(json, 'stringField4') ?? 'hello',
    numField: ElJsonUtil.$num(json, 'numField') ?? 0.0,
    numField2: ElJsonUtil.$num(json, 'numField2'),
    numField3: ElJsonUtil.$num(json, 'numField3') ?? 10.0,
    numField4: ElJsonUtil.$num(json, 'numField4') ?? 10,
    intField: ElJsonUtil.$int(json, 'intField') ?? 0,
    intField2: ElJsonUtil.$int(json, 'intField2'),
    intField3: ElJsonUtil.$int(json, 'intField3') ?? 10,
    intField4: ElJsonUtil.$int(json, 'intField4') ?? 20,
    doubleField: ElJsonUtil.$double(json, 'doubleField') ?? 0.0,
    doubleField2: ElJsonUtil.$double(json, 'doubleField2'),
    doubleField3: ElJsonUtil.$double(json, 'doubleField3') ?? 10.0,
    doubleField4: ElJsonUtil.$double(json, 'doubleField4') ?? 10.0,
    boolField: ElJsonUtil.$bool(json, 'boolField') ?? false,
    boolField2: ElJsonUtil.$bool(json, 'boolField2'),
    boolField3: ElJsonUtil.$bool(json, 'boolField3') ?? true,
    boolField4: ElJsonUtil.$bool(json, 'custom_bool') ?? true,
    listField: ElJsonUtil.$list<dynamic>(json, 'listField') ??
        [
          1,
          'hello',
          false,
          ['hihi']
        ],
    listField2:
        ElJsonUtil.$list<dynamic>(json, 'listField2') ?? [1, 'hello', false],
    listStringField: ElJsonUtil.$list<String>(json, 'listStringField') ?? [],
    listStringField2: ElJsonUtil.$list<String>(json, 'listStringField2'),
    listStringField3: ElJsonUtil.$list<String>(json, 'listStringField3') ??
        ['hello', 'world'],
    listStringField4: ElJsonUtil.$list<String>(json, 'listStringField4'),
    listIntField: ElJsonUtil.$list<int>(json, 'listIntField') ?? [],
    listIntField2: ElJsonUtil.$list<int>(json, 'listIntField2'),
    listIntField3:
        ElJsonUtil.$list<int>(json, 'listIntField3') ?? [1, 2, 3, 4, 5],
    listIntField4: ElJsonUtil.$list<int>(json, 'listIntField4'),
    listDoubleField: ElJsonUtil.$list<double>(json, 'listDoubleField') ?? [],
    listDoubleField2: ElJsonUtil.$list<double>(json, 'listDoubleField2'),
    listDoubleField3:
        ElJsonUtil.$list<double>(json, 'listDoubleField3') ?? [1, 2, 3, 4, 5],
    listDoubleField4: ElJsonUtil.$list<double>(json, 'listDoubleField4'),
    setField: ElJsonUtil.$set<dynamic>(json, 'setField') ?? {'hihi'},
    setField2: ElJsonUtil.$set<dynamic>(json, 'setField2'),
    mapField: ElJsonUtil.$map<dynamic>(json, 'mapField') ?? {},
    mapField2: ElJsonUtil.$map<dynamic>(json, 'mapField2') ??
        {
          'name': 'hihi',
          'child': {'age': 20}
        },
    userModel: $userModel.fromJson((json['userModel'] ?? json['user_model'])),
  );
}

extension TestModelExtension on TestModel {
  Map<String, dynamic> _toJson() {
    return {
      'custom_string': stringField,
      'string_field2': stringField2,
      'string_field3': stringField3,
      'string_field4': stringField4,
      'num_field': numField,
      'num_field2': numField2,
      'num_field3': numField3,
      'num_field4': numField4,
      'int_field': intField,
      'int_field2': intField2,
      'int_field3': intField3,
      'int_field4': intField4,
      'double_field': doubleField,
      'double_field2': doubleField2,
      'double_field3': doubleField3,
      'double_field4': doubleField4,
      'bool_field': boolField,
      'bool_field2': boolField2,
      'bool_field3': boolField3,
      'custom_bool': boolField4,
      'list_field': listField,
      'list_field2': listField2,
      'list_string_field': listStringField,
      'list_string_field2': listStringField2,
      'list_string_field3': listStringField3,
      'list_string_field4': listStringField4,
      'list_int_field': listIntField,
      'list_int_field2': listIntField2,
      'list_int_field3': listIntField3,
      'list_int_field4': listIntField4,
      'list_double_field': listDoubleField,
      'list_double_field2': listDoubleField2,
      'list_double_field3': listDoubleField3,
      'list_double_field4': listDoubleField4,
      'set_field': setField,
      'set_field2': setField2,
      'map_field': mapField,
      'map_field2': mapField2,
      'user_model': userModel?.toJson(),
    };
  }

  String _toString() {
    return 'TestModel{\n  stringField: $stringField,\n  stringField2: $stringField2,\n  stringField3: $stringField3,\n  stringField4: $stringField4,\n  numField: $numField,\n  numField2: $numField2,\n  numField3: $numField3,\n  numField4: $numField4,\n  intField: $intField,\n  intField2: $intField2,\n  intField3: $intField3,\n  intField4: $intField4,\n  doubleField: $doubleField,\n  doubleField2: $doubleField2,\n  doubleField3: $doubleField3,\n  doubleField4: $doubleField4,\n  boolField: $boolField,\n  boolField2: $boolField2,\n  boolField3: $boolField3,\n  boolField4: $boolField4,\n  listField: $listField,\n  listField2: $listField2,\n  listStringField: $listStringField,\n  listStringField2: $listStringField2,\n  listStringField3: $listStringField3,\n  listStringField4: $listStringField4,\n  listIntField: $listIntField,\n  listIntField2: $listIntField2,\n  listIntField3: $listIntField3,\n  listIntField4: $listIntField4,\n  listDoubleField: $listDoubleField,\n  listDoubleField2: $listDoubleField2,\n  listDoubleField3: $listDoubleField3,\n  listDoubleField4: $listDoubleField4,\n  setField: $setField,\n  setField2: $setField2,\n  mapField: $mapField,\n  mapField2: $mapField2,\n  userModel: $userModel\n}';
  }
}
