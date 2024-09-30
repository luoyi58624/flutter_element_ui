import 'dart:convert';
import 'package:test/test.dart';

import 'modals/test.dart';

void main() {
  group('modal builder 测试', () {
    test('json 序列化', () {
      String json = '{"width": 120, "max_width": 600.0, "height": 400.0, '
          '"peoples": ["luoyi", "xx"],"my_list": ["luoyi",10],'
          '"num_list": [10,20,30,40,50.0],"myMap": {"one": 10,"two":"luoyi"}}';

      print(jsonDecode(json)['peoples'].runtimeType);

      final model2 = TestModel.fromJson(jsonDecode(json));

      print(model2.toJson()['peoples']);
      print(model2.toJson()['my_list']);
      print(model2.myMap);
    });
  });
}
