import 'package:docs/pages/commons/not_found.dart';
import 'package:docs/routes/guide.dart';
import 'package:flutter/widgets.dart';

import 'global.dart';
import 'pages/desktop/guide_layout.dart';
import 'pages/desktop/layout.dart';
import 'pages/mobile/component_layout.dart';
import 'pages/mobile/guide_layout.dart';
import 'pages/mobile/home_layout.dart';
import 'pages/mobile/layout.dart';
import 'pages/commons/home.dart';
import 'routes/component.dart';

final GoRouter router = GoRouter.routingConfig(
  navigatorKey: el.navigatorKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: NotFoundPage(),
  ),
  routingConfig: routingConfig,
);

final routingConfig = Obs<RoutingConfig>(
  const RoutingConfig(routes: []),
);

RoutingConfig _buildDesktopRoutingConfig() {
  return RoutingConfig(
    redirect: RouterUtil.redirect,
    routes: [
      ShellRoute(
        pageBuilder: (context, state, child) => NoTransitionPage(
          child: DesktopLayout(child: child),
        ),
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) => NoTransitionPage(
                  child: DesktopGuideLayout(child: child),
                ),
                routes: [
                  GoRoute(
                    path: 'guide',
                    redirect: (context, state) => '/guide/design',
                  ),
                  ...buildGuideRoutes('guide/')
                ],
              ),
              componentRoute,
            ],
          ),
        ],
      ),
    ],
  );
}

RoutingConfig _buildMobileRoutingConfig() {
  return RoutingConfig(
    redirect: RouterUtil.redirect,
    routes: [
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
                path: '/guide',
                builder: (context, state) => const MobileGuideLayout(),
                routes: buildGuideRoutes(''),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/component',
                builder: (context, state) => const MobileComponentLayout(),
                routes: [
                  GoRoute(
                    path: 'child',
                    builder: (context, state) => const ComponentChildPage(),
                    routes: [
                      GoRoute(
                        path: 'next_child',
                        builder: (context, state) =>
                            const ComponentChildPage2(),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/resource',
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

/// 侧边栏路由模型类型，同样适用于移动端
typedef SlideRouteModelType = (
  String title,
  List<(String name, String path)> items
);

class RouterUtil {
  RouterUtil._();

  /// 检测当前屏幕尺寸是否到达移动端断点
  static final isMobile = Obs<bool?>(
    null,
    watch: (newValue, oldValue) {
      newValue == true
          ? routingConfig.value = _buildMobileRoutingConfig()
          : routingConfig.value = _buildDesktopRoutingConfig();
    },
  );

  /// 当前路由地址响应式变量
  static final currentPath = Obs('');

  static GoRouterRedirect redirect =
      (BuildContext context, GoRouterState state) {
    if (state.fullPath != null) {
      RouterUtil.currentPath.value = state.fullPath!;
    }
    return null;
  };

  /// 构建自适应路由，如果是桌面端，将不会应用任何过渡动画
  static GoRoute buildRoute({
    required String path,
    required GoRouterWidgetBuilder builder,
  }) {
    return GoRoute(
      path: path,
      builder: isMobile.value == true ? builder : null,
      pageBuilder: isMobile.value == true
          ? null
          : (context, state) => NoTransitionPage(
                child: builder(context, state),
              ),
    );
  }

  static final List<SlideRouteModelType> guideSlideRoutes = [
    (
      '基础',
      [
        ('设计', '/guide/design'),
        ('导航', '/guide/nav'),
        ('安装', '/guide/install'),
        ('快速开始', '/guide/quickstart'),
      ],
    ),
    (
      '进阶',
      [
        ('国际化', '/guide/i18n'),
        ('主题', '/guide/theme'),
        ('更新日志', '/guide/changelog'),
      ],
    ),
    (
      '开发',
      [
        ('开发指南', '/guide/dev-guide'),
        ('开发常见问题', '/guide/dev-faq'),
        ('提交示例', '/guide/commit-examples'),
        ('翻译', '/guide/translation'),
      ],
    ),
  ];
}
