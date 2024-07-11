import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/components/others/hover.dart';
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

  /// 全局禁用hover，它只作用于 [ElHover] 小部件。
  ///
  /// 提示：和 [cursor] 逻辑一样，即使页面中会存在大量的 [ElHover] 小部件，
  /// 但重建它们不会触发子组件的build。
  final disabledHover = Obs(false);
}

/// Element UI 全局实例变量
final $el = ElService();
