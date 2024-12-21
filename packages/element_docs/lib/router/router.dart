import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../global.dart';
import '../layouts/desktop/layout.dart';
import '../layouts/mobile/component_layout.dart';
import '../layouts/mobile/contribute_layout.dart';
import '../layouts/mobile/guide_layout.dart';
import '../layouts/mobile/home_layout.dart';
import '../layouts/mobile/layout.dart';
import '../pages/component/basic/focus/index.dart';
import '../pages/component/basic/scrollbar/index.dart';
import '../pages/component/data/table/index.dart';
import '../pages/component/data/tree/index.dart';
import '../pages/component/feedback/context_menu/index.dart';
import '../pages/component/feedback/menu/index.dart';
import '../pages/component/layout/layout/index.dart';
import '../pages/component/layout/menu_bar/index.dart';
import '../pages/component/other/drag/index.dart';
import '../pages/component/other/drag_resizer/index.dart';
import '../pages/component/other/ring/index.dart';
import '../pages/component/other/split_pane/index.dart';
import '../pages/component/other/split_resizer/index.dart';
import '../pages/component/overview/cupertino/index.dart';
import '../pages/component/overview/element/index.dart';
import '../pages/component/overview/material/index.dart';
import '../pages/contribute/start.dart';
import '../pages/contribute/theme_manager.dart';
import '../pages/guide/design/index.dart';
import '../pages/home.dart';
import '../pages/not_found.dart';
import '../pages/guide/install/index.dart';
import '../pages/guide/nav/index.dart';
import '../pages/guide/quick_start/index.dart';
import '../pages/guide/theme/index.dart';
import '../pages/component/basic/button/index.dart';
import '../pages/component/basic/color/index.dart';
import '../pages/component/basic/icon/index.dart';
import '../pages/component/basic/text/index.dart';
import '../pages/component/data/collapse/index.dart';
import '../pages/component/data/progress/index.dart';
import '../pages/component/data/tag/index.dart';
import '../pages/component/feedback/message/index.dart';
import '../pages/component/feedback/toast/index.dart';
import '../pages/component/form/input/index.dart';
import '../pages/component/form/slider/index.dart';
import '../pages/component/form/switch/index.dart';
import '../pages/component/navigation/nav_menu/index.dart';
import '../pages/component/navigation/tabs/index.dart';
import '../pages/component/other/animated_size/index.dart';
import '../pages/component/basic/event/index.dart';
import '../pages/template/layout/material.dart';
import '../widgets/demo.dart';
import 'router_config.dart';

part 'router_state.dart';

part 'router_util.dart';

part 'routes/guide.dart';

part 'routes/component.dart';

part 'routes/template.dart';

part 'routes/contribute.dart';

final GoRouter router = GoRouter.routingConfig(
  navigatorKey: el.navigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: NotFoundPage(),
  ),
  routingConfig: _routingConfig,
);

/// 控制路由配置全局响应式变量，当屏幕尺寸达到移动端尺寸阈值时，将自动更新路由配置
final isMobileRoute = WatchObs<bool?>(
  null,
  watch: (newValue, oldValue) {
    newValue == true
        ? _routingConfig.value = _buildMobileRoutingConfig()
        : _routingConfig.value = _buildDesktopRoutingConfig();
  },
);

/// 动态路由配置，初始默认为空数组
final _routingConfig = Obs<RoutingConfig>(
  const RoutingConfig(routes: []),
);

/// 监听路由跳转
// GoRouterRedirect _routerRedirect = (BuildContext context, GoRouterState state) {
//   if (state.fullPath != null) {
//     // 设置当前路由地址响应式变量
//     RouterState.currentPath.value = state.fullPath!;
//     nextTick(() {
//       el.anchor.scrollTo(state.uri.toString());
//     });
//   }
//   return null;
// };

/// 构建桌面端路由配置
RoutingConfig _buildDesktopRoutingConfig() {
  return RoutingConfig(
    routes: [
      /// ShellRoute 表示嵌套导航，切换页面不会保存状态
      ShellRoute(
        pageBuilder: (context, state, child) => NoTransitionPage(
          child: DesktopLayout(child: child),
        ),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomePage(),
            ),
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) => NoTransitionPage(
                  child: DesktopGuideLayout(child: child),
                ),
                routes: [
                  GoRoute(
                    path: RootRoute.guide.$2,
                    redirect: (context, state) =>
                        '/${RootRoute.guide.$2}/design',
                  ),
                  ...buildGuideRoutes('${RootRoute.guide.$2}/')
                ],
              ),
              ShellRoute(
                pageBuilder: (context, state, child) => NoTransitionPage(
                  child: DesktopComponentLayout(child: child),
                ),
                routes: [
                  GoRoute(
                    path: RootRoute.component.$2,
                    redirect: (context, state) =>
                        '/${RootRoute.component.$2}/element',
                  ),
                  ..._buildComponentRoutes('${RootRoute.component.$2}/')
                ],
              ),
              ShellRoute(
                pageBuilder: (context, state, child) => NoTransitionPage(
                  child: DesktopTemplateLayout(child: child),
                ),
                routes: [
                  GoRoute(
                    path: RootRoute.template.$2,
                    redirect: (context, state) =>
                        '/${RootRoute.template.$2}/material',
                  ),
                  ...buildTemplateRoutes('${RootRoute.template.$2}/')
                ],
              ),
              ShellRoute(
                pageBuilder: (context, state, child) => NoTransitionPage(
                  child: DesktopContributeLayout(child: child),
                ),
                routes: [
                  GoRoute(
                    path: RootRoute.contribute.$2,
                    redirect: (context, state) =>
                        '/${RootRoute.contribute.$2}/start',
                  ),
                  ...buildContributeRoutes('${RootRoute.contribute.$2}/')
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// 构建适用于移动端路由配置，它会用 [StatefulShellRoute] 构建选项卡式导航
RoutingConfig _buildMobileRoutingConfig() {
  return RoutingConfig(
    routes: [
      /// StatefulShellRoute 能够保持页面状态的嵌套导航，切换过程中页面状态不会丢失
      StatefulShellRoute.indexedStack(
        pageBuilder: (context, state, navigationShell) => NoTransitionPage(
          child: MobileLayout(
            navigationShell: navigationShell,
          ),
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => const MobileHomeLayout(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${RootRoute.guide.$2}',
                builder: (context, state) => const MobileGuideLayout(),
                routes: buildGuideRoutes(''),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${RootRoute.component.$2}',
                builder: (context, state) => const MobileComponentLayout(),
                routes: _buildComponentRoutes(''),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${RootRoute.template.$2}',
                builder: (context, state) => const MobileComponentLayout(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/${RootRoute.contribute.$2}',
                builder: (context, state) => const MobileContributeLayout(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
