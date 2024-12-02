import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'state.dart';

part 'theme.dart';

part '../../../generates/components/layout/layout/index.g.dart';

class ElLayout extends StatefulWidget {
  const ElLayout({
    super.key,
    this.navbar,
    this.body,
    this.sidebar,
    this.rightSidebar,
    this.toolbar,
    this.rightToolbar,
    this.bottomToolbar,
    this.cacheKey,
  });

  /// 顶部导航栏
  final ElNavbar? navbar;

  /// 布局的主要内容区域
  final ElBody? body;

  /// 左边侧边栏，当窗口为移动端尺寸时，会自动收起
  final ElSidebar? sidebar;

  /// 右边侧边栏
  final ElSidebar? rightSidebar;

  /// 左侧工具栏
  final ElToolbar? toolbar;

  /// 右侧工具栏
  final ElToolbar? rightToolbar;

  /// 底部工具类
  final ElToolbar? bottomToolbar;

  /// 缓存布局信息 key
  final String? cacheKey;

  static ElLayoutData of(BuildContext context) =>
      _LayoutInheritedWidget.of(context);

  @override
  State<ElLayout> createState() => _ElLayoutState();
}

class ElLayoutData {
  double navbarHeight;
  double sidebarWidth;
  double rightSidebarWidth;

  ElLayoutData({
    required this.navbarHeight,
    required this.sidebarWidth,
    required this.rightSidebarWidth,
  });
}

class _LayoutInheritedWidget extends InheritedWidget {
  const _LayoutInheritedWidget(
    this.layoutData, {
    required super.child,
  });

  final ElLayoutData layoutData;

  static ElLayoutData of(BuildContext context) {
    final _LayoutInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_LayoutInheritedWidget>();
    assert(result != null, 'No _LayoutInheritedWidget found in context');
    return result!.layoutData;
  }

  @override
  bool updateShouldNotify(_LayoutInheritedWidget oldWidget) => true;
}
