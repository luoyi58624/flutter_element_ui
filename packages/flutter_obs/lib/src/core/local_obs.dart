import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:element_storage/element_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_obs/flutter_obs.dart';

ElStorage? _storage;

class LocalObs<T> extends WatchObs<T> {
  /// 支持本地缓存的响应式变量，如果是局部变量，请记得在 dispose 生命周期中销毁它，或者你可以使用 [useLocalObs] hook
  LocalObs(
    super.value, {
    this.cacheKey,
    this.serialize,
    super.watch,
    super.immediate,
  }) {
    final result = getLocalValue();
    if (result != null) super.setValue(result);
    super.addListener(setLocalValue);
  }

  /// 缓存 key，请保证唯一
  String? cacheKey;

  /// 对象序列化接口，如果 [value] 不是基本数据类型，那么你必须指定序列化实现类，否则本地存储将抛出异常，
  /// 序列化实现类请参考：[ElDateTimeSerialize]、[ElColorSerialize]
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
