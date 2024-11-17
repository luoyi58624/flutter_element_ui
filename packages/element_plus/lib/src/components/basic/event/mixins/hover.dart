import 'package:element_extension/element_extension.dart';
import 'package:flutter/services.dart';
import 'package:flutter_obs/flutter_obs.dart';

import '../index.dart';
import 'common.dart';

mixin HoverMixin<T extends ElEvent> on CommonMixin<T> {
  /// 是否存在悬停状态依赖
  bool hasHoverDepend = false;

  final _isHover = BaseObs(false);

  /// 悬停状态响应式变量，此属性会注入到 InheritedWidget 小部件
  bool get isHover => _isHover.value;

  set isHover(bool value) {
    if (hasHoverDepend) _isHover.value = value;
  }

  void setHoverDepend() {
    if (PlatformUtil.isDesktop) {
      hasHoverDepend = true;
    }
  }

  /// 鼠标进入目标区域事件
  void onEnter(PointerEnterEvent e) {
    isHover = true;
    prop.onEnter?.call(e);
  }

  /// 鼠标离开目标区域事件
  void onExit(PointerExitEvent e) {
    isHover = false;
    prop.onExit?.call(e);
  }
}
