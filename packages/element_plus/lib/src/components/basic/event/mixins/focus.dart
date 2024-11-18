import 'package:flutter_obs/flutter_obs.dart';

import '../index.dart';
import 'common.dart';

mixin FocusMixin<T extends ElEvent> on CommonMixin<T> {
  bool hasFocusDepend = false;

  final _isFocus = BaseObs(false);

  bool get isFocus => _isFocus.value;

  set isFocus(bool value) {
    if (hasFocusDepend) _isFocus.value = value;
  }

  void setFocusDepend() {
    hasFocusDepend = true;
  }
}
