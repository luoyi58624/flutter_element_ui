import 'package:docs/pages/commons/not_found.dart';
import 'package:docs/routes/guide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'global.dart';
import 'pages/desktop/component_layout.dart';
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
              ShellRoute(
                pageBuilder: (context, state, child) => NoTransitionPage(
                  child: DesktopComponentLayout(child: child),
                ),
                routes: [
                  GoRoute(
                    path: 'component',
                    redirect: (context, state) => '/component/overview',
                  ),
                  ...buildComponentRoutes('component/')
                ],
              ),
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
                routes: buildComponentRoutes(''),
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

  /// 构建自适应路由，如果是桌面端，将不会应用任何过渡动画，移动端则使用 IOS 路由动画
  static GoRoute buildRoute({
    required String path,
    required GoRouterWidgetBuilder builder,
  }) {
    return GoRoute(
      path: path,
      // builder: isMobile.value == true ? builder : null,
      pageBuilder: (context, state) => isMobile.value == true
          ? CupertinoPage(
              child: builder(context, state),
            )
          : NoTransitionPage(
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

  static final List<SlideRouteModelType> componentSlideRoutes = [
    (
      'Overview 组件总览',
      [
        ('Overview 组件总览', '/component/overview'),
        ('Material 组件总览', '/component/material'),
        ('Cupertino 组件总览', '/component/cupertino'),
      ],
    ),
    (
      'Basic 基础组件',
      [
        ('Button 按钮', '/component/button'),
        ('Color 色彩', '/component/color'),
        ('Icon 图标', '/component/icon'),
        ('Layout 布局', '/component/layout'),
        ('Link 链接', '/component/link'),
        ('Text 文本', '/component/text'),
        ('Scrollbar 滚动条', '/component/scrollbar'),
        ('Typography 排版', '/component/typography'),
      ],
    ),
    (
      'Form 表单组件',
      [
        ('Autocomplete 自动补全输入框', '/component/autocomplete'),
        ('Cascader 级联选择器', '/component/cascader'),
        ('Checkbox 多选框', '/component/checkbox'),
        ('ColorPicker 颜色选择器', '/component/color-picker'),
        ('DatePicker 日期选择器', '/component/date-picker'),
        ('DateTimePicker 日期时间选择器', '/component/datetime-picker'),
        ('Form 表单', '/component/form'),
        ('Input 输入框', '/component/input'),
        ('Input Number 数字输入框', '/component/input-number'),
        ('Radio 单选框', '/component/radio'),
        ('Rate 评分', '/component/rate'),
        ('Select 选择器', '/component/select'),
        ('Slider 滑块', '/component/slider'),
        ('Switch 开关', '/component/switch'),
        ('TimePicker 时间选择器', '/component/time-picker'),
        ('TimeSelect 时间选择', '/component/time-select'),
        ('Transfer 穿梭框', '/component/transfer'),
        ('TreeSelect 树形选择', '/component/tree-select'),
        ('Upload 上传', '/component/upload'),
      ],
    ),
    (
      'Data 数据展示',
      [
        ('Avatar 头像', '/component/avatar'),
        ('Badge 徽章', '/component/badge'),
        ('Calendar 日历', '/component/calendar'),
        ('Card 卡片', '/component/card'),
        ('Carousel 走马灯', '/component/carousel'),
        ('Collapse 折叠面板', '/component/collapse'),
        ('Descriptions 描述列表', '/component/descriptions'),
        ('Empty 空状态', '/component/empty'),
        ('Image 图片', '/component/image'),
        ('Infinite Scroll 无限滚动', '/component/infinite-scroll'),
        ('Pagination 分页', '/component/Pagination'),
        ('Progress 进度条', '/component/Progress'),
        ('Result 结果', '/component/Result'),
        ('Skeleton 骨架屏', '/component/Skeleton'),
        ('Table 表格', '/component/Table'),
        ('Tag 标签', '/component/Tag'),
        ('Timeline 时间线', '/component/Timeline'),
        ('Tour 漫游式引导', '/component/Tour'),
        ('Tree 树形控件', '/component/Tree'),
        ('Statistic 统计组件', '/component/Statistic'),
        ('Segmented 分段控制器', '/component/Segmented'),
      ],
    ),
    (
      'Navigation 导航',
      [
        ('Affix 固钉', '/component/Affix'),
        ('Anchor 锚点', '/component/Anchor'),
        ('Backtop 回到顶部', '/component/Backtop'),
        ('Breadcrumb 面包屑', '/component/Breadcrumb'),
        ('Dropdown 下拉菜单', '/component/Dropdown'),
        ('Menu 菜单', '/component/Menu'),
        ('Page Header 页头', '/component/page-header'),
        ('Steps 步骤条', '/component/Steps'),
        ('Tabs 标签页', '/component/Tabs'),
      ],
    ),
    (
      'Feedback 反馈组件',
      [
        ('Alert 提示', '/component/Alert'),
        ('Dialog 对话框', '/component/Dialog'),
        ('Drawer 抽屉', '/component/Drawer'),
        ('Loading 加载', '/component/Loading'),
        ('Message 消息提示', '/component/Message'),
        ('MessageBox 消息弹框', '/component/MessageBox'),
        ('Notification 通知', '/component/Notification'),
        ('PopConfirm 气泡确认框', '/component/PopConfirm'),
        ('Popover 气泡卡片', '/component/Popover'),
        ('Tooltip 文字提示', '/component/Tooltip'),
      ],
    ),
    (
      'Others 其他',
      [
        ('Divider 分割线', '/component/Divider'),
        ('Watermark 水印', '/component/Watermark'),
      ],
    ),
  ];
}
