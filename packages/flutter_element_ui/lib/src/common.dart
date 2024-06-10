import 'package:flutter/widgets.dart';

/// 根节点导航key，如果你使用[ElLoading]
/// ```dart
/// MaterialApp(
///   navigatorKey: rootNavigatorKey,
/// );
/// ```
GlobalKey<NavigatorState> elRootNavigatorKey = GlobalKey<NavigatorState>();

/// 根节点context
BuildContext get elRootContext {
  assert(elRootNavigatorKey.currentWidget != null, 'Please configured rootNavigatorKey before use elRootContext');
  assert(elRootNavigatorKey.currentWidget is Navigator,
      'Whether you right configured rootNavigatorKey? rootNavigatorKey not Navigator!');
  return elRootNavigatorKey.currentContext!;
}
