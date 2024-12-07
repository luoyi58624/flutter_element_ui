import 'package:flutter/foundation.dart';

import 'obs.dart';

class ImmutableObs<T> extends Obs<T> {
  /// 不允许用户通过 [notify] 方法更新 UI 的响应式变量，它强制用户必须通过 .value 更新变量
  ImmutableObs(super.value);

  @protected
  @override
  void notify() {
    super.notify();
  }
}
