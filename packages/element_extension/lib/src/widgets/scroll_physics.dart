import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../element_extension.dart';

/// 延迟解除滚动中的限制时间，单位：毫秒
const int _unLockScrollingDelay = 150;

class ScrollPhysicsBuilder extends StatefulWidget {
  /// 滚动行为构造器，使用它构造的 [ScrollPhysics] 可以临时解决桌面端嵌套滚动容器滑动冲突问题
  const ScrollPhysicsBuilder({
    super.key,
    required this.builder,
    this.controller,
    this.mouseHorizontalScroll = false,
  });

  /// 子组件构造器，要想让此组件起作用，你需要将 physics 参数传递给滚动小部件
  final Widget Function(
    ScrollController controller,
    ScrollPhysics? physics,
  ) builder;

  /// 滚动控制器，如果为空则内部自动创建一个控制器
  final ScrollController? controller;

  /// 启用鼠标横向滚动监听，默认 false
  final bool mouseHorizontalScroll;

  @override
  State<ScrollPhysicsBuilder> createState() => _ScrollPhysicsBuilderState();
}

class _ScrollPhysicsBuilderState extends State<ScrollPhysicsBuilder> {
  late ScrollController _controller;

  /// 是否允许监听器的执行，当内部滚动容器开始滚动时，会阻止所有祖先的监听器
  bool _preventListener = false;

  /// 阻止祖先滚动容器滚动
  bool _preventParent = false;

  /// 阻止后代滚动容器滚动
  bool _preventChild = false;

  /// 当前是否处于滚动中
  bool _isScrolling = false;

  /// 延迟解除滚动中的限制
  Timer? _unLockParentTimer;
  Timer? _unLockChildTimer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.controller == null) {
      _controller.dispose();
    }
  }

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

  void _deepPreventListener(bool value) {
    _cancelUnLockParentTimer();
    _preventListener = value;
    _PhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(value);
  }

  void _deepPreventParent(bool value) {
    _cancelUnLockParentTimer();
    _preventParent = value;
    _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(value);
    setState(() {});
  }

  /// 如果当前滚动容器处于滚动中，需要同时禁止祖先、子孙滚动容器的滚动，当滚动停止后，等待一定延迟后解除限制
  void handlerScrolling() {
    _PhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(true);
    if (_controller.position.pixels != _controller.position.minScrollExtent &&
        _controller.position.pixels != _controller.position.maxScrollExtent) {
      if (_isScrolling == false) {
        _isScrolling = true;
        _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(true);
        setState(() {
          _preventChild = true;
        });
      }
    }
    _cancelUnLockParentTimer();
    _cancelUnLockChildTimer();
    _unLockParentTimer = setTimeout(() {
      _unLockParentTimer = null;
      _isScrolling = false;
      _PhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(false);
      _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(false);
    }, _unLockScrollingDelay);
    _unLockChildTimer = setTimeout(() {
      _unLockChildTimer = null;
      _isScrolling = false;
      setState(() {
        _preventChild = false;
      });
    }, _unLockScrollingDelay);
  }

  @override
  Widget build(BuildContext context) {
    // 如果祖先不允许子孙滚动容器进行滚动，那么此变量将为 true
    bool preventChild =
        _PhysicsInheritedWidget.maybeOf(context)?.preventChild ?? false;

    Widget result = widget.builder(
      _controller,
      _preventParent || preventChild
          ? const NeverScrollableScrollPhysics()
          : null,
    );

    result = Listener(
      onPointerSignal: (e) {
        if (e is PointerScrollEvent && _preventListener == false) {
          if (widget.mouseHorizontalScroll) {
            _controller.position.pointerScroll(e.scrollDelta.dy);
          } else {
            handlerScrolling();
          }
        }
      },
      child: result,
    );

    if (widget.mouseHorizontalScroll) {
      result = MouseRegion(
        onEnter: (e) {
          _PhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(true);
          _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(true);
        },
        onExit: (e) {
          _PhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(false);
          _PhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(false);
        },
        child: result,
      );
    }

    return _PhysicsInheritedWidget(
      _preventListener,
      _preventParent,
      _preventChild || preventChild,
      _deepPreventListener,
      _deepPreventParent,
      child: result,
    );
  }
}

class _PhysicsInheritedWidget extends InheritedWidget {
  const _PhysicsInheritedWidget(
    this.preventListener,
    this.preventParent,
    this.preventChild,
    this.deepPreventListener,
    this.deepPreventParent, {
    required super.child,
  });

  /// 阻止祖先滚动容器滚动
  final bool preventListener;

  /// 阻止祖先滚动容器滚动
  final bool preventParent;

  /// 阻止后代滚动容器滚动
  final bool preventChild;

  final void Function(bool value) deepPreventListener;
  final void Function(bool value) deepPreventParent;

  static _PhysicsInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_PhysicsInheritedWidget>();

  @override
  bool updateShouldNotify(_PhysicsInheritedWidget oldWidget) => true;
}
