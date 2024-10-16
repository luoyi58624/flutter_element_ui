import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../element_extension.dart';

/// 延迟解除滚动中的限制时间，单位：毫秒
const int _unLockScrollingDelay = 200;

class ScrollPhysicsBuilder extends StatefulWidget {
  /// 滚动行为构造器，使用它构造的 [ScrollPhysics] 可以临时解决桌面端嵌套滚动容器滑动冲突问题
  const ScrollPhysicsBuilder({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  State<ScrollPhysicsBuilder> createState() => _ScrollPhysicsBuilderState();
}

class _ScrollPhysicsBuilderState extends State<ScrollPhysicsBuilder> {
  /// 阻止祖先滚动容器滚动
  bool _preventParent = false;

  /// 阻止后代滚动容器滚动
  bool _preventChild = false;

  /// 当前是否处于滚动中
  bool _isScrolling = false;

  /// 延迟解除滚动中的限制
  Timer? _unLockParentTimer;
  Timer? _unLockChildTimer;

  void _cancelUnLockParentTimer() {
    if (_unLockParentTimer != null) {
      _unLockParentTimer!.cancel();
      _unLockParentTimer = null;
    }
  }

  void _cancelUnLockChildTimer() {
    if (_unLockChildTimer != null) {
      _unLockChildTimer!.cancel();
      _unLockChildTimer = null;
    }
  }

  void _deepPreventParent(bool value) {
    _cancelUnLockParentTimer();
    _preventParent = value;
    _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(value);
  }

  /// 如果当前滚动容器处于滚动中，需要同时禁止祖先、子孙滚动容器的滚动，当滚动停止后，等待一定延迟后解除限制
  void handlerScrolling(PointerScrollEvent event) {
    final scrollPosition = widget.controller.position;
    if (scrollPosition.pixels > scrollPosition.minScrollExtent &&
        scrollPosition.pixels < scrollPosition.maxScrollExtent) {
      if (_isScrolling == false) {
        i('xx');
        _isScrolling = true;
        _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(true);
        // setState(() {
        //   _preventChild = true;
        // });
      }
      GestureBinding.instance.pointerSignalResolver.register(event, (event) {});
    } else {}

    _cancelUnLockParentTimer();
    _cancelUnLockChildTimer();
    _unLockParentTimer = setTimeout(() {
      _unLockParentTimer = null;
      _isScrolling = false;
      _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(false);
    }, _unLockScrollingDelay);
    _unLockChildTimer = setTimeout(() {
      _unLockChildTimer = null;
      _isScrolling = false;
      // setState(() {
      //   _preventChild = false;
      // });
    }, _unLockScrollingDelay);
  }

  @override
  Widget build(BuildContext context) {
    // 如果祖先不允许子孙滚动容器进行滚动，那么此变量将为 true
    bool preventChild =
        _PhysicsInheritedWidget.maybeOf(context)?.preventChild ?? false;

    return _PhysicsInheritedWidget(
      _preventParent,
      _preventChild || preventChild,
      _deepPreventParent,
      child: Listener(
        onPointerSignal: (e) {
          if (_preventParent == false) {
            if (e is PointerScrollEvent) {
              handlerScrolling(e);
            }
          }
        },
        child: widget.child,
      ),
    );
  }
}

class _PhysicsInheritedWidget extends InheritedWidget {
  const _PhysicsInheritedWidget(
    this.preventParent,
    this.preventChild,
    this.deepPreventParent, {
    required super.child,
  });

  /// 阻止祖先滚动容器滚动
  final bool preventParent;

  /// 阻止后代滚动容器滚动
  final bool preventChild;

  final void Function(bool value) deepPreventParent;

  static _PhysicsInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_PhysicsInheritedWidget>();

  @override
  bool updateShouldNotify(_PhysicsInheritedWidget oldWidget) => false;
}
