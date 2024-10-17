import 'package:element_extension/element_extension.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class NullWidget extends StatelessWidget {
  const NullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'ElNullWidget 通常用于 mixin 混入，子类如果没有执行 super.build 函数将抛出此异常',
    );
  }
}

class ChildIndexData extends InheritedWidget {
  /// 一个功能小部件，让迭代的列表子元素确认自身所在的位置
  const ChildIndexData({
    super.key,
    required super.child,
    required this.index,
    this.start,
    this.end,
    this.length,
  });

  /// 当前索引
  final int index;

  /// 迭代元素起始索引，非必需，使用前请确认是否注入
  final int? start;

  /// 迭代元素结束索引，非必需，使用前请确认是否注入
  final int? end;

  /// 迭代元素总长度，非必需，使用前请确认是否注入
  final int? length;

  static ChildIndexData? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ChildIndexData>();

  static ChildIndexData of(BuildContext context) {
    final ChildIndexData? result = maybeOf(context);
    assert(result != null, 'No ChildIndexData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ChildIndexData oldWidget) => true;
}

class GridWidget extends StatelessWidget {
  /// 网格小部件
  const GridWidget({
    super.key,
    required this.size,
    required this.itemCount,
    this.borderRadius,
    this.borderColor,
    required this.itemBuilder,
    this.controller,
    this.shrinkWrap = false,
  });

  /// 网络小部件数量
  final int itemCount;

  /// 构建每个网格小部件
  final NullableIndexedWidgetBuilder itemBuilder;

  /// 单个网格尺寸
  final double size;

  /// 网格容器边框圆角
  final BorderRadiusGeometry? borderRadius;

  /// 边框颜色
  final Color? borderColor;

  /// 滚动控制器
  final ScrollController? controller;

  /// 如果网格小部件嵌套在滚动视图中，你需要将它设置为 true 才能工作
  final bool shrinkWrap;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final rowCount = (constraints.maxWidth / 125).floor();
      int bottomBorderIndex = itemCount % rowCount;
      bottomBorderIndex =
          itemCount - (bottomBorderIndex == 0 ? rowCount : bottomBorderIndex);
      late BorderSide defaultBorder;
      if (borderColor != null) {
        defaultBorder = BorderSide(
          color: borderColor!,
        );
      } else {
        defaultBorder = BorderSide.none;
      }
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: borderRadius,
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                )
              : const Border(),
        ),
        child: GridView.count(
          controller: controller,
          crossAxisCount: rowCount,
          shrinkWrap: shrinkWrap,
          physics: const ScrollPhysics(),
          children: List.generate(
            itemCount,
            (index) {
              BorderSide rightBorder = BorderSide.none;
              BorderSide bottomBorder = BorderSide.none;
              if (index % rowCount != rowCount - 1) {
                rightBorder = defaultBorder;
              }
              if (index < bottomBorderIndex) {
                bottomBorder = defaultBorder;
              }
              return Container(
                decoration: BoxDecoration(
                  border: Border(
                    right: rightBorder,
                    bottom: bottomBorder,
                  ),
                ),
                child: itemBuilder(context, index),
              );
            },
          ),
        ),
      );
    });
  }
}

class DragStartListener extends ReorderableDragStartListener {
  /// 识别长按拖拽小部件，通常用于拖拽列表
  const DragStartListener({
    super.key,
    required super.child,
    required super.index,
    super.enabled,
    this.delay,
  });

  /// 自定义长按触发延迟，默认情况下：桌面端 200 毫秒，移动端 500 毫秒
  final Duration? delay;

  @override
  MultiDragGestureRecognizer createRecognizer() {
    return DelayedMultiDragGestureRecognizer(
      debugOwner: this,
      delay: delay ??
          (PlatformUtil.isDesktop
              ? const Duration(milliseconds: 200)
              : const Duration(milliseconds: 500)),
    );
  }
}

class HorizontalScrollWidget extends StatelessWidget {
  /// 支持鼠标水平滚动小部件，只有在桌面端才会构建
  const HorizontalScrollWidget({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PlatformUtil.isDesktop
        ? Listener(
            onPointerSignal: (e) {
              if (e is PointerScrollEvent) {
                GestureBinding.instance.pointerSignalResolver.register(e,
                    (event) {
                  controller.position.pointerScroll(e.scrollDelta.dy);
                });
              }
            },
            child: child,
          )
        : child;
  }
}
