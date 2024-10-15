import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class ScrollPhysicsBuilder extends StatefulWidget {
  /// 滚动行为构造器，解决桌面端嵌套滚动容器滑动冲突问题
  const ScrollPhysicsBuilder({
    super.key,
    required this.builder,
    this.controller,
    this.mouseHorizontalScroll = false,
  });

  final Widget Function(
    ScrollController controller,
    ScrollPhysics? physics,
  ) builder;

  final ScrollController? controller;

  /// 鼠标横向滚动监听，默认 false
  final bool mouseHorizontalScroll;

  @override
  State<ScrollPhysicsBuilder> createState() => _ScrollPhysicsBuilderState();
}

class _ScrollPhysicsBuilderState extends State<ScrollPhysicsBuilder> {
  late ScrollController controller;

  ScrollPhysics? physics;

  /// 阻止祖先滚动容器滚动
  bool preventParent = false;

  /// 阻止后代滚动容器滚动
  bool preventChild = false;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? ScrollController();
  }

  void _deepPreventParent(bool value) {
    _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(value);
    setState(() {
      if (value) {
        physics = const NeverScrollableScrollPhysics();
      } else {
        physics = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget result = const SizedBox();
    result = widget.builder(controller, physics);
    if (widget.mouseHorizontalScroll) {
      result = Listener(
        onPointerSignal: (e) {
          if (e is PointerScrollEvent) {
            controller.position.pointerScroll(e.scrollDelta.dy);
          }
        },
        child: result,
      );
    }
    result = MouseRegion(
      onEnter: (e) {
        // if (_timer != null) {
        //   _timer!.cancel();
        //   _timer = null;
        // }
        _ScrollPhysicsInheritedWidget.maybeOf(context)?.deepPreventParent(true);
      },
      onExit: (e) {
        _ScrollPhysicsInheritedWidget.maybeOf(context)
            ?.deepPreventParent(false);
        // _timer = setTimeout(() {
        //   _timer = null;
        //   _ScrollPhysicsInheritedWidget.maybeOf(context)
        //       ?.deepPreventParent(false);
        // }, 16);
      },
      child: result,
    );
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
  bool updateShouldNotify(_ScrollPhysicsInheritedWidget oldWidget) => false;
}
