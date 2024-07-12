part of '../theme.dart';

/// Element UI 全局实例变量
final $el = _ElService();

/// 根节点导航key，请通过[ElTheme]传递navigatorKey
late GlobalKey<NavigatorState>? _elRootNavigatorKey;

class _ElService {
  /// Element UI 颜色主题类型集合
  final List<String> themeTypes = const [
    'primary',
    'success',
    'info',
    'warning',
    'error'
  ];

  /// 控制应用的全局光标，当注入 [ElTheme] 时，会插入一个顶级 [MouseRegion] 组件。
  ///
  /// 提示：[MouseRegion]的重建不会触发内部的子组件build。
  final cursor = Obs(MouseCursor.defer);

  /// 根节点context，使用前必须在 App 中配置 navigatorKey
  BuildContext get context {
    assert(_elRootNavigatorKey != null, '请在 ElTheme 中设置 navigatorKey');
    assert(
        _elRootNavigatorKey!.currentWidget != null &&
            _elRootNavigatorKey!.currentWidget is Navigator,
        '请在 App 组件中设置 navigatorKey');
    return _elRootNavigatorKey!.currentContext!;
  }
}
