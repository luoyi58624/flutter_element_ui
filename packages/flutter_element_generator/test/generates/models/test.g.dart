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
    };
  }

  TestModel copyWith({
    String? stringField,
    String? stringField2,
    String? stringField3,
    String? stringField4,
    num? numField,
    num? numField2,
    num? numField3,
    num? numField4,
    int? intField,
    int? intField2,
    int? intField3,
    int? intField4,
    double? doubleField,
    double? doubleField2,
    double? doubleField3,
    double? doubleField4,
    bool? boolField,
    bool? boolField2,
    bool? boolField3,
    bool? boolField4,
    List<dynamic>? listField,
    List<dynamic>? listField2,
    List<String>? listStringField,
    List<String>? listStringField2,
    List<String>? listStringField3,
    List<String>? listStringField4,
    List<int>? listIntField,
    List<int>? listIntField2,
    List<int>? listIntField3,
    List<int>? listIntField4,
    List<double>? listDoubleField,
    List<double>? listDoubleField2,
    List<double>? listDoubleField3,
    List<double>? listDoubleField4,
    Set<dynamic>? setField,
    Set<dynamic>? setField2,
    Map<String, dynamic>? mapField,
    Map<String, dynamic>? mapField2,
  }) {
    return TestModel(
      stringField: stringField ?? this.stringField,
      stringField2: stringField2 ?? this.stringField2,
      stringField3: stringField3 ?? this.stringField3,
      stringField4: stringField4 ?? this.stringField4,
      numField: numField ?? this.numField,
      numField2: numField2 ?? this.numField2,
      numField3: numField3 ?? this.numField3,
      numField4: numField4 ?? this.numField4,
      intField: intField ?? this.intField,
      intField2: intField2 ?? this.intField2,
      intField3: intField3 ?? this.intField3,
      intField4: intField4 ?? this.intField4,
      doubleField: doubleField ?? this.doubleField,
      doubleField2: doubleField2 ?? this.doubleField2,
      doubleField3: doubleField3 ?? this.doubleField3,
      doubleField4: doubleField4 ?? this.doubleField4,
      boolField: boolField ?? this.boolField,
      boolField2: boolField2 ?? this.boolField2,
      boolField3: boolField3 ?? this.boolField3,
      boolField4: boolField4 ?? this.boolField4,
      listField: listField ?? this.listField,
      listField2: listField2 ?? this.listField2,
      listStringField: listStringField ?? this.listStringField,
      listStringField2: listStringField2 ?? this.listStringField2,
      listStringField3: listStringField3 ?? this.listStringField3,
      listStringField4: listStringField4 ?? this.listStringField4,
      listIntField: listIntField ?? this.listIntField,
      listIntField2: listIntField2 ?? this.listIntField2,
      listIntField3: listIntField3 ?? this.listIntField3,
      listIntField4: listIntField4 ?? this.listIntField4,
      listDoubleField: listDoubleField ?? this.listDoubleField,
      listDoubleField2: listDoubleField2 ?? this.listDoubleField2,
      listDoubleField3: listDoubleField3 ?? this.listDoubleField3,
      listDoubleField4: listDoubleField4 ?? this.listDoubleField4,
      setField: setField ?? this.setField,
      setField2: setField2 ?? this.setField2,
      mapField: mapField ?? this.mapField,
      mapField2: mapField2 ?? this.mapField2,
    );
  }

  TestModel merge([TestModel? other]) {
    if (other == null) return this;
    return copyWith(
      stringField: other.stringField,
      stringField2: other.stringField2,
      stringField3: other.stringField3,
      stringField4: other.stringField4,
      numField: other.numField,
      numField2: other.numField2,
      numField3: other.numField3,
      numField4: other.numField4,
      intField: other.intField,
      intField2: other.intField2,
      intField3: other.intField3,
      intField4: other.intField4,
      doubleField: other.doubleField,
      doubleField2: other.doubleField2,
      doubleField3: other.doubleField3,
      doubleField4: other.doubleField4,
      boolField: other.boolField,
      boolField2: other.boolField2,
      boolField3: other.boolField3,
      boolField4: other.boolField4,
      listField: other.listField,
      listField2: other.listField2,
      listStringField: other.listStringField,
      listStringField2: other.listStringField2,
      listStringField3: other.listStringField3,
      listStringField4: other.listStringField4,
      listIntField: other.listIntField,
      listIntField2: other.listIntField2,
      listIntField3: other.listIntField3,
      listIntField4: other.listIntField4,
      listDoubleField: other.listDoubleField,
      listDoubleField2: other.listDoubleField2,
      listDoubleField3: other.listDoubleField3,
      listDoubleField4: other.listDoubleField4,
      setField: other.setField,
      setField2: other.setField2,
      mapField: other.mapField,
      mapField2: other.mapField2,
    );
  }

  bool _equals(Object other) =>
      identical(this, other) ||
      other is TestModel &&
          runtimeType == other.runtimeType &&
          stringField == other.stringField &&
          stringField2 == other.stringField2 &&
          stringField3 == other.stringField3 &&
          stringField4 == other.stringField4 &&
          numField == other.numField &&
          numField2 == other.numField2 &&
          numField3 == other.numField3 &&
          numField4 == other.numField4 &&
          intField == other.intField &&
          intField2 == other.intField2 &&
          intField3 == other.intField3 &&
          intField4 == other.intField4 &&
          doubleField == other.doubleField &&
          doubleField2 == other.doubleField2 &&
          doubleField3 == other.doubleField3 &&
          doubleField4 == other.doubleField4 &&
          boolField == other.boolField &&
          boolField2 == other.boolField2 &&
          boolField3 == other.boolField3 &&
          boolField4 == other.boolField4 &&
          listField == other.listField &&
          listField2 == other.listField2 &&
          listStringField == other.listStringField &&
          listStringField2 == other.listStringField2 &&
          listStringField3 == other.listStringField3 &&
          listStringField4 == other.listStringField4 &&
          listIntField == other.listIntField &&
          listIntField2 == other.listIntField2 &&
          listIntField3 == other.listIntField3 &&
          listIntField4 == other.listIntField4 &&
          listDoubleField == other.listDoubleField &&
          listDoubleField2 == other.listDoubleField2 &&
          listDoubleField3 == other.listDoubleField3 &&
          listDoubleField4 == other.listDoubleField4 &&
          setField == other.setField &&
          setField2 == other.setField2 &&
          mapField == other.mapField &&
          mapField2 == other.mapField2;

  int get _hashCode =>
      stringField.hashCode ^
      stringField2.hashCode ^
      stringField3.hashCode ^
      stringField4.hashCode ^
      numField.hashCode ^
      numField2.hashCode ^
      numField3.hashCode ^
      numField4.hashCode ^
      intField.hashCode ^
      intField2.hashCode ^
      intField3.hashCode ^
      intField4.hashCode ^
      doubleField.hashCode ^
      doubleField2.hashCode ^
      doubleField3.hashCode ^
      doubleField4.hashCode ^
      boolField.hashCode ^
      boolField2.hashCode ^
      boolField3.hashCode ^
      boolField4.hashCode ^
      listField.hashCode ^
      listField2.hashCode ^
      listStringField.hashCode ^
      listStringField2.hashCode ^
      listStringField3.hashCode ^
      listStringField4.hashCode ^
      listIntField.hashCode ^
      listIntField2.hashCode ^
      listIntField3.hashCode ^
      listIntField4.hashCode ^
      listDoubleField.hashCode ^
      listDoubleField2.hashCode ^
      listDoubleField3.hashCode ^
      listDoubleField4.hashCode ^
      setField.hashCode ^
      setField2.hashCode ^
      mapField.hashCode ^
      mapField2.hashCode;

  String _toString() {
    return 'TestModel{\n  stringField: $stringField,\n  stringField2: $stringField2,\n  stringField3: $stringField3,\n  stringField4: $stringField4,\n  numField: $numField,\n  numField2: $numField2,\n  numField3: $numField3,\n  numField4: $numField4,\n  intField: $intField,\n  intField2: $intField2,\n  intField3: $intField3,\n  intField4: $intField4,\n  doubleField: $doubleField,\n  doubleField2: $doubleField2,\n  doubleField3: $doubleField3,\n  doubleField4: $doubleField4,\n  boolField: $boolField,\n  boolField2: $boolField2,\n  boolField3: $boolField3,\n  boolField4: $boolField4,\n  listField: $listField,\n  listField2: $listField2,\n  listStringField: $listStringField,\n  listStringField2: $listStringField2,\n  listStringField3: $listStringField3,\n  listStringField4: $listStringField4,\n  listIntField: $listIntField,\n  listIntField2: $listIntField2,\n  listIntField3: $listIntField3,\n  listIntField4: $listIntField4,\n  listDoubleField: $listDoubleField,\n  listDoubleField2: $listDoubleField2,\n  listDoubleField3: $listDoubleField3,\n  listDoubleField4: $listDoubleField4,\n  setField: $setField,\n  setField2: $setField2,\n  mapField: $mapField,\n  mapField2: $mapField2\n}';
  }
}
