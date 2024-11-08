import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

class ElDrag extends StatefulWidget {
  const ElDrag({
    super.key,
    required this.child,
    this.feedback,
    this.rootOverlay = false,
    this.axis,
    this.triggerOffset = const Offset(10, 10),
    this.delay,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDragEnd,
    this.onDragCancel,
  });

  /// 将一个小部件变为可拖拽
  final Widget child;

  /// 拖动时显示的小部件，如果为 null，则不会创建 [Overlay] 浮层
  final Widget? feedback;

  /// 拖拽的图像是否应用在最顶部的遮罩层，默认 false
  final bool rootOverlay;

  /// 限制拖拽的方向
  final Axis? axis;

  /// 触发拖拽的偏移幅度
  final Offset triggerOffset;

  /// 触发拖拽的延迟时间，如果延迟时间大于 0，那么 [triggerOffset] 偏移幅度检测将失效
  final Duration? delay;

  /// 拖拽开始事件
  final GestureDragStartCallback? onDragStarted;

  /// 拖拽更新事件
  final GestureDragUpdateCallback? onDragUpdate;

  /// 拖拽结束事件
  final GestureDragEndCallback? onDragEnd;

  /// 拖拽取消事件
  final GestureDragCancelCallback? onDragCancel;

  @override
  State<ElDrag> createState() => _ElDragState();
}
