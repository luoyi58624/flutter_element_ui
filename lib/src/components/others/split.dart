import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

abstract class ElSplitWidget extends StatelessWidget {
  const ElSplitWidget({super.key});
}

abstract class ElSplitLayoutWidget extends ElSplitWidget {
  const ElSplitLayoutWidget({
    super.key,
    this.size,
    this.minSize,
    this.maxSize,
    this.flex = 1,
    this.cacheKey,
  });

  /// 布局默认尺寸，如果不传则填充所有空间
  final double? size;

  /// 最小尺寸
  final double? minSize;

  /// 最大尺寸
  final double? maxSize;

  /// 当 [size] 为空时生效，定义弹性盒子分配的空间比例
  final int flex;

  /// 持久化缓存key
  final String? cacheKey;

  /// 当前布局id
  String get id => cacheKey ?? hashCode.toString();
}

class ElSplitLayout extends ElSplitLayoutWidget {
  const ElSplitLayout({
    super.key,
    required this.children,
    this.axis = Axis.horizontal,
    super.size,
    super.minSize,
    super.maxSize,
  });

  /// 需要分割的子节点
  final List<ElSplitWidget> children;

  /// 布局方向
  final Axis axis;

  @override
  Widget build(BuildContext context) {
    assert(
        children.first is! ElSplitResizer && children.last is! ElSplitResizer,
        'ElSplitResizer分割布局组件必须在两个布局组件之间');
    final isHorizontal = axis == Axis.horizontal;
    Map<String, Obs<double>> splitLayoutOffset = {};
    var $children = children.map((e) {
      if (e is ElSplitLayoutWidget) {
        if (e.size == null) {
          return Expanded(flex: e.flex, child: e);
        } else {
          final size = Obs(e.size!);
          splitLayoutOffset[e.id] = size;
          return ObsBuilder(builder: (context) {
            return SizedBox(
              width: isHorizontal ? size.value : null,
              height: isHorizontal ? null : size.value,
              child: e,
            );
          });
        }
      }
      return e;
    }).toList();
    List<int> splitWidgetIndex = [];
    for (int i = 1; i < children.length - 1; i++) {
      if (children[i] is ElSplitResizer) splitWidgetIndex.add(i);
    }
    if (splitWidgetIndex.isNotEmpty) {
      for (final index in splitWidgetIndex) {
        final splitWidget = children[index] as ElSplitResizer;
        final previousWidget = children[index - 1];
        if (previousWidget is ElSplitLayoutWidget) {
          $children[index] = _ElSplitWidget(splitWidget, previousWidget.id);
        }
      }
    }
    return _ElSplitLayoutInheritedWidget(
      axis: axis,
      splitLayoutOffset: splitLayoutOffset,
      child: DeferredPointerHandler(
        child: axis == Axis.horizontal
            ? Row(children: $children)
            : Column(children: $children),
      ),
    );
  }
}

class ElSplitResizer extends ElSplitWidget {
  /// 分割布局组件，调整两个布局之间的尺寸
  const ElSplitResizer({
    super.key,
    this.size = 0,
    this.triggerSize = 6,
  });

  /// 控件占据页面的空间
  final double size;

  /// 可拖拽控件触发范围
  final double triggerSize;

  @override
  Widget build(BuildContext context) {
    return _ElSplitLayoutInheritedWidget.of(context).axis == Axis.horizontal
        ? SizedBox(width: size, height: double.infinity)
        : SizedBox(height: size, width: double.infinity);
  }
}

class _ElSplitWidget extends HookWidget {
  const _ElSplitWidget(this.child, this.layoutId);

  final ElSplitResizer child;
  final String layoutId;

  @override
  Widget build(BuildContext context) {
    final $data = _ElSplitLayoutInheritedWidget.of(context);
    final isActive = useObs(false);
    final isHorizontal = $data.axis == Axis.horizontal;
    final triggerSize = child.triggerSize;
    final triggerOffsetSize = -(triggerSize / 2);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        Positioned(
          top: isHorizontal ? 0 : triggerOffsetSize,
          bottom: isHorizontal ? 0 : triggerOffsetSize,
          left: isHorizontal ? triggerOffsetSize : 0,
          right: isHorizontal ? triggerOffsetSize : 0,
          child: DeferPointer(
            paintOnTop: true,
            child: GestureDetector(
              onHorizontalDragStart: (e) {
                isActive.value = true;
              },
              onHorizontalDragUpdate: (e) {
                if (isActive.value) {
                  $data.splitLayoutOffset[layoutId]!.value += e.delta.dx;
                }
              },
              onHorizontalDragEnd: (e) {
                isActive.value = false;
              },
              onHorizontalDragCancel: () {
                isActive.value = false;
              },
              child: HoverBuilder(
                cursor: SystemMouseCursors.resizeColumn,
                builder: (isHover) {
                  return ObsBuilder(builder: (context) {
                    return Container(
                      color: isActive.value ? Colors.cyan : null,
                    );
                  });
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ElSplitLayoutInheritedWidget extends InheritedWidget {
  const _ElSplitLayoutInheritedWidget({
    required super.child,
    required this.axis,
    required this.splitLayoutOffset,
  });

  /// 布局方向
  final Axis axis;

  /// 如果设置了分割界面组件，则会注入分割布局数据
  final Map<String, Obs<double>> splitLayoutOffset;

  static _ElSplitLayoutInheritedWidget of(BuildContext context) {
    final _ElSplitLayoutInheritedWidget? result = context
        .dependOnInheritedWidgetOfExactType<_ElSplitLayoutInheritedWidget>();
    assert(result != null, 'No _ElSplitLayoutInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElSplitLayoutInheritedWidget oldWidget) => true;
}
