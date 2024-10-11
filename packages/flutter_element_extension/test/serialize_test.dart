import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:test/test.dart';

import 'models/test.dart';

void serializeTest() {
  group('序列化测试', () {
    test('TestModel 基础测试', () {
      String json =
          '{"custom_string": "10.0", "stringField2": 10.0, "stringField3": 10, "stringField4": false, '
          '"num_field": "10", "num_field2": 10, "numField3": 10.0, "numField4": true,'
          '"int_field": "10.0", "intField4": true,'
          '"double_field": "10", "doubleField2": 10, "doubleField4": true,'
          '"bool_field": "true", "boolField3": 10, "custom_bool": false,'
          '"list_field": ["luoyi", 100.0, "20", 50, ["xx"]],'
          '"map_field": {"name":"luoyi"},'
          '"user_model": {"username":"hihi", "age":"50"},'
          '"color": "#F8F8FF"'
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
      // 测试 equals 是否工作正常，重新序列化、反序列化对象判断是否相等
      // 注意：对于像 Color 这样需要自己配置序列化类型的数据，equals 无法对它们进行比较
      expect(TestModel.fromJson(model.toJson()), model);

      // 测试颜色序列化注解是否工作正常
      final model2 = model.copyWith(materialColor: Colors.red);
      expect(
        $testModel.fromJson(model2.toJson()).materialColor?.toHex(),
        Colors.red.toHex(),
      );
    });
  });
}
