import 'dart:async';

import 'package:uuid/uuid.dart';

/// 是否为release版
const bool isRelease = bool.fromEnvironment("dart.vm.product");

/// 获取当前时间的毫秒
int get currentMilliseconds => DateTime.now().millisecondsSinceEpoch;

/// 获取当前时间的微秒
int get currentMicroseconds => DateTime.now().microsecondsSinceEpoch;

/// uuid全局实例对象
const Uuid uuid = Uuid();

/// 生成不带 '-' 符号的uuid字符串
String get uuidStr => uuid.v4().replaceAll('-', '');

/// 延迟指定时间执行函数，单位：毫秒
Timer setTimeout(void Function() fun, int wait) {
  assert(wait >= 0);
  return Timer(Duration(milliseconds: wait), fun);
}

/// 每隔一段时间执行函数，单位：毫秒
Timer setInterval(void Function() fun, int wait) {
  assert(wait >= 0);
  return Timer.periodic(Duration(milliseconds: wait), (e) {
    fun();
  });
}
