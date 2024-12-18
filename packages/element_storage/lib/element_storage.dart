import 'dart:convert';

import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter/foundation.dart';

import './src/web.dart' if (dart.library.io) './src/io.dart';

ElStorage? _localStorage;

/// 默认的持久化本地存储对象，[ElStorage] 支持创建多个隔离的数据对象
ElStorage get localStorage {
  assert(_localStorage != null,
      'localStorage 未初始化，请执行 ElStorage.createLocalStorage 方法');
  return _localStorage!;
}

ElStorage? _sessionStorage;

/// 临时本地存储对象，在 Web 上，sessionStorage 的有效性仅为当前 Tab 页，刷新页面不会清除状态，
/// 关闭、新建 Tab 页状态会清空（不影响之前打开的），在客户端数据会被存储到临时目录，数据什么时候被清除取决于平台，
/// 如果你希望应用退出时就清空 session 中的数据，就自行在生命周期中调用 clean 方法即可。
ElStorage get sessionStorage {
  assert(_sessionStorage != null,
      'sessionStorage 未初始化，请执行 ElStorage.createSessionStorage 方法');
  return _sessionStorage!;
}

/// 本地存储抽象类，Api 设计来自 Web 中的 localStorage，在 Web 平台上直接使用 localStorage Api，
/// 在客户端上则直接创建一个普通文件进行序列化存储，所以你不能用它存储大量数据。
abstract class ElStorage {
  ElStorage(this.key, this.storage) {
    _debounceSerialize = DartUtil.debounce(serialize, 1000);
  }

  /// 用于区分多个存储对象
  @protected
  final String key;

  /// 本地存储 Map 对象。
  ///
  /// 提示：value 如果是对象，你需要通过 [jsonEncode] 进行编码，否则序列化的时候底层会抛出异常。
  @protected
  final Map<String, dynamic> storage;

  /// 本地序列化
  @protected
  void serialize();

  /// 对序列化进行防抖处理，避免频繁序列化操作
  late VoidCallback _debounceSerialize;

  /// 存储的 key 数量
  int get length => storage.length;

  /// 设置数据
  void setItem(String key, dynamic value, [ElSerialize? serialize]) {
    storage[key] = serialize == null ? value : serialize.serialize(value);
    _debounceSerialize();
  }

  /// 获取数据
  dynamic getItem(String key, [ElSerialize? serialize]) =>
      serialize == null ? storage[key] : serialize.deserialize(storage[key]);

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

  /// 创建 localStorage 对象，你可以指定 key 创建多个存储对象
  static Future<ElStorage> createLocalStorage([String? key]) async {
    if (key == null) {
      _localStorage ??= await $createStorage('element_storage', false);
      return _localStorage!;
    } else {
      return await $createStorage(key, false);
    }
  }

  /// 创建 sessionStorage 对象，你可以指定 key 创建多个存储对象
  static Future<ElStorage> createSessionStorage([String? key]) async {
    if (key == null) {
      _sessionStorage ??= await $createStorage('element_storage', true);
      return _sessionStorage!;
    } else {
      return await $createStorage(key, true);
    }
  }
}
