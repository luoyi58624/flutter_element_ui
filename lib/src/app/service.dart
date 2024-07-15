part of '../app.dart';

/// Element UI 全局实例变量
final $el = _ElService();

class _ElService {
  /// 根节点导航key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 根节点路由 context 对象
  BuildContext get context {
    assert(
        navigatorKey.currentWidget != null &&
            navigatorKey.currentWidget is Navigator,
        '请在 WidgetsApp、MaterialApp、CupertinoApp 等任意顶级 App 组件中设置 navigatorKey');
    return navigatorKey.currentContext!;
  }

  /// Element UI 颜色主题类型集合
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// 控制应用的全局光标 [_ElGlobalCursor]。
  final _cursor = Obs(MouseCursor.defer);

  /// 锁定全局光标 key，防止其他 Hover 篡改
  String? _cursorKey;

  /// 设置全局光标
  void setCursor(MouseCursor cursor, [String? key]) {
    if (key != null) _cursorKey ??= key;
    if (_cursorKey == key) _cursor.value = cursor;
  }

  /// 重置全局光标
  void resetCursor([String? key]) {
    if (_cursorKey == key) {
      _cursor.value = MouseCursor.defer;
      _cursorKey = null;
    }
  }
}
