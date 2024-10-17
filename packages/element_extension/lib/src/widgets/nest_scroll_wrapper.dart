import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import '../../element_extension.dart';

const int _triggerParentDelay = 300;
const int _triggerChildDelay = 150;

class NestScrollWrapper extends StatefulWidget {
  /// 优化桌面端嵌套滚动，当鼠标指针滚动内部容器时，触顶、触底会添加一个阻尼效果，不会让事件立即扩散到外部滚动容器，
  /// 同时，滚动外部容器时，如果滚动没有停止，那么内部滚动容器不会立即响应事件。
  const NestScrollWrapper({
    super.key,
    required this.controller,
    required this.child,
  });

  final ScrollController controller;
  final Widget child;

  @override
  State<NestScrollWrapper> createState() => _NestScrollWrapperState();
}

class _NestScrollWrapperState extends State<NestScrollWrapper> {
  bool _preventChild = false;

  late bool _disabledUpScroll = _isScrollTop;
  late bool _disabledDownScroll = _isScrollBottom;

  Timer? _disabledUpScrollTimer;
  Timer? _disabledDownScrollTimer;

  Timer? _preventChildTimer;

  bool get _isScrollTop =>
      widget.controller.position.pixels <=
      widget.controller.position.minScrollExtent;

  bool get _isScrollBottom =>
      widget.controller.position.pixels >=
      widget.controller.position.maxScrollExtent;

  void _setPreventChild() {
    if (_preventChildTimer != null) {
      _preventChildTimer!.cancel();
      _preventChildTimer = null;
    }
    if (_preventChild == false) {
      setState(() {
        _preventChild = true;
      });
    }
    _preventChildTimer = setTimeout(() {
      _preventChildTimer = null;
      setState(() {
        _preventChild = false;
      });
    }, _triggerChildDelay);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring:
          _NestScrollWrapperInheritedWidget.maybeOf(context)?.preventChild ??
              false,
      child: _NestScrollWrapperInheritedWidget(
        _preventChild,
        child: Listener(
          onPointerSignal: (e) {
            // 这里的代码主要逻辑就是，首先区分用户是否是向上滚动、还是向下滚动，
            // 通过两个变量 _disabledUpScroll、_disabledDownScroll 判断当前滚动的容器是否已经到达临界点，
            // 如果到达临界点，则不允许通过 GestureBinding 注册事件，Listener 事件会以冒泡形式让上一级滚动容器接管指针滚动,
            // 最后如果是首次到达临界点，那么注册一个延迟函数，等待一段时间再修改滚动临界点变量，后续相同事件将重复上面的逻辑。
            if (e is PointerScrollEvent) {
              bool isUpScroll = e.scrollDelta.dy < 0;
              bool allowRegisterEvent = true;

              if (_disabledUpScroll) {
                if (isUpScroll) {
                  allowRegisterEvent = false;
                } else {
                  _disabledUpScroll = _isScrollTop;
                }
              } else {
                if (_isScrollTop && _disabledUpScrollTimer == null) {
                  _disabledUpScrollTimer = setTimeout(() {
                    _disabledUpScrollTimer = null;
                    _disabledUpScroll = true;
                  }, _triggerParentDelay);
                }
              }
              if (_disabledDownScroll) {
                if (!isUpScroll) {
                  allowRegisterEvent = false;
                } else {
                  _disabledDownScroll = _isScrollBottom;
                }
              } else {
                if (_isScrollBottom && _disabledDownScrollTimer == null) {
                  _disabledDownScrollTimer = setTimeout(() {
                    _disabledDownScrollTimer = null;
                    _disabledDownScroll = true;
                  }, _triggerParentDelay);
                }
              }
              if (allowRegisterEvent) {
                // 这段代码的意思是：注册第一个鼠标指针事件，排除其他事件，将鼠标指针事件限制在当前滚动容器内，
                // 如果当前的滚动容器到达临界点，那么这段代码将不会执行，鼠标指针事件将由上级滚动容器捕获。
                GestureBinding.instance.pointerSignalResolver
                    .register(e, (event) {});
              }
            }
          },
          child: NotificationListener<ScrollUpdateNotification>(
            onNotification: (e) {
              _setPreventChild();
              return true;
            },
            child: widget.child,
          ),
        ),
      ),
    );
  }
}

class _NestScrollWrapperInheritedWidget extends InheritedWidget {
  const _NestScrollWrapperInheritedWidget(
    this.preventChild, {
    required super.child,
  });

  /// 阻止后代滚动容器滚动
  final bool preventChild;

  static _NestScrollWrapperInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<
          _NestScrollWrapperInheritedWidget>();

  @override
  bool updateShouldNotify(_NestScrollWrapperInheritedWidget oldWidget) => true;
}
