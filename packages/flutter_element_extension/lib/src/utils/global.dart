import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:uuid/uuid.dart';

/// 获取当前时间的毫秒
int get currentMilliseconds => DateTime.now().millisecondsSinceEpoch;

/// 获取当前时间的微秒
int get currentMicroseconds => DateTime.now().microsecondsSinceEpoch;

/// uuid全局实例对象
///
/// ```dart
/// // Generate a v1 (time-based) id
/// uuid.v1(); // -> '6c84fb90-12c4-11e1-840d-7b25c5ee775a'
///
/// // Generate a v4 (random) id
/// uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
///
/// // Generate a v5 (namespace-name-sha1-based) id
/// uuid.v5(Uuid.NAMESPACE_URL, 'www.google.com'); // -> 'c74a196f-f19d-5ea9-bffd-a2742432fc9c'
/// ```
const Uuid uuid = Uuid();

/// 生成不带 '-' 符号的uuid字符串
String get uuidStr => uuid.v4().replaceAll('-', '');

/// 延迟指定时间执行函数，单位：毫秒
///
/// @return [Timer] 手动执行cancel方法可以取消延迟任务
Timer setTimeout(VoidCallback fun, int wait) {
  return Timer(Duration(milliseconds: max(wait, 0)), fun);
}
