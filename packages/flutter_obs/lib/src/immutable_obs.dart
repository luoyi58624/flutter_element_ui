import 'package:flutter/cupertino.dart';

import 'obs.dart';

class ImmutableObs<T> extends Obs<T> {
  /// 必须传递不可变对象的响应式变量，它隐藏了 [notify] 方法，强制用户必须通过 .value 更新变量
  ImmutableObs(super.value);

  @protected
  @override
  void notify() {
    super.notify();
  }
}
