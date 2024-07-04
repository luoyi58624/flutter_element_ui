import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

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

  /// 应用的全局光标，当注入 [ElTheme] 时，会插入一个顶级 [MouseRegion] 组件，
  /// 当更新响应式变量时，会在整个应用层改变全局光标样式。
  ///
  /// 提示：[MouseRegion]不会导致内部的子组件重建，所以不必担心引发性能问题。
  final cursor = Obs(SystemMouseCursors.basic);
}

/// Element UI 全局实例变量
final $el = ElService();
