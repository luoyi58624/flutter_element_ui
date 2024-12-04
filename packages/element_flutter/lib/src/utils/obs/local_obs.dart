import 'dart:ui';

import 'package:element_annotation/element_annotation.dart';
import 'package:element_dart/element_dart.dart';
import 'package:element_flutter/element_flutter.dart';
import 'package:flutter_obs/flutter_obs.dart';

class LocalObs<T> extends Obs<T> {
  /// 支持本地缓存的响应式变量，它基于 shared_preferences 第三库实现持久化
  LocalObs(
    super.value, {
    required this.cacheKey,
    this.expire,
    this.serialize,
    super.watch,
    super.immediate,
  }) {
    final result = _getLocalValue();
    if (result != null) super.setValue(result);
    final fun = FlutterUtil.debounce(setLocalValue, 1000);
    super.addListener(() => fun());
  }

  /// 缓存 key，请保证唯一
  final String cacheKey;

  /// 缓存过期时间，单位毫秒，如果大于 0，则表示存在过期时间
  final int? expire;

  /// 对象序列化接口，如果 [value] 不是基本数据类型，那么你必须指定序列化实现类，例如：
  /// [ElDateTimeSerialize]、[ElColorSerialize]
  final ElSerialize? serialize;

  void setLocalValue() {
    final value = getValue();
    if (value is String) {
      sp.setString(cacheKey, value);
    } else if (value is int) {
      sp.setInt(cacheKey, value);
    } else if (value is double) {
      sp.setDouble(cacheKey, value);
    } else if (value is bool) {
      sp.setBool(cacheKey, value);
    } else if (value is List<String>) {
      sp.setStringList(cacheKey, value);
    } else {
      final str = serialize!.serialize(value);
      if (str != null) {
        sp.setString(cacheKey, str);
      } else {
        w('LocalObs 自定义序列化得到的结果为 null，无法进行持久化，\n '
            '参数类型: ${T.toString()}\n'
            '序列化: ${serialize!.toString()}');
      }
    }
  }

  dynamic _getLocalValue() {
    final value = getValue();
    if (value is String) {
      return sp.getString(cacheKey);
    } else if (value is int) {
      return sp.getInt(cacheKey);
    } else if (value is double) {
      return sp.getDouble(cacheKey);
    } else if (value is bool) {
      return sp.getBool(cacheKey);
    } else if (value is List<String>) {
      return sp.getStringList(cacheKey);
    } else {
      assert(serialize != null,
          'LocalObs 不支持 ${T.toString()} 类型的序列化，请指定 serialize 参数');
      return serialize!.deserialize(sp.getString(cacheKey));
    }
  }
}
