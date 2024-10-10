import 'dart:convert';
import 'package:flutter_element_dart/flutter_element_dart.dart';
import 'package:test/test.dart';

import 'models/json_serializable.dart';
import 'models/test.dart';
import 'models/user.dart';

void main() {
  group('modal builder 测试', () {
    test('element json 序列化测试', () {
      String json =
          '{"custom_string": "10.0", "stringField2": 10.0, "stringField3": 10, "stringField4": false, '
          '"num_field": "10", "num_field2": 10, "numField3": 10.0, "numField4": true,'
          '"int_field": "10.0", "intField4": true,'
          '"double_field": "10", "doubleField2": 10, "doubleField4": true,'
          '"bool_field": "true", "boolField3": 10, "custom_bool": false,'
          '"list_field": ["luoyi", 100.0, "20", 50, ["xx"]],'
          '"map_field": {"name":"luoyi"},'
          '"user_model": {"username":"hihi", "age":"50"}'
          '}';


      final model = TestModel.fromJson(jsonDecode(json));
      expect(model.stringField, "10.0");
      expect(model.stringField2, "10.0");
      expect(model.stringField3, "10");
      expect(model.stringField4, "false");
      expect(model.numField, 10);
      expect(model.numField2, 10);
      expect(model.numField3, 10.0);
      expect(model.numField4, 10);
      expect(model.intField, 10);
      expect(model.intField2, null);
      expect(model.intField3, 10);
      expect(model.intField4, 20);
      expect(model.doubleField, 10.0);
      expect(model.doubleField2, 10.0);
      expect(model.doubleField3, 10.0);
      expect(model.doubleField4, 10.0);
      expect(model.boolField, true);
      expect(model.boolField2, null);
      expect(model.boolField3, true);
      expect(model.boolField4, false);
      expect(model.listField, [
        "luoyi",
        100.0,
        "20",
        50,
        ["xx"]
      ]);
      expect(model.listField2, [1, 'hello', false]);
      expect(model.mapField, {'name': 'luoyi'});
      expect(model.mapField2, {
        'name': 'hihi',
        'child': {'age': 20}
      });
      // model.copyWith(userModel: UserModel(username: 'luoyi', age: 26));
      final newJson = model.toJson();
      print(model.toString());
      print(newJson);
      // final model3 = model.fromJson(newJson);
      // print(model3);
    });

    test('json_serializable 序列化测试', () {
      String json = '{"firstName": "luo", "lastName": "yi","doubleField": 0.0,'
          '"listField": ["luoyi", "xx"],'
          '"son": {"name": "hihi"}'
          '}';

      final model = Person.fromJson(jsonDecode(json));

      print(model.son?.name);

      String json2 =
          '{"firstName": "luo", "lastName": "yi", "doubleField": 0.0}';

      final model2 = Person.fromJson(jsonDecode(json2));

      print(model2.listField);
    });
  });
}
