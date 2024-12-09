import 'package:element_dart/element_dart.dart';
import 'package:flutter/foundation.dart';

import './web.dart' if (dart.library.io) './io.dart';

/// 持久化本地存储对象，在执行 El.init 方法后初始化
late final ElStorage localStorage;

/// 本地存储抽象类，Api 设计来自 Web 中的 localStorage，在 Web 平台上直接使用 localStorage Api，
/// 在客户端上则直接创建一个普通文件进行序列化存储，所以你不能用它存储大量数据，也不能用它存储敏感数据。
abstract class ElStorage {
  ElStorage(this.key, this.storage) {
    _debounceSerialize = DartUtil.debounce(serialize, 1000);
  }

  /// 用于区分多个存储对象
  @protected
  final String key;

  @protected
  final Map<String, dynamic> storage;

  /// 本地序列化
  void serialize();

  /// 对序列化进行防抖处理，避免频繁序列化操作
  late VoidCallback _debounceSerialize;

  /// 存储的 key 数量
  int get length => storage.length;

  /// 设置数据
  void setItem(String key, dynamic value) {
    storage[key] = value;
    _debounceSerialize();
  }

  /// 获取数据
  dynamic getItem(String key) => storage[key];

  /// 删除数据
  void removeItem(String key) {
    storage.remove(key);
    _debounceSerialize();
  }

  /// 清空数据
  void clear() {
    storage.clear();
    _debounceSerialize();
  }

  /// 创建本地存储，支持创建多个存储对象
  static Future<ElStorage> createLocalStorage(
      [String key = 'element_plus']) async {
    return await $createLocalStorage(key);
  }
}
