import 'dart:convert';

import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'element_generates/models/class_extended.dart';
import 'element_generates/models/test.dart';

void elementGeneratesTest() {
  group('序列化测试', () {
    // 这是一个比较复杂的实体模型测试，序列化 json 的数据包含各种类型数据（字符串、数字、布尔、数组、实体对象、颜色），
    // 这个测试的目标是让生成的 formJson 能够尽可能地正确转换数据，避免常见的类型转换错误，
    // 例如 dart 常见的低级类型转换错误：int -> String，String -> int
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
      expect(TestModel.fromJson(model.toJson()), model);
      final model2 = model.copyWith(materialColor: Colors.red);
      final model3 = model.copyWith(materialColor: Colors.red);
      expect(model2, model3); // 测试重写 equals 是否正常工作
    });
  });

  test('继承 Model 比较方法 equals 测试', () {
    ChildModel child1 = ChildModel(childName: 'child');
    ChildModel child2 = ChildModel(childName: 'child');
    expect(child1, child2);

    // 继承的父类属性如果相等，那么对象也将相等
    ChildModel child3 = ChildModel(childName: 'child', parentName: 'parent');
    ChildModel child4 = ChildModel(childName: 'child', parentName: 'parent');
    expect(child3 == child4, isTrue);

    // 继承的父类属性如果不相等，那么对象也将不相等
    ChildModel child5 = ChildModel(childName: 'child', parentName: 'parent1');
    ChildModel child6 = ChildModel(childName: 'child', parentName: 'parent2');
    expect(child5 == child6, isFalse);
  });
}
