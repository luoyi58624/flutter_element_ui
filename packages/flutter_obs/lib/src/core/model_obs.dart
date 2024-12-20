import 'dart:convert';

import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/foundation.dart';

import 'local_obs.dart';

class ModelObs<T extends ElSerializeModel> extends LocalObs<T> {
  /// ModelObs 适合数据模型类，对象只需要实现 [ElSerializeModel] 接口即可进行持久化，
  /// 数据模型类通常使用代码生成器自动生成 fromJson、toJson 方法。
  ///
  /// 提示：[LocalObs] 是没有办法
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
    LocalObs.storage.setItem(cacheKey!, jsonEncode(value.toJson()));
  }

  @protected
  @override
  dynamic getLocalValue() {
    if (cacheKey == null) return;
    final result = LocalObs.storage.getItem(cacheKey!);
    return result == null ? null : getValue().fromJson(jsonDecode(result));
  }
}
