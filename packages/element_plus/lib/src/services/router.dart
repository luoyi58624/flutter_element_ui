import 'package:element_flutter/element_flutter.dart';
import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> _navigatorKey =
    GlobalKey(debugLabel: 'element_navigatorKey');

mixin RouterService {
  /// 全局路由导航key
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  /// Element UI 全局路由导航 context 对象
  BuildContext get context {
    ElAssert.navigatorError();
    return navigatorKey.currentContext!;
  }

  /// 全局 [Overlay] 对象
  OverlayState get overlay {
    ElAssert.navigatorError();
    return navigatorKey.currentState!.overlay!;
  }
}
