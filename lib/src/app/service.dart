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

  /// 控制应用的全局光标 [_ElGlobalCursor]，它由 [ElApp] 注入，层级虽然很高，
  /// 但重建光标状态时子组件不会触发 build，所以不会造成性能问题
  final _cursor = Obs(MouseCursor.defer);

  /// 锁定全局光标 key，防止其他 Hover 篡改
  String? _cursorKey;

  /// 设置全局光标，设置 key 可以限制其他元素触发悬停状态，例如在拖动滚动条、
  /// 拖拽元素尺寸时禁止鼠标触发按钮等元素的悬停样式，注意：只能限制 [ElHover] 构建的小部件。
  ///
  /// 函数返回一个布尔值，若为 true 表示悬停状态允许触发，否则表示当前悬停被其他元素占用。
  bool setCursor([MouseCursor? cursor, String? key]) {
    if (key != null) _cursorKey ??= key;
    if (_cursorKey == key) {
      if (cursor != null) _cursor.value = cursor;
      return true;
    } else {
      return false;
    }
  }

  /// 重置全局光标
  bool resetCursor([String? key]) {
    if (_cursorKey == key) {
      _cursor.value = MouseCursor.defer;
      _cursorKey = null;
      return true;
    } else {
      return false;
    }
  }
}
