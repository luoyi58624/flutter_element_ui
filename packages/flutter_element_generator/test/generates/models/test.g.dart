// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/test.dart';

// **************************************************************************
// ElModelGenerator
// **************************************************************************

TestModel $testModel = TestModel(
  stringField: '',
  stringField3: 'stringField3',
  stringField4: 'stringField4',
  numField: 0.0,
  numField3: 100.0,
  numField4: 88,
  intField: 0,
  intField3: 20,
  intField4: 300,
  doubleField: 0.0,
  doubleField3: 60.0,
  doubleField4: 800.0,
  boolField: false,
  boolField3: true,
  boolField4: true,
  listStringField: [],
  listStringField3: [],
  numList: [],
  myMap: {},
);

TestModel _fromJson(Map<String, dynamic>? json) {
  if (json == null) return $testModel;
  return TestModel(
    stringField:
        ((json['stringField'] ?? json['string_field']) ?? '').toString(),
    stringField2: (json['stringField2'] ?? json['string_field2'])?.toString(),
    stringField3:
        ((json['stringField3'] ?? json['string_field3']) ?? 'stringField3')
            .toString(),
    stringField4: (json['stringField4'] ?? json['string_field4'])?.toString() ??
        'stringField4',
    numField:
        num.tryParse((json['numField'] ?? json['num_field']).toString()) ?? 0.0,
    numField2:
        num.tryParse((json['numField2'] ?? json['num_field2']).toString()),
    numField3: num.tryParse(
            ((json['numField3'] ?? json['num_field3']) ?? 100.0).toString()) ??
        0.0,
    numField4: num.tryParse(
        ((json['numField4'] ?? json['num_field4']) ?? 88).toString()),
    intField:
        int.tryParse((json['intField'] ?? json['int_field']).toString()) ?? 0,
    intField2:
        int.tryParse((json['intField2'] ?? json['int_field2']).toString()),
    intField3: int.tryParse(
            ((json['intField3'] ?? json['int_field3']) ?? 20).toString()) ??
        0,
    intField4: int.tryParse(
        ((json['intField4'] ?? json['int_field4']) ?? 300).toString()),
    doubleField: double.tryParse(
            (json['doubleField'] ?? json['double_field']).toString()) ??
        0.0,
    doubleField2: double.tryParse(
        (json['doubleField2'] ?? json['double_field2']).toString()),
    doubleField3: double.tryParse(
            ((json['doubleField3'] ?? json['double_field3']) ?? 60.0)
                .toString()) ??
        0.0,
    doubleField4: double.tryParse(
        ((json['doubleField4'] ?? json['double_field4']) ?? 800.0).toString()),
    boolField:
        bool.tryParse((json['boolField'] ?? json['bool_field']).toString()) ??
            false,
    boolField2:
        bool.tryParse((json['boolField2'] ?? json['bool_field2']).toString()),
    boolField3: bool.tryParse(
            ((json['boolField3'] ?? json['bool_field3']) ?? true).toString()) ??
        false,
    boolField4: bool.tryParse(
        ((json['boolField4'] ?? json['bool_field4']) ?? true).toString()),
    listStringField: $ElGeneratesUtil.safeList<String>(
            (json['listStringField'] ?? json['list_string_field']),
            'TestModel',
            'listStringField') ??
        [],
    listStringField2: $ElGeneratesUtil.safeList<String>(
        (json['listStringField2'] ?? json['list_string_field2']),
        'TestModel',
        'listStringField2'),
    listStringField3: $ElGeneratesUtil.safeList<String>(
            (json['listStringField3'] ?? json['list_string_field3']),
            'TestModel',
            'listStringField3') ??
        [],
    listStringField4: $ElGeneratesUtil.safeList<String>(
        (json['listStringField4'] ?? json['list_string_field4']),
        'TestModel',
        'listStringField4'),
    myList: $ElGeneratesUtil.safeList<dynamic>(
        (json['myList'] ?? json['my_list']), 'TestModel', 'myList'),
    numList: $ElGeneratesUtil.safeList<num>(
            (json['numList'] ?? json['num_list']), 'TestModel', 'numList') ??
        [],
    myMap: $ElGeneratesUtil.safeMap<dynamic>(
            (json['myMap'] ?? json['my_map']), 'TestModel', 'myMap') ??
        {},
    userModel: (json['userModel'] ?? json['user_model']),
  );
}

extension TestModelExtension on TestModel {
  Map<String, dynamic> _toJson() {
    return {
      'string_field': stringField,
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
      'bool_field4': boolField4,
      'list_string_field': listStringField,
      'list_string_field2': listStringField2,
      'list_string_field3': listStringField3,
      'list_string_field4': listStringField4,
      'my_list': myList,
      'num_list': numList,
      'my_map': myMap,
      'user_model': userModel,
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
    List<String>? listStringField,
    List<String>? listStringField2,
    List<String>? listStringField3,
    List<String>? listStringField4,
    List<dynamic>? myList,
    List<num>? numList,
    Map<String, dynamic>? myMap,
    UserModel? userModel,
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
      listStringField: listStringField ?? this.listStringField,
      listStringField2: listStringField2 ?? this.listStringField2,
      listStringField3: listStringField3 ?? this.listStringField3,
      listStringField4: listStringField4 ?? this.listStringField4,
      myList: myList ?? this.myList,
      numList: numList ?? this.numList,
      myMap: myMap ?? this.myMap,
      userModel: this.userModel?.merge(userModel),
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
      listStringField: other.listStringField,
      listStringField2: other.listStringField2,
      listStringField3: other.listStringField3,
      listStringField4: other.listStringField4,
      myList: other.myList,
      numList: other.numList,
      myMap: other.myMap,
      userModel: userModel?.merge(other.userModel),
    );
  }

  String _toString() {
    return 'TestModel{stringField: $stringField,stringField2: $stringField2,stringField3: $stringField3,stringField4: $stringField4,numField: $numField,numField2: $numField2,numField3: $numField3,numField4: $numField4,intField: $intField,intField2: $intField2,intField3: $intField3,intField4: $intField4,doubleField: $doubleField,doubleField2: $doubleField2,doubleField3: $doubleField3,doubleField4: $doubleField4,boolField: $boolField,boolField2: $boolField2,boolField3: $boolField3,boolField4: $boolField4,listStringField: $listStringField,listStringField2: $listStringField2,listStringField3: $listStringField3,listStringField4: $listStringField4,myList: $myList,numList: $numList,myMap: $myMap,userModel: $userModel}';
  }
}
