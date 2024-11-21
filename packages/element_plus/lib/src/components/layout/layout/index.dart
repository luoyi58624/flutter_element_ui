import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

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
  final Widget? body;

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

class _ElLayoutState extends State<ElLayout> {
  late ElLayoutThemeData themeData;
  late ElLayoutData layoutData;

  @override
  Widget build(BuildContext context) {
    themeData = ElLayoutTheme.of(context);
    layoutData = ElLayoutData(
      navbarHeight: widget.navbar?.height ?? 0,
      sidebarWidth: widget.sidebar?.width ?? 0,
      rightSidebarWidth: widget.rightSidebar?.width ?? 0,
    );

    List<Widget> children = [];

    if (widget.body != null) {
      children.add(
        Positioned(
          top: layoutData.navbarHeight,
          bottom: 0,
          left: layoutData.sidebarWidth,
          right: layoutData.rightSidebarWidth,
          child: widget.body!,
        ),
      );
    }
    if (widget.sidebar != null) {
      children.add(
        Positioned(
          top: layoutData.navbarHeight,
          bottom: 0,
          left: 0,
          child: ColoredBox(
            color: themeData.sidebarColor!,
            child: SizedBox(
              width: layoutData.sidebarWidth,
              child: widget.sidebar!,
            ),
          ),
        ),
      );
    }
    if (widget.rightSidebar != null) {
      children.add(
        Positioned(
          top: layoutData.navbarHeight,
          bottom: 0,
          child: ColoredBox(
            color: themeData.sidebarColor!,
            child: SizedBox(
              width: layoutData.rightSidebarWidth,
              child: widget.rightSidebar!,
            ),
          ),
        ),
      );
    }
    if (widget.navbar != null) {
      children.add(
        Positioned(
          child: ColoredBox(
            color: themeData.navbarColor!,
            child: SizedBox(
              height: layoutData.navbarHeight,
              child: widget.navbar!,
            ),
          ),
        ),
      );
    }

    return _LayoutInheritedWidget(
      layoutData,
      child: Stack(
        children: children,
      ),
    );
  }
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
