import 'package:collection/collection.dart';
import 'package:element_plus/src/components/navigation/tabs/common.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

import '../../../themes/components/navigation/tabs.dart';
import '../tab/index.dart';

part 'state.dart';

class ElTabs extends ElModelValue<int> {
  /// Element UI 标签导航，此组件只适用于桌面端，在移动端你可以使用官方提供的 [TabBar] 小部件
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

  /// 默认的拖拽代理
  static ReorderItemProxyDecorator dragProxyDecorator({
    double scaleValue = 1.15,
  }) {
    return (
      Widget child,
      int index,
      Animation<double> animation,
    ) =>
        AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final double animValue =
                Curves.easeInOut.transform(animation.value);
            final double scale = lerpDouble(1, scaleValue, animValue)!;
            return Transform.scale(
              scale: scale,
              child: child,
            );
          },
          child: child,
        );
  }

  @override
  State<ElTabs> createState() => _ElTabsState();
}
