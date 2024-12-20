import 'dart:convert';

import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/foundation.dart';

import './src/web.dart' if (dart.library.io) './src/io.dart';

ElStorage? _localStorage;

/// 本地存储对象，你也可以通过 [ElStorage] 创建多个隔离的存储对象
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

/// 本地存储抽象类，在 Web 平台上使用 localStorage 进行存储，在客户端上则创建一个普通文件进行序列化存储。
///
/// 注意：浏览器所支持存储的数据量最多只有 5M，虽然在客户端上没有限制，但数据量太大会严重影响性能，
/// 因为每个 Storage 对象实际上就是一个 Map 集合，对 Map 集合做的任何修改都会全量将数据写入到文件中。
abstract class ElStorage {
  ElStorage(this.key, this.mapData, this.serializePreset) {
    _debounceSerialize = DartUtil.debounce(serialize, 1000);
  }

  /// 用于区分多个存储对象
  @protected
  final String key;

  /// 本地存储 Map 对象。
  ///
  /// 提示：value 如果是对象，你需要通过 [jsonEncode] 进行编码，否则序列化的时候底层会抛出异常。
  @protected
  final Map<String, dynamic> mapData;

  /// 内置的序列化预设对象，当你使用 [setItem] 存储非基本数据类型时，会寻找内置的序列化函数，例如：
  /// * Color -> ElColorSerialize
  /// * MaterialColor -> ElMaterialElColorSerialize
  /// * DateTime -> ElDateTimeSerialize
  /// * Size -> ElSizeSerialize
  /// * Offset -> ElOffsetSerialize
  ///
  /// 如果没有找到内置的序列化函数，那么你必须手动指定对应的序列化对象，否则数据无法存储于本地。
  final ElSerializePreset serializePreset;

  /// 本地序列化
  @protected
  void serialize();

  /// 对序列化进行防抖处理，避免频繁序列化操作
  late VoidCallback _debounceSerialize;

  /// 存储的 key 数量
  int get length => mapData.length;

  /// 设置数据
  void setItem<T>(String key, T value, [ElSerialize? serialize]) {
    final result = serializePreset.apply<T>(serialize);
    mapData[key] = result == null ? value : result.serialize(value);
    try {
      _debounceSerialize();
    } catch (error) {
      e(error, '存储库 $key 进行持久化失败');
      e(mapData, '持久化失败的数据结构如下');
    }
  }

  /// 获取数据
  T? getItem<T>(String key, [ElSerialize? serialize]) {
    final result = serializePreset.apply<T>(serialize);
    return result == null ? mapData[key] : result.deserialize(mapData[key]);
  }

  /// 删除数据
  void removeItem(String key) {
    mapData.remove(key);
    _debounceSerialize();
  }

  /// 清空数据
  void clear() {
    mapData.clear();
    _debounceSerialize();
  }

  /// 创建 localStorage 对象，你可以指定 key 创建多个存储对象
  static Future<ElStorage> createLocalStorage([
    String? key,
    ElSerializePreset serializePreset = const ElSerializePreset(),
  ]) async {
    if (key == null) {
      _localStorage ??=
          await $createStorage('element_storage', false, serializePreset);
      return _localStorage!;
    } else {
      return await $createStorage(key, false, serializePreset);
    }
  }

  /// 创建 sessionStorage 对象，你可以指定 key 创建多个存储对象
  static Future<ElStorage> createSessionStorage([
    String? key,
    ElSerializePreset serializePreset = const ElSerializePreset(),
  ]) async {
    if (key == null) {
      _sessionStorage ??=
          await $createStorage('element_storage', true, serializePreset);
      return _sessionStorage!;
    } else {
      return await $createStorage(key, true, serializePreset);
    }
  }
}
