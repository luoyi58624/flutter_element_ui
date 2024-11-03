import 'package:collection/collection.dart';
import 'package:element_plus/element_plus.dart';
import 'package:element_plus/src/components/navigation/tabs/common.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

part 'state.dart';

part 'tab.dart';

part 'default_wrapper.dart';

class ElTabs extends ElModelValue<int> {
  /// Element UI 标签导航，此组件只适用于桌面端，如果要适配移动端，你可以使用官方提供的 [TabBar] 小部件
  const ElTabs(
    super.modelValue, {
    super.key,
    required this.tabs,
    this.onDragChanged,
    super.onChanged,
  });

  /// 子标签小部件集合
  final List<ElTab> tabs;

  /// 拖拽触发的 change 事件，传递新的 tabs 集合
  final void Function(List<ElTab> tabs)? onDragChanged;

  /// 通过上下文 context 访问注入的 Tabs 数据
  static ElTabsData of(BuildContext context) =>
      ElTabsInheritedWidget.of(context).data;

  /// 构建默认的 tabs 外观
  static ElWidgetBuilder buildTabsWrapper() {
    return (context, child) => _TabsWrapper(
          child: child,
        );
  }

  /// 构建默认的 tabs 滚动条
  static ElScrollbarBuilder buildScrollbar({
    bool showScrollbar = true,
  }) {
    return (context, controller, child) => showScrollbar
        ? ElScrollbar(
            mode: ElScrollbarMode.onlyScrolling,
            controller: controller,
            thickness: 3,
            crossAxisMargin: 0.0,
            trackInteractive: false,
            // activeThumbColor: context.isDark
            //     ? const Color(0x30FFFFFF)
            //     : const Color(0x30000000),
            child: child,
          )
        : child;
  }

  /// 默认的拖拽代理
  static ReorderItemProxyDecorator dragProxyDecorator({
    double scaleValue = 1.0,
  }) {
    return (Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, scaleValue, animValue)!;
          return Transform.scale(
            scale: scale,
            child: child,
          );
        },
        child: child,
      );
    };
  }

  @override
  State<ElTabs> createState() => _ElTabsState();
}
