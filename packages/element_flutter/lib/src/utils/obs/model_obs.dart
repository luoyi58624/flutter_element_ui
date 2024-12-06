import 'dart:convert';

import 'package:element_annotation/element_annotation.dart';
import 'package:element_flutter/element_flutter.dart';

class ModelObs<T extends SerializeModel> extends LocalObs<T> {
  /// 继承自 [LocalObs]，[value] 只需要实现 [SerializeModel] 接口即可进行持久化
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
