import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_obs/flutter_obs.dart';
import 'package:shared_preferences/shared_preferences.dart';

SharedPreferences? _sp;

class LocalObs<T> extends WatchObs<T> {
  /// 支持本地缓存的响应式变量，它基于 shared_preferences 实现持久化，
  /// 如果是局部变量，请记得在 dispose 生命周期中销毁它
  LocalObs(
    super.value, {
    this.cacheKey,
    this.serialize,
    super.watch,
    super.immediate,
  }) {
    final result = getLocalValue();
    if (result != null) super.setValue(result);

    // 对持久化操作进行防抖处理，防止在频繁更新响应式变量时触发缓存操作
    super.addListener(DartUtil.debounce(setLocalValue, 1000));
  }

  /// 缓存 key，请保证唯一
  String? cacheKey;

  /// 对象序列化接口，如果 [value] 不是基本数据类型，那么你必须指定序列化实现类，请参考：
  /// [ElDateTimeSerialize]、[ElColorSerialize]
  ElSerialize? serialize;

  @override
  void reset() {
    setValue(initialValue);
    notifyBuilders();
    if (cacheKey != null) sp.remove(cacheKey!);
  }

  @protected
  void setLocalValue() {
    if (cacheKey == null) return;
    final value = getValue();
    if (value is String) {
      sp.setString(cacheKey!, value);
    } else if (value is int) {
      sp.setInt(cacheKey!, value);
    } else if (value is double) {
      sp.setDouble(cacheKey!, value);
    } else if (value is bool) {
      sp.setBool(cacheKey!, value);
    } else if (value is List<String>) {
      sp.setStringList(cacheKey!, value);
    } else {
      final str = serialize!.serialize(value);
      if (str != null) {
        sp.setString(cacheKey!, str);
      } else {
        w('LocalObs 自定义序列化得到的结果为 null，无法进行持久化，\n '
            '参数类型: ${T.toString()}\n'
            '序列化: ${serialize!.toString()}');
      }
    }
  }

  @protected
  dynamic getLocalValue() {
    if (cacheKey == null) return null;
    final value = getValue();
    if (value is String) {
      return sp.getString(cacheKey!);
    } else if (value is int) {
      return sp.getInt(cacheKey!);
    } else if (value is double) {
      return sp.getDouble(cacheKey!);
    } else if (value is bool) {
      return sp.getBool(cacheKey!);
    } else if (value is List<String>) {
      return sp.getStringList(cacheKey!);
    } else {
      assert(serialize != null,
          'LocalObs 不支持 ${T.toString()} 类型的序列化，请指定 serialize 参数');
      return serialize!.deserialize(sp.getString(cacheKey!));
    }
  }

  /// 初始化本地存储实例
  static Future<void> initStorage([String? key]) async {
    SharedPreferences.setPrefix('${key != null ? "$key." : ""}flutter_obs.');
    _sp = await SharedPreferences.getInstance();
  }

  /// SharedPreferences 本地存储实例
  static SharedPreferences get sp {
    assert(_sp != null,
        'LocalObs 的本地存储 SharedPreferences 实例还未初始化，请在 main 函数中执行 LocalObs.initStorage() 方法');
    return _sp!;
  }
}
