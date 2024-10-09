
import 'package:flutter_element_dart/flutter_element_dart.dart';
import 'package:test/test.dart';

void main() {
  group('DartUtil', () {
    test('onlyOneNotNull', () {
      expect(DartUtil.onlyOneNotNull(['x', null]), isTrue);
      expect(DartUtil.onlyOneNotNull(['x', null, 1]), isFalse);
      expect(DartUtil.onlyOneNotNull([null, null]), isFalse);
      expect(DartUtil.onlyOneNotNull([null, null, 1]), isTrue);
      expect(DartUtil.onlyOneNotNull([null, null, null]), isFalse);
      expect(DartUtil.onlyOneNotNull([null, null, null], allowAllNull: true),
          isTrue);
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

  group('DartFunExtension', () {
    test('throttle', () {
      i('==========开始=========');
      void hello() {
        i('hello');
      }

      hello.throttle(2000)();
    });
  });
}
