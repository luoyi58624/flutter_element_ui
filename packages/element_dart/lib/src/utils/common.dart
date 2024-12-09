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
