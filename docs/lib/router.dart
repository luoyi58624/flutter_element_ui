import 'package:docs/pages/commons/not_found.dart';
import 'package:docs/routes/guide.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  navigatorKey: el.routerKey,
  initialLocation: '/',
  errorPageBuilder: (context, state) => const NoTransitionPage(
    child: NotFoundPage(),
  ),
  routingConfig: routingConfig,
);

final routingConfig = Obs<RoutingConfig>(
  const RoutingConfig(routes: []),
);

/// 构建适用于桌面端路由配置
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

/// 根路由模型
typedef RootRouteModelType = (String name, String path);

/// 侧边栏路由模型类型，这个模型同样适用于移动端
typedef SlideRouteModelType = (
  String title,
  List<(String name, String path)> items
);

class RootRoute {
  static const RootRouteModelType guide = ('指南', 'guide');
  static const RootRouteModelType component = ('组件', 'component');
  static const RootRouteModelType resource = ('资源', 'resource');

  static List<RootRouteModelType> values = [guide, component, resource];
}

class RouterUtil {
  RouterUtil._();

  /// 检测当前屏幕尺寸是否到达移动端断点，MainApp 会监听 MediaQuery 的尺寸变化，
  /// 当尺寸小于 640px 时将使用移动端路由配置，大于 640px 时则使用桌面端路由配置
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

  /// 监听路由跳转
  static GoRouterRedirect redirect =
      (BuildContext context, GoRouterState state) {
    if (state.fullPath != null) {
      // 设置当前路由地址响应式变量
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
      pageBuilder: (context, state) => isMobile.value == true
          ? PlatformUtil.isIOS
              ? CupertinoPage(child: builder(context, state))
              : MaterialPage(child: builder(context, state))
          : NoTransitionPage(
              child: builder(context, state).buildSelectionArea,
            ),
    );
  }

  static final List<SlideRouteModelType> guideSlideRoutes = [
    (
      '基础',
      [
        ('设计', '/${RootRoute.guide.$2}/design'),
        ('导航', '/${RootRoute.guide.$2}/nav'),
        ('安装', '/${RootRoute.guide.$2}/install'),
        ('快速开始', '/${RootRoute.guide.$2}/quickstart'),
      ],
    ),
    (
      '进阶',
      [
        ('国际化', '/${RootRoute.guide.$2}/i18n'),
        ('主题', '/${RootRoute.guide.$2}/theme'),
        ('更新日志', '/${RootRoute.guide.$2}/changelog'),
      ],
    ),
    (
      '开发',
      [
        ('开发指南', '/${RootRoute.guide.$2}/dev-${RootRoute.guide.$2}'),
        ('开发常见问题', '/${RootRoute.guide.$2}/dev-faq'),
        ('提交示例', '/${RootRoute.guide.$2}/commit-examples'),
        ('翻译', '/${RootRoute.guide.$2}/translation'),
      ],
    ),
  ];

  static final List<SlideRouteModelType> componentSlideRoutes = [
    (
      'Overview 组件总览',
      [
        ('Element 组件总览', '/${RootRoute.component.$2}/element'),
        ('Material 组件总览', '/${RootRoute.component.$2}/material'),
        ('Cupertino 组件总览', '/${RootRoute.component.$2}/cupertino'),
      ],
    ),
    (
      'Basic 基础组件',
      [
        ('Button 按钮', '/${RootRoute.component.$2}/button'),
        ('Color 色彩', '/${RootRoute.component.$2}/color'),
        ('Icon 图标', '/${RootRoute.component.$2}/icon'),
        ('Layout 布局', '/${RootRoute.component.$2}/layout'),
        ('Text 文本', '/${RootRoute.component.$2}/text'),
        ('Scrollbar 滚动条', '/${RootRoute.component.$2}/scrollbar'),
        ('Typography 排版', '/${RootRoute.component.$2}/typography'),
      ],
    ),
    (
      'Form 表单组件',
      [
        ('Autocomplete 自动补全输入框', '/${RootRoute.component.$2}/autocomplete'),
        ('Cascader 级联选择器', '/${RootRoute.component.$2}/cascader'),
        ('Checkbox 多选框', '/${RootRoute.component.$2}/checkbox'),
        ('ColorPicker 颜色选择器', '/${RootRoute.component.$2}/color-picker'),
        ('DatePicker 日期选择器', '/${RootRoute.component.$2}/date-picker'),
        (
          'DateTimePicker 日期时间选择器',
          '/${RootRoute.component.$2}/datetime-picker'
        ),
        ('Form 表单', '/${RootRoute.component.$2}/form'),
        ('Input 输入框', '/${RootRoute.component.$2}/input'),
        ('Input Number 数字输入框', '/${RootRoute.component.$2}/input-number'),
        ('Radio 单选框', '/${RootRoute.component.$2}/radio'),
        ('Rate 评分', '/${RootRoute.component.$2}/rate'),
        ('Select 选择器', '/${RootRoute.component.$2}/select'),
        ('Slider 滑块', '/${RootRoute.component.$2}/slider'),
        ('Switch 开关', '/${RootRoute.component.$2}/switch'),
        ('TimePicker 时间选择器', '/${RootRoute.component.$2}/time-picker'),
        ('TimeSelect 时间选择', '/${RootRoute.component.$2}/time-select'),
        ('Transfer 穿梭框', '/${RootRoute.component.$2}/transfer'),
        ('TreeSelect 树形选择', '/${RootRoute.component.$2}/tree-select'),
        ('Upload 上传', '/${RootRoute.component.$2}/upload'),
      ],
    ),
    (
      'Data 数据展示',
      [
        ('Avatar 头像', '/${RootRoute.component.$2}/avatar'),
        ('Badge 徽章', '/${RootRoute.component.$2}/badge'),
        ('Calendar 日历', '/${RootRoute.component.$2}/calendar'),
        ('Card 卡片', '/${RootRoute.component.$2}/card'),
        ('Carousel 走马灯', '/${RootRoute.component.$2}/carousel'),
        ('Collapse 折叠面板', '/${RootRoute.component.$2}/collapse'),
        ('Descriptions 描述列表', '/${RootRoute.component.$2}/descriptions'),
        ('Empty 空状态', '/${RootRoute.component.$2}/empty'),
        ('Image 图片', '/${RootRoute.component.$2}/image'),
        ('Infinite Scroll 无限滚动', '/${RootRoute.component.$2}/infinite-scroll'),
        ('Pagination 分页', '/${RootRoute.component.$2}/Pagination'),
        ('Progress 进度条', '/${RootRoute.component.$2}/Progress'),
        ('Result 结果', '/${RootRoute.component.$2}/Result'),
        ('Skeleton 骨架屏', '/${RootRoute.component.$2}/Skeleton'),
        ('Table 表格', '/${RootRoute.component.$2}/Table'),
        ('Tag 标签', '/${RootRoute.component.$2}/Tag'),
        ('Timeline 时间线', '/${RootRoute.component.$2}/Timeline'),
        ('Tour 漫游式引导', '/${RootRoute.component.$2}/Tour'),
        ('Tree 树形控件', '/${RootRoute.component.$2}/Tree'),
        ('Statistic 统计组件', '/${RootRoute.component.$2}/Statistic'),
        ('Segmented 分段控制器', '/${RootRoute.component.$2}/Segmented'),
      ],
    ),
    (
      'Navigation 导航',
      [
        ('Affix 固钉', '/${RootRoute.component.$2}/Affix'),
        ('Anchor 锚点', '/${RootRoute.component.$2}/Anchor'),
        ('Backtop 回到顶部', '/${RootRoute.component.$2}/Backtop'),
        ('Breadcrumb 面包屑', '/${RootRoute.component.$2}/Breadcrumb'),
        ('Dropdown 下拉菜单', '/${RootRoute.component.$2}/Dropdown'),
        ('Menu 菜单', '/${RootRoute.component.$2}/Menu'),
        ('Page Header 页头', '/${RootRoute.component.$2}/page-header'),
        ('Steps 步骤条', '/${RootRoute.component.$2}/Steps'),
        ('Tabs 标签页', '/${RootRoute.component.$2}/Tabs'),
      ],
    ),
    (
      'Feedback 反馈组件',
      [
        ('Alert 提示', '/${RootRoute.component.$2}/Alert'),
        ('Dialog 对话框', '/${RootRoute.component.$2}/Dialog'),
        ('Drawer 抽屉', '/${RootRoute.component.$2}/Drawer'),
        ('Loading 加载', '/${RootRoute.component.$2}/Loading'),
        ('Message 消息提示', '/${RootRoute.component.$2}/Message'),
        ('MessageBox 消息弹框', '/${RootRoute.component.$2}/MessageBox'),
        ('Notification 通知', '/${RootRoute.component.$2}/Notification'),
        ('PopConfirm 气泡确认框', '/${RootRoute.component.$2}/PopConfirm'),
        ('Popover 气泡卡片', '/${RootRoute.component.$2}/Popover'),
        ('Tooltip 文字提示', '/${RootRoute.component.$2}/Tooltip'),
      ],
    ),
    (
      'Others 其他',
      [
        ('Divider 分割线', '/${RootRoute.component.$2}/Divider'),
        ('Watermark 水印', '/${RootRoute.component.$2}/Watermark'),
      ],
    ),
  ];
}
