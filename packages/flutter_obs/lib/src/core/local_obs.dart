import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_obs/flutter_obs.dart';

ElStorage? _storage;

class LocalObs<T> extends WatchObs<T> {
  /// 支持本地缓存的响应式变量
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
    storage.setItem(cacheKey!, getValue(), serialize);
  }

  @protected
  dynamic getLocalValue() {
    if (cacheKey == null) return null;
    final result = storage.getItem<T>(cacheKey!, serialize);
    if (result == null) return null;
    try {
      if (value is List) {
        return DartUtil.dynamicToList<T>(result);
      } else if (value is Set) {
        return DartUtil.dynamicToSet<T>(result);
      } else if (value is Map) {
        return DartUtil.dynamicToMap<T>(result);
      }
      return result;
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

  /// 初始化保存响应式变量的本地存储对象
  static Future<void> initStorage([
    ElSerializePreset serializePreset = const ElSerializePreset(),
  ]) async {
    _storage ??= await ElStorage.createLocalStorage(
      'flutter_obs',
      serializePreset,
    );
  }
}
