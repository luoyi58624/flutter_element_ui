import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../element_extension.dart';

/// 延迟解除滚动中的限制时间，单位：毫秒
const int _unLockScrollingDelay = 200;

class ScrollPhysicsBuilder extends StatefulWidget {
  /// 滚动行为构造器，使用它构造的 [ScrollPhysics] 可以解决桌面端嵌套滚动容器滑动冲突问题
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

  /// 自定义滚动控制器，如果为空则内部自动创建一个控制器
  final ScrollController? controller;

  /// 鼠标横向滚动监听，默认 false
  final bool mouseHorizontalScroll;

  @override
  State<ScrollPhysicsBuilder> createState() => _ScrollPhysicsBuilderState();
}

class _ScrollPhysicsBuilderState extends State<ScrollPhysicsBuilder> {
  late ScrollController _controller;

  ScrollPhysics? _physics;

  /// 是否允许监听器的执行，当内部滚动容器开始滚动时，会阻止所有祖先的监听器
  bool _preventListener = false;

  /// 阻止祖先滚动容器滚动
  bool _preventParent = false;

  /// 阻止后代滚动容器滚动
  bool _preventChild = false;

  /// 当前是否处于滚动中
  bool _isScrolling = false;

  /// 延迟解除滚动中的限制
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? ScrollController();
  }

  void _cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  void _deepPreventListener(bool value) {
    _cancelTimer();
    _preventListener = value;
    _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(value);
  }

  void _deepPreventParent(bool value) {
    _cancelTimer();
    if (value) {
      _physics = const NeverScrollableScrollPhysics();
    } else {
      _physics = null;
    }
    _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(value);
    setState(() {});
  }

  /// 如果当前滚动容器处于滚动中，需要同时禁止祖先、子孙滚动容器的滚动，当滚动停止后，等待一定延迟后解除限制
  void handlerScrolling() {
    _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventListener(true);
    if (_controller.position.pixels != _controller.position.minScrollExtent &&
        _controller.position.pixels != _controller.position.maxScrollExtent) {
      if (_isScrolling == false) {
        _isScrolling = true;
        _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(true);
      }
    }
    _cancelTimer();
    _timer = setTimeout(() {
      _timer = null;
      _isScrolling = false;
      _ScrollPhysicsInheritedWidget.maybeOf(context)
          ?.deepPreventListener(false);
      _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(false);
    }, _unLockScrollingDelay);
  }

  @override
  Widget build(BuildContext context) {
    bool preventChild = _preventChild;
    if (preventChild == false) {
      preventChild =
          _ScrollPhysicsInheritedWidget.maybeOf(context)?.preventChild ?? false;
    }
    Widget result = widget.builder(_controller, _physics);

    result = Listener(
      onPointerSignal: (e) {
        if (_preventListener == false && e is PointerScrollEvent) {
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
          _ScrollPhysicsInheritedWidget.maybeOf(context)
              ?.deepPreventListener(true);
          _ScrollPhysicsInheritedWidget.maybeOf(context)
              ?.deepPreventParent(true);
        },
        onExit: (e) {
          _ScrollPhysicsInheritedWidget.maybeOf(context)
              ?.deepPreventListener(false);
          _ScrollPhysicsInheritedWidget.maybeOf(context)
              ?.deepPreventParent(false);
        },
        child: result,
      );
    }

    return _ScrollPhysicsInheritedWidget(
      _preventListener,
      _preventParent,
      _preventChild,
      _deepPreventListener,
      _deepPreventParent,
      child: result,
    );
  }
}

class _ScrollPhysicsInheritedWidget extends InheritedWidget {
  const _ScrollPhysicsInheritedWidget(
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

  static _ScrollPhysicsInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ScrollPhysicsInheritedWidget>();

  @override
  bool updateShouldNotify(_ScrollPhysicsInheritedWidget oldWidget) => true;
}
