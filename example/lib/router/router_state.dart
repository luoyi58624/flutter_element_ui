import 'package:example/global.dart';

import 'router_util.dart';

/// 路由全局状态
class RouterState {
  RouterState._();

  /// 动态路由配置
  static final routingConfig = Obs<RoutingConfig>(
    const RoutingConfig(routes: []),
  );

  /// 检测当前屏幕尺寸是否到达移动端断点，[MainApp] 会监听 MediaQuery 的尺寸变化，
  /// 当尺寸小于 640px 时将使用移动端路由配置，大于 640px 时则使用桌面端路由配置
  static final isMobile = Obs<bool?>(
    null,
    watch: (newValue, oldValue) {
      newValue == true
          ? routingConfig.value = RouterUtil.buildMobileRoutingConfig()
          : routingConfig.value = RouterUtil.buildDesktopRoutingConfig();
    },
  );

  /// 当前路由地址
  static final currentPath = Obs('');
}
