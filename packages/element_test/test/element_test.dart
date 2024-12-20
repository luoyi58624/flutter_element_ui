import 'package:flutter_test/flutter_test.dart';

import 'dart_serialize_test.dart';
import 'element_dart_test.dart';
import 'element_flutter_test.dart';
import 'element_generates_test.dart';
import 'flutter_obs/memory_leak_test.dart';
import 'flutter_obs/simple_test.dart';
import 'flutter_obs/watch_test.dart';

void main() {
  dartSerializeTest();
  elementDartTest();
  elementGeneratesTest();

  group('element_flutter 测试', () {
    colorTest();
  });

  group('flutter_obs 测试', () {
    simpleTest(); // 简单状态测试
    memoryLeakTest(); // 内存泄漏测试
    watchTest(); // 监听测试
  });
}
