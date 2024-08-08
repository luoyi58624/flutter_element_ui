import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_element_ui/src/components/layout/nav_tab.dart';
import 'package:flutter_element_ui/src/extensions/element.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/service.dart';

part 'aside.dart';

part 'header.dart';

part 'main.dart';

part 'footer.dart';

part 'split.dart';

typedef _NotifyAllOffsetFun = void Function(String layoutKey);

/// Element UI 布局组件抽象类，支持以下布局组件：
/// * [ElLayout] 布局容器，它是所有布局类的基础，内部实际上就是对 [Row]、[Column] 进行的封装，
/// 它还可以进行嵌套，嵌套的布局容器将充满内部所有的剩余空间，你可以设置 flex 调整它的比例
/// * [ElHeader] 头部布局，它会占据全部宽度，高度自定义
/// * [ElAside] 侧边栏布局，用于左侧、右侧导航，它会占据全部高度，宽度自定义
/// * [ElMain] 主页面布局，它会分配剩余的全部空间，你可以设置 flex 调整它的比例
/// * [ElFooter] 底部布局，和[ElHeader]效果一样，仅做语义化
/// * [ElLayoutSplit] 分割面板组件，它可以调整两个布局容器的尺寸
abstract class ElLayoutWidget extends StatelessWidget {
  const ElLayoutWidget({super.key, this.layoutKey});

  /// 指定布局 key，它可以持久化保存拖拽布局尺寸
  final String? layoutKey;

  /// 如果没有设置[layoutKey]，则取当前[hashCode]作为[layoutKey]
  String get getLayoutKey => layoutKey ?? hashCode.toString();
}

/// 弹性布局组件，它会分配内部所有的剩余空间
abstract class _ElFlexLayoutWidget extends ElLayoutWidget {
  const _ElFlexLayoutWidget({
    super.key,
    super.layoutKey,
    this.flex = 1,
    this.minFlex = 0.2,
  });

  /// 分配的空间比例，当 [ElLayout] 进行嵌套时，它会插入 [Expanded] 组件转变成弹性盒子，分配内部全部空间。
  ///
  /// 注意：[Expanded] 参数 [flex] 被指定为 int 类型，但拖拽百分比需要一个很精确的数字，
  /// 所以内部会对该值放大 1000 倍。
  final int flex;

  /// 拖拽时最小比例，范围(0.0 - 1.0)
  final double minFlex;
}

class ElLayout extends _ElFlexLayoutWidget {
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
  const ElLayout({
    super.key,
    required this.children,
    super.flex,
    super.minFlex,
    super.layoutKey,
  });

  /// Element UI 布局子类组件
  final List<ElLayoutWidget> children;

  /// 判断当前 [ElLayout] 排版方向是否是水平布局
  static bool isRow(BuildContext context) =>
      _ElLayoutInheritedWidget.of(context).isRow;

  /// 从当前上下文获取最近的 [ElLayout] 的 context 对象
  static BuildContext layoutContext(BuildContext context) =>
      _ElLayoutInheritedWidget.of(context).layoutContext;

  /// 设置拖拽组件的位置
  static void _setSplitOffset(BuildContext context, String layoutKey) {
    final $data = _ElLayoutInheritedWidget.of(context);
    if ($data.splitLayoutData?[layoutKey] == null) return;
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      final RenderBox renderObject = context.findRenderObject() as RenderBox;
      final offset = renderObject.localToGlobal(
        Offset.zero,
        ancestor: $data.layoutContext.findRenderObject(),
      );
      $data.splitLayoutData![layoutKey]!.offset.value = offset.dx;
    });
  }

  @override
  Widget build(BuildContext context) {
    assert(children.first is! ElLayoutSplit && children.last is! ElLayoutSplit,
        'ElLayoutSplit分割面板组件必须存在两个布局组件之间');

    bool isRow =
        children.any((e) => e is ElHeader || e is ElFooter || e is ElNavTab) ==
            false;
    late Widget currentWidget;
    Map<String, _SplitLayoutData>? splitLayoutData;
    _NotifyAllOffsetFun? notifyAllOffsetFun;

    // 处理嵌套的ElLayout，如果存在需要将其包裹在 Expanded 中，否则会报边界异常
    List<Widget> childrenWidget = children
        .map((e) => e is ElLayout ? Expanded(flex: flex, child: e) : e)
        .toList();

    if (isRow) {
      currentWidget = Row(children: childrenWidget);
    } else {
      assert(children.any((e) => e is ElAside) == false,
          'ElAside不可以和 ElHeader、ElFooter、ElNavTab 放在同一容器，请使用 ElLayout 包裹它们');
      currentWidget = Column(children: childrenWidget);
    }

    // 尝试构建分割组件，如果当前布局存在 ElLayoutSplit 组件，
    // 则将当前布局嵌套堆栈容器，然后依次添加分割拖拽控件。
    List<int> splitWidgetIndex = [];
    for (int i = 1; i < children.length - 1; i++) {
      if (children[i] is ElLayoutSplit) splitWidgetIndex.add(i);
    }
    if (splitWidgetIndex.isNotEmpty) {
      splitLayoutData = {};
      List<Widget> splitWidgets = [];
      if (isRow) {
        for (final index in splitWidgetIndex) {
          final splitWidget = children[index] as ElLayoutSplit;
          final previousWidget = children[index - 1];
          // 处理分割组件前面是侧边栏
          if (previousWidget is ElAside) {
            final layoutKey = previousWidget.getLayoutKey;
            splitWidgets.add(
              _SplitWidget(layoutKey: layoutKey, splitWidget: splitWidget),
            );
            splitLayoutData[layoutKey] = _RowSplitLayoutData(
              width: Obs(previousWidget.width),
              minWidth: previousWidget.minWidth,
              maxWidth: previousWidget.maxWidth,
              offset: Obs(0),
              size: splitWidget.size,
              triggerSize: splitWidget.triggerSize,
            );
          }
          // 处理分割组件前面是主页面或者是嵌套的布局页面
          else if (previousWidget is _ElFlexLayoutWidget) {
            final nextWidget = children[index + 1];
            // 下一个组件如果是侧边栏，那么分割组件逻辑要以侧边栏为主，但计算要从左侧开始
            if (nextWidget is ElAside) {
            }
            // 处理弹性布局页面之间的布局，缩小时会等比例缩小
            else {
              final layoutKey = previousWidget.getLayoutKey;
              splitWidgets.add(
                _SplitWidget(layoutKey: layoutKey, splitWidget: splitWidget),
              );
              splitLayoutData[layoutKey] = _FlexSplitLayoutData(
                flex: Obs(previousWidget.flex),
                minFlex: previousWidget.minFlex,
                offset: Obs(0),
                size: splitWidget.size,
                triggerSize: splitWidget.triggerSize,
              );
            }
          }
        }
        notifyAllOffsetFun = (layoutKey) {
          for (var key in splitLayoutData!.keys) {
            if (key != layoutKey) {
              (splitLayoutData[key]! as _RowSplitLayoutData).width.notify();
            }
          }
        };
      } else {
        for (final index in splitWidgetIndex) {
          if (children[index - 1] is ElHeader) {
            final headerWidget = children[index - 1] as ElHeader;
            final splitWidget = children[index] as ElLayoutSplit;
            final layoutKey = headerWidget.getLayoutKey;
            splitWidgets.add(
              _SplitWidget(layoutKey: layoutKey, splitWidget: splitWidget),
            );
            splitLayoutData[layoutKey] = _ColumnSplitLayoutData(
              height: Obs(headerWidget.height),
              minHeight: headerWidget.minHeight,
              maxHeight: headerWidget.maxHeight,
              offset: Obs(0),
              size: splitWidget.size,
              triggerSize: splitWidget.triggerSize,
            );
            notifyAllOffsetFun = (layoutKey) {
              for (var key in splitLayoutData!.keys) {
                if (key != layoutKey) {
                  (splitLayoutData[key]! as _ColumnSplitLayoutData)
                      .height
                      .notify();
                }
              }
            };
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
      isRow: isRow,
      layoutContext: context,
      splitLayoutData: splitLayoutData,
      notifyAllOffsetFun: notifyAllOffsetFun,
      child: currentWidget,
    );
  }
}

/// 注入布局数据
class _ElLayoutInheritedWidget extends InheritedWidget {
  const _ElLayoutInheritedWidget({
    required super.child,
    required this.isRow,
    required this.layoutContext,
    this.splitLayoutData,
    this.notifyAllOffsetFun,
  });

  /// 当前布局是否是水平布局
  final bool isRow;

  /// [ElLayout]的context
  final BuildContext layoutContext;

  /// 如果设置了分割界面组件，则会注入分割面板数据
  final Map<String, _SplitLayoutData>? splitLayoutData;

  /// 当拖拽某个分割组件时，通知其他所有的分割组件更新位置
  final _NotifyAllOffsetFun? notifyAllOffsetFun;

  static _ElLayoutInheritedWidget of(BuildContext context) {
    final _ElLayoutInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ElLayoutInheritedWidget>();
    assert(result != null, '当前上下文没有找到 ElLayout 组件，请将布局组件放置在 ElLayout 中');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElLayoutInheritedWidget oldWidget) => false;
}
