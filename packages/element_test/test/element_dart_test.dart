import 'package:element_dart/element_dart.dart';
import 'package:flutter_test/flutter_test.dart';

import 'element_dart/reg/html.dart';

void elementDartTest() {
  group('DartUtil', () {
    test('onlyOneNotNull', () {
      expect(DartUtil.listOnlyOne(['x', null]), isTrue);
      expect(DartUtil.listOnlyOne(['x', null, 1]), isFalse);
      expect(DartUtil.listOnlyOne([null, null], allowAllNull: false), isFalse);
      expect(DartUtil.listOnlyOne([null, null, 1]), isTrue);
      expect(DartUtil.listOnlyOne([null, null, null], allowAllNull: false),
          isFalse);
      expect(DartUtil.listOnlyOne([null, null, null]), isTrue);
    });
  });

  group('DartMapExtension', () {
    test('filter', () {
      final map = {'name': 'hihi', 'age': 20};
      final newMap = map.filter((k, v) => v is int);
      expect(newMap, {'age': 20});
    });
    test('filterFromKeys', () {
      final map = {'name': 'hihi', 'age': 20, 'money': 1000};
      final newMap = map.filterFromKeys(['age', 'money']);
      expect(newMap, {'age': 20, 'money': 1000});
    });
    test('autoCast', () {
      Map map = {'name': 'hihi', 'age': 20};
      Map<String, dynamic> castMap = map.autoCast();
      expect(map.runtimeType.toString(), '_Map<dynamic, dynamic>');
      expect(castMap.runtimeType.toString(), '_Map<String, Object>');

      Map map2 = {'name': 'hihi', 'age': 20, 'demo': null};
      Map castMap2 = map2.autoCast();
      expect(map2.runtimeType.toString(), '_Map<dynamic, dynamic>');
      expect(castMap2.runtimeType.toString(), '_Map<String, dynamic>');
    });
  });

  group('DartStringExtension', () {
    test('excludeGeneric', () {
      expect('List<E>'.excludeGeneric, 'List');
      expect('UserModel<T>?'.excludeGeneric, 'UserModel');
    });

    test('getGenericType', () {
      expect('List<E>'.getGenericType, 'E');
      expect('UserModel<T>?'.getGenericType, 'T');
    });
  });

  group('正则测试', () {
    test('提取 html 标签中的字符', () {
      htmlRegTest();
    });
  });
}
