import 'package:element_plus/src/global.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/widgets.dart';

part 'state.dart';

part 'model.dart';

class ElDrag extends StatefulWidget {
  const ElDrag({
    super.key,
    required this.child,
    this.feedback,
    this.rootOverlay = false,
    this.axis,
    this.triggerOffset = Offset.zero,
    this.delay,
    this.enabledAnimate = false,
    this.damping = 0.99,
    this.onDragDown,
    this.onDragStarted,
    this.onDragUpdate,
    this.onDragEnd,
    this.onDragCancel,
    this.onChanged,
  }) : assert(damping < 1.0);

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

  /// 是否开启动画，若为 true，拖拽结束时将触发惯性移动
  final bool enabledAnimate;

  /// 惯性移动阻力值，必须小于 1.0
  final double damping;

  /// 拖拽按下事件
  final GestureDragDownCallback? onDragDown;

  /// 拖拽开始事件
  final GestureDragStartCallback? onDragStarted;

  /// 拖拽更新事件
  final GestureDragUpdateCallback? onDragUpdate;

  /// 拖拽结束事件
  final GestureDragEndCallback? onDragEnd;

  /// 拖拽取消事件
  final GestureDragCancelCallback? onDragCancel;

  /// 拖拽偏移更新事件
  final ElDragChanged? onChanged;

  @override
  State<ElDrag> createState() => _ElDragState();
}
