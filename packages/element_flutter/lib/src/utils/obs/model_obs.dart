import 'dart:convert';

import 'package:element_annotation/element_annotation.dart';
import 'package:element_flutter/element_flutter.dart';

class ModelObs<T extends ElSerializeModel> extends LocalObs<T> {
  /// 支持本地缓存的响应式变量，它基于 shared_preferences 实现持久化，
  /// 如果是局部变量，请记得在 dispose 生命周期中销毁它
  ModelObs(
    super.value, {
    super.cacheKey,
    super.watch,
    super.immediate,
  });

  @override
  void setLocalValue() {
    if (cacheKey == null) return;
    final value = getValue();
    sp.setString(cacheKey!, jsonEncode(value.toJson()));
  }

  @override
  dynamic getLocalValue() {
    if (cacheKey == null) return;
    final result = sp.getString(cacheKey!);
    return result == null ? null : getValue().fromJson(jsonDecode(result));
  }
}
