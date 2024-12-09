import 'dart:convert';

import 'package:element_annotation/element_annotation.dart';
import 'package:element_storage/element_storage.dart';
import 'package:flutter/foundation.dart';

import 'local_obs.dart';

class ModelObs<T extends ElSerializeModel> extends LocalObs<T> {
  /// 继承自 [LocalObs]，[value] 只需要实现 [ElSerializeModel] 接口即可进行持久化
  ModelObs(
    super.value, {
    super.cacheKey,
    super.watch,
    super.immediate,
  });

  @protected
  @override
  void setLocalValue() {
    if (cacheKey == null) return;
    final value = getValue();
    localStorage.setItem(cacheKey!, jsonEncode(value.toJson()));
  }

  @protected
  @override
  dynamic getLocalValue() {
    if (cacheKey == null) return;
    final result = localStorage.getItem(cacheKey!);
    return result == null ? null : getValue().fromJson(jsonDecode(result));
  }
}
