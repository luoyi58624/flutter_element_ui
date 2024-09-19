import 'package:docs/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/commons/home.dart';
import '../pages/desktop/component_layout.dart';
import '../pages/desktop/guide_layout.dart';
import '../pages/desktop/layout.dart';
import '../pages/mobile/component_layout.dart';
import '../pages/mobile/guide_layout.dart';
import '../pages/mobile/home_layout.dart';
import '../pages/mobile/layout.dart';
import 'router_config.dart';
import 'routes/component.dart';
import 'routes/guide.dart';

/// 监听路由跳转
GoRouterRedirect _routerRedirect = (BuildContext context, GoRouterState state) {
  if (state.fullPath != null) {
    // 设置当前路由地址响应式变量
    RouterState.currentPath.value = state.fullPath!;
    ElUtils.nextTick(() {
      el.anchor.scrollTo(state.uri.toString());
    });
  }
  return null;
};

class RouterUtil {
  RouterUtil._();

  /// 构建自适应路由，如果是桌面端，将不会应用任何过渡动画，移动端则使用 IOS 路由动画
  static GoRoute buildRoute({
    required String path,
    required GoRouterWidgetBuilder builder,
  }) {
    return GoRoute(
      path: path,
      pageBuilder: (context, state) => RouterState.isMobile.value == true
          ? ElPlatform.isIOS
              ? CupertinoPage(child: builder(context, state))
              : MaterialPage(child: builder(context, state))
          : NoTransitionPage(
              child: builder(context, state).buildSelectionArea,
            ),
    );
  }

  /// 构建适用于桌面端路由配置
  static RoutingConfig buildDesktopRoutingConfig() {
    return RoutingConfig(
      redirect: _routerRedirect,
      routes: [
        /// [ShellRoute] 表示嵌套导航，构建器包含第三个参数：child，它表示当前导航的子路由页面
        ShellRoute(
          pageBuilder: (context, state, child) => NoTransitionPage(
            child: DesktopLayout(child: child),
          ),
          routes: [
            GoRoute(
              path: '/',
              pageBuilder: (context, state) => NoTransitionPage(
                child: const HomePage().buildSelectionArea,
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
                    ...buildComponentRoutes('${RootRoute.component.$2}/')
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// 构建适用于移动端路由配置，移动端布局特点是包含 4 个一级根页面，所以它会用 [StatefulShellRoute] 构建有状态选项卡式导航
  static RoutingConfig buildMobileRoutingConfig() {
    return RoutingConfig(
      redirect: _routerRedirect,
      routes: [
        /// 能够保持页面状态的嵌套导航，切换过程中页面状态不会丢失
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
                  routes: buildComponentRoutes(''),
                ),
              ],
            ),
            StatefulShellBranch(
              routes: [
                GoRoute(
                  path: '/${RootRoute.resource.$2}',
                  builder: (context, state) => const HomePage(),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
