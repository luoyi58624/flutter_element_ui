import 'package:flutter/material.dart';
import 'package:flutter_obs/flutter_obs.dart';

/// 根节点导航key，此变量不对外开放，请通过[ElTheme]传递navigatorKey
late GlobalKey<NavigatorState>? elRootNavigatorKey;

class ElService {
  /// 根节点context，使用前必须在 App 中配置 navigatorKey
  BuildContext get context {
    assert(elRootNavigatorKey != null, '请在 ElTheme 中设置 navigatorKey');
    assert(
        elRootNavigatorKey!.currentWidget != null &&
            elRootNavigatorKey!.currentWidget is Navigator,
        '请在 App 组件中设置 navigatorKey');
    return elRootNavigatorKey!.currentContext!;
  }

  /// 应用的全局光标，当注入 [ElTheme] 时，会插入一个顶级 [MouseRegion] 组件。
  ///
  /// 提示：[MouseRegion]的重建不会触发内部的子组件build。
  final cursor = Obs(SystemMouseCursors.basic);

  /// 全局禁用hover，在拖拽页面中的元素时会用到它
  final disabledHover = Obs(false);
}

/// Element UI 全局实例变量
final $el = ElService();
