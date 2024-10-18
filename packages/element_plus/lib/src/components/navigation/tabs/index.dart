import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:element_plus/src/components/navigation/tabs/common.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../themes/components/navigation/tabs.dart';
import '../tab/index.dart';

part 'state.dart';

class ElTabs extends ModelValue<int> {
  /// Element UI 标签导航，此组件只适用于桌面端，在移动端你可以使用官方提供的 [TabBar] 小部件
  const ElTabs(
    super.modelValue, {
    super.key,
    required this.tabs,
    super.onChanged,
    this.onDragChanged,
  });

  /// 子标签小部件集合
  final List<ElTab> tabs;

  /// 拖拽触发的 change 事件，要让结果生效你需要设置新的 tabs 集合
  final void Function(List<ElTab> tabs)? onDragChanged;

  /// 通过上下文 context 访问注入的 Tabs 数据
  static TabsProp of(BuildContext context) =>
      TabsInheritedWidget.of(context).prop;

  @override
  State<ElTabs> createState() => _ElTabsState();
}
