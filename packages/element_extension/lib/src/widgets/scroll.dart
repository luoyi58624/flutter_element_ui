import 'dart:async';

import 'package:element_dart/element_dart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class ScrollWidget extends StatefulWidget {
  /// 滚动容器小部件，基于 [SingleChildScrollView] 小部件
  const ScrollWidget({
    super.key,
    required this.child,
    this.controller,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.padding,
    this.mouseHorizontalScroll = false,
  }) : _isCustomScroll = false;

  /// 自定义滚动容器
  const ScrollWidget.customScroll({
    super.key,
    required this.child,
    this.controller,
    this.mouseHorizontalScroll = false,
  })  : _isCustomScroll = true,
        scrollDirection = Axis.vertical,
        reverse = false,
        padding = null;

  final bool _isCustomScroll;
  final Widget child;
  final ScrollController? controller;
  final Axis scrollDirection;
  final bool reverse;
  final EdgeInsetsGeometry? padding;

  /// 鼠标横向滚动监听，默认 false；
  ///
  /// 注意：必须手动创建 controller 并绑定，否则运行会报错。
  final bool mouseHorizontalScroll;

  @override
  State<ScrollWidget> createState() => _ScrollWidgetState();
}

class _ScrollWidgetState extends State<ScrollWidget> {
  /// 阻止祖先滚动容器滚动
  bool preventParent = false;

  /// 阻止后代滚动容器滚动
  bool preventChild = false;

  Timer? _timer;

  void _deepPreventParent(bool value) {
    setState(() {
      preventParent = value;
    });
    _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(value);
  }

  @override
  Widget build(BuildContext context) {
    ScrollController? controller;
    if (widget.controller != null) {
      controller = widget.controller;
    } else {
      PrimaryScrollController.shouldInherit(context, widget.scrollDirection);
      controller = PrimaryScrollController.maybeOf(context);
    }

    Widget result = const SizedBox();
    result = widget.child;
    if (widget._isCustomScroll == false) {
      result = SingleChildScrollView(
        controller: controller,
        scrollDirection: widget.scrollDirection,
        reverse: widget.reverse,
        padding: widget.padding,
        child: result,
      );
    }

    result = ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        physics: preventParent || preventChild
            ? NeverScrollableScrollPhysics()
            : null,
      ),
      child: result,
    );
    if (widget.mouseHorizontalScroll && controller != null) {
      result = Listener(
        onPointerSignal: (e) {
          if (e is PointerScrollEvent) {
            controller!.position.pointerScroll(e.scrollDelta.dy);
            if (_timer != null) {
              _timer!.cancel();
              _timer = null;
            }
            _ScrollPhysicsInheritedWidget.maybeOf(context)
                ?.deepPreventParent(true);
            _timer = setTimeout(
              () {
                _timer = null;
                _ScrollPhysicsInheritedWidget.maybeOf(context)
                    ?.deepPreventParent(false);
              },
              16,
            );
          }
        },
        child: result,
      );
    }
    return _ScrollPhysicsInheritedWidget(
      preventParent,
      preventChild,
      _deepPreventParent,
      child: result,
    );
  }
}

class _ScrollPhysicsInheritedWidget extends InheritedWidget {
  const _ScrollPhysicsInheritedWidget(
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

  static _ScrollPhysicsInheritedWidget? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ScrollPhysicsInheritedWidget>();

  @override
  bool updateShouldNotify(_ScrollPhysicsInheritedWidget oldWidget) => true;
}
