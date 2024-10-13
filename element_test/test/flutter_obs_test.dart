import 'package:flutter_test/flutter_test.dart';

import 'flutter_obs/base_obs_test.dart';
import 'flutter_obs/memory_leak_test.dart';
import 'flutter_obs/simple_test.dart';
import 'flutter_obs/watch_test.dart';

void flutterObsTest(){
  group('flutter_obs 测试', () {
    baseObsTest(); // Obs 父类测试
    simpleTest(); // 简单状态测试
    memoryLeakTest(); // 内存泄漏测试
    watchTest(); // 监听测试
  });
}
