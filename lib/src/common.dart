import 'package:flutter/material.dart';

/// 根节点导航key，此变量不对外开放，请通过[ElTheme]传递navigatorKey，会直接赋值到elRootNavigatorKey
late GlobalKey<NavigatorState>? elRootNavigatorKey;

/// 根节点context
BuildContext get elRootContext {
  assert(elRootNavigatorKey != null, 'Please set navigatorKey in the ElTheme');
  assert(elRootNavigatorKey!.currentWidget != null,
      'Please configured elRootNavigatorKey before use elRootContext');
  assert(elRootNavigatorKey!.currentWidget is Navigator,
      'Whether you right configured elRootNavigatorKey? elRootNavigatorKey not Navigator!');
  return elRootNavigatorKey!.currentContext!;
}
