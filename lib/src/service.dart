import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/components/others/hover.dart';
import 'package:flutter_element_ui/src/theme.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// Element UI 全局实例变量
final $el = ElService();

/// 根节点导航key，请通过[ElTheme]传递navigatorKey (此变量不对外开放)
late GlobalKey<NavigatorState>? elRootNavigatorKey;

class ElService {
  /// 默认的主题数据
  final ElThemeData defaultThemeData = ElThemeData();

  /// Element UI 颜色主题类型集合
  final List<String> themeTypes = [
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

  /// 全局禁用hover，它作用于 [ElHover] 小部件
  final disabledHover = Obs(false);

  /// 根节点context，使用前必须在 App 中配置 navigatorKey
  BuildContext get context {
    assert(elRootNavigatorKey != null, '请在 ElTheme 中设置 navigatorKey');
    assert(
        elRootNavigatorKey!.currentWidget != null &&
            elRootNavigatorKey!.currentWidget is Navigator,
        '请在 App 组件中设置 navigatorKey');
    return elRootNavigatorKey!.currentContext!;
  }
}
