import 'package:flutter/widgets.dart';
import 'package:flutter_obs/flutter_obs.dart';

part 'services/hover.dart';

/// Element UI 全局服务对象
final $el = _ElService();

class _ElService with _HoverService {
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
}
