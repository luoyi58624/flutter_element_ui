import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/components/layout/nav_tab.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

part 'aside.dart';

part 'header.dart';

part 'main.dart';

part 'footer.dart';

part 'split.dart';

/// Element UI 布局组件抽象类，支持以下布局组件：
/// * [ElLayout] 布局容器，它是所有布局类的基础，内部实际上就是对 [Row]、[Column] 进行的封装
/// * [ElHeader] 头部布局，它会占据全部宽度，高度自定义
/// * [ElAside] 侧边栏布局，用于左侧、右侧导航，它会占据全部高度，宽度自定义
/// * [ElMain] 主页面布局，它会分配剩余的全部空间
/// * [ElFooter] 底部布局，和[ElHeader]效果一样，仅做语义化
/// * [ElSplit] 分割布局组件，它可以轻松实现拖拽两个布局容器的尺寸
abstract class ElLayoutWidget extends StatelessWidget {
  const ElLayoutWidget({super.key});
}

class ElLayout extends ElLayoutWidget {
  /// Element UI 布局容器组件，内部基于 [Row]、[Column] 组件进行排版，如果子元素中包含
  /// [ElHeader]、[ElFooter]、[ElNavTab] 等布局组件，那么将以 [Column] 进行垂直布局，
  /// 否则以 [Row] 进行水平布局。
  /// * 上下布局
  /// ```dart
  /// ElLayout(children: [
  ///   ElHeader(child: SizedBox()),
  ///   ElMain(child: SizedBox()),
  /// ]);
  /// ```
  /// * 左右布局
  /// ```dart
  /// ElLayout(children: [
  ///   ElAside(child: SizedBox()),
  ///   ElMain(child: SizedBox()),
  /// ]);
  /// ```
  /// * 包含头部、侧边栏、主页面布局
  /// ```dart
  /// ElLayout(children: [
  ///   ElHeader(child: SizedBox()),
  ///   ElLayout(children: [
  ///     ElAside(child: SizedBox()),
  ///     ElMain(child: SizedBox()),
  ///   ]),
  /// ]);
  /// ```
  /// * 或者侧边栏独占整个高度
  /// ```dart
  /// ElLayout(children: [
  ///   ElAside(child: SizedBox()),
  ///   ElLayout(children: [
  ///     ElHeader(child: SizedBox()),
  ///     ElMain(child: SizedBox()),
  ///   ]),
  /// ]);
  /// ```
  const ElLayout({super.key, required this.children});

  /// Element UI 布局子类组件
  final List<ElLayoutWidget> children;

  @override
  Widget build(BuildContext context) {
    assert(children.first is! ElSplit && children.last is! ElSplit,
        'ElSplit分割布局组件必须存在两个布局组件之间');
    bool isColumn =
        children.any((e) => e is ElHeader || e is ElFooter || e is ElNavTab);

    late Widget currentWidget;
    Map<String, _SplitLayoutData>? splitLayoutData;
    // 处理嵌套的ElLayout，如果存在需要将其包裹在 Expanded 中，否则会报边界异常
    List<Widget> childrenWidget =
        children.map((e) => e is ElLayout ? Expanded(child: e) : e).toList();
    if (isColumn) {
      assert(children.any((e) => e is ElAside) == false,
          'ElAside不可以和 ElHeader、ElFooter、ElNavTab 放在同一容器，请使用 ElLayout 包裹它们');
      currentWidget = Column(children: childrenWidget);
    } else {
      currentWidget = Row(children: childrenWidget);
    }

    // 尝试构建分割组件，如果当前布局存在 ElSplit 组件，则将当前布局嵌套堆栈容器，然后依次添加分割拖拽控件。
    List<int> splitWidgetIndex = [];
    for (int i = 1; i < children.length - 1; i++) {
      if (children[i] is ElSplit) splitWidgetIndex.add(i);
    }
    if (splitWidgetIndex.isNotEmpty) {
      splitLayoutData = {};
      List<Widget> splitWidgets = [];
      if (isColumn) {
        for (final index in splitWidgetIndex) {
          if (children[index - 1] is ElHeader) {
            final headerWidget = children[index - 1] as ElHeader;
            final splitWidget = children[index] as ElSplit;
            final layoutKey = headerWidget.getLayoutKey;
            splitWidgets.add(
              _SplitWidget(
                layoutKey: layoutKey,
                splitWidget: splitWidget,
              ),
            );
            splitLayoutData[layoutKey] = _ColumnSplitLayoutData(
              minHeight: headerWidget.minHeight,
              maxHeight: headerWidget.maxHeight,
              offset: Obs(headerWidget.height),
              size: splitWidget.size,
              triggerSize: splitWidget.triggerSize,
            );
          }
        }
      } else {
        for (final index in splitWidgetIndex) {
          if (children[index - 1] is ElAside) {
            final asideWidget = children[index - 1] as ElAside;
            final splitWidget = children[index] as ElSplit;
            final layoutKey = asideWidget.getLayoutKey;
            splitWidgets.add(
              _SplitWidget(
                layoutKey: layoutKey,
                splitWidget: splitWidget,
              ),
            );
            splitLayoutData[layoutKey] = _RowSplitLayoutData(
              minWidth: asideWidget.minWidth,
              maxWidth: asideWidget.maxWidth,
              offset: Obs(asideWidget.width),
              size: splitWidget.size,
              triggerSize: splitWidget.triggerSize,
            );
          }
        }
      }

      currentWidget = Stack(
        children: [
          currentWidget,
          ...splitWidgets,
        ],
      );
    }

    return _ElLayoutInheritedWidget(
      isColumn: isColumn,
      splitLayoutData: splitLayoutData,
      child: currentWidget,
    );
  }
}

/// 注入布局数据
class _ElLayoutInheritedWidget extends InheritedWidget {
  const _ElLayoutInheritedWidget({
    required super.child,
    required this.isColumn,
    this.splitLayoutData,
  });

  /// 当前布局是否是垂直布局
  final bool isColumn;

  /// 如果设置了分割界面组件，则会注入分割布局数据
  final Map<String, _SplitLayoutData>? splitLayoutData;

  static _ElLayoutInheritedWidget of(BuildContext context) {
    final _ElLayoutInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ElLayoutInheritedWidget>();
    assert(result != null, '当前上下文没有找到 ElLayout 组件，请将布局组件放置在 ElLayout 中');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElLayoutInheritedWidget oldWidget) => false;
}
