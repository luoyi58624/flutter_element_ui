import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/components/layout/nav_tab.dart';
import 'package:flutter_element_ui/src/extension.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

part 'aside.dart';

part 'header.dart';

part 'main.dart';

part 'footer.dart';

part 'split.dart';

/// Element UI 布局组件抽象类
abstract class ElLayoutWidget extends StatelessWidget {
  const ElLayoutWidget({super.key});
}

class ElLayout extends ElLayoutWidget {
  /// Element UI 布局容器组件，通过它可以快速构建页面，内部基于 [Row]、[Column] 组件进行排版，
  /// 如果子元素中包含 [ElHeader]、[ElFooter]、[ElNavTab] 等布局组件，那么将以 [Column]
  /// 进行垂直布局，否则以 [Row] 进行水平布局。
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
          'ElAside不可以和 ElHeader、ElFooter、ElNavTab 放在同一容器');
      currentWidget = Column(children: childrenWidget);
    } else {
      currentWidget = Row(children: childrenWidget);
    }

    // 尝试构建分割组件，如果当前布局存在 ElSplit 组件，则将当前布局嵌套堆栈容器，
    // 然后依次添加分割拖拽控件，否则直接返回当前布局。
    // 之所以这样做，是因为因为 Stack 对于超出当前元素范围的小部件无法命中各种事件，
    // 你可以参考这个issue: https://github.com/flutter/flutter/issues/75747
    List<int> splitWidgetIndex = [];
    for (int i = 1; i < children.length - 1; i++) {
      if (children[i] is ElSplit) splitWidgetIndex.add(i);
    }
    if (splitWidgetIndex.isNotEmpty) {
      splitLayoutData = {};
      List<Widget> splitWidgets = [];
      if (isColumn) {
        for (final index in splitWidgetIndex) {
          if (children[index - 1] is ElAside) {
            final asideWidget = children[index - 1] as ElAside;
            final layoutKey =
                asideWidget.layoutKey ?? asideWidget.hashCode.toString();
            splitWidgets.add(
              _SplitWidget(
                layoutKey: layoutKey,
                splitWidget: children[index] as ElSplit,
              ),
            );
            splitLayoutData[layoutKey] = _RowSplitLayoutData(
              minWidth: asideWidget.minWidth,
              maxWidth: asideWidget.maxWidth,
              offset: Obs(asideWidget.width),
            );
          }
        }
      } else {}

      currentWidget = Stack(
        children: [
          currentWidget,
          ...splitWidgets,
        ],
      );
    }

    return _ElLayoutInheritedWidget(
      isColumn: isColumn,
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
    assert(result != null, '当前上下文没有找到 ElLayout 组件，请将 ElSplit 放置在 ElLayout 组件中');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElLayoutInheritedWidget oldWidget) => false;
}
