import 'package:element_annotation/element_annotation.dart';
import 'package:element_flutter/element_flutter.dart';
import 'package:element_storage/element_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_obs/flutter_obs.dart';

ElStorage? _storage;

class LocalObs<T> extends WatchObs<T> {
  /// 支持本地缓存的响应式变量
  LocalObs(
    super.value, {
    this.cacheKey,
    ElSerialize? serialize,
    super.watch,
    super.immediate,
  }) {
    if (serialize != null) {
      this.serialize = serialize;
    } else {
      this.serialize = _loadPresetSerialize<T>();
    }
    final result = getLocalValue();
    if (result != null) super.setValue(result);
    super.addListener(setLocalValue);
  }

  /// 缓存 key，请保证唯一
  String? cacheKey;

  /// 对象序列化接口，如果 [value] 不是基本数据类型，你需要定义序列化和反序列化函数，
  /// 否则持久化时会抛出异常。
  ElSerialize? serialize;

  @override
  void reset() {
    setValue(initialValue);
    notifyBuilders();
    if (cacheKey != null) storage.removeItem(cacheKey!);
  }

  @protected
  void setLocalValue() {
    if (cacheKey == null) return;

    final value = getValue();
    if (serialize != null) {
      storage.setItem(cacheKey!, serialize!.serialize(value));
    } else {
      storage.setItem(cacheKey!, value);
    }
  }

  @protected
  dynamic getLocalValue() {
    if (cacheKey == null) return null;
    final result = storage.getItem(cacheKey!);
    if (result == null) return null;
    try {
      if (serialize != null) {
        return serialize!.deserialize(result);
      } else {
        if (value is List) {
          return DartUtil.dynamicToList<T>(result);
        } else if (value is Set) {
          return DartUtil.dynamicToSet<T>(result);
        } else if (value is Map) {
          return DartUtil.dynamicToMap<T>(result);
        }
        return result;
      }
    } catch (e) {
      w('LocalObs 类型转换失败，出现这个警告表示你可能更改了数据结构，LocalObs 将会删除旧数据返回默认值。');
      storage.removeItem(cacheKey!);
      return value;
    }
  }

  /// 访问 [LocalObs] 专属本地存储对象
  static ElStorage get storage {
    assert(
        _storage != null, 'LocalObs 本地存储对象还未初始化，请执行 LocalObs.initStorage 方法');
    return _storage!;
  }

  /// 初始化 [LocalObs] 专属存储对象
  static Future<void> initStorage() async {
    _storage ??= await ElStorage.createLocalStorage('flutter_obs');
  }
}

/// 加载内部预设的序列化函数
ElSerialize? _loadPresetSerialize<T>() {
  final type = T.toString();
  if (type == 'dynamic' || type == 'null') return null;
  if (type == 'Color') return const ColorSerialize();
  if (type == 'MaterialColor') return const MaterialColorSerialize();
  if (type == 'DateTime') return const DateTimeSerialize();
  return null;
}
