import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

import 'abstract_animated.dart';

class ElAnimatedSize extends ElSingleAnimatedWidget {
  const ElAnimatedSize({
    super.key,
    required this.child,
    required super.duration,
    super.curve,
  });

  final Widget child;

  @override
  State<ElAnimatedSize> createState() => _ElAnimatedSizeState();
}

class _ElAnimatedSizeState extends ElSingleAnimatedWidgetState<ElAnimatedSize> {
  @override
  Widget build(BuildContext context) {
    return _AnimatedSize(
      controller: animationController,
      curvedAnimation: curvedAnimation,
      child: widget.child,
    );
  }
}

class _AnimatedSize extends SingleChildRenderObjectWidget {
  const _AnimatedSize({
    super.child,
    required this.controller,
    required this.curvedAnimation,
  });

  final AnimationController controller;
  final CurvedAnimation curvedAnimation;

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _Render(controller, curvedAnimation);
  }

  @override
  void updateRenderObject(BuildContext context, _Render renderObject) {
    renderObject.curvedAnimation = curvedAnimation;
  }
}

class _Render extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  _Render(this.controller, this._curvedAnimation) {
    controller.addListener(() {
      if (sizeAnimation != null) {
        animatedSize = sizeAnimation!.value;
        markNeedsLayout();
      }
    });
  }

  final AnimationController controller;
  CurvedAnimation _curvedAnimation;

  set curvedAnimation(CurvedAnimation v) {
    _curvedAnimation = v;
    markNeedsLayout();
  }

  Size? animatedSize;
  Size oldChildSize = Size.zero;
  Animation? sizeAnimation;

  @override
  bool hitTestSelf(Offset position) {
    return true;
  }

  @override
  void performLayout() {
    child!.layout(const BoxConstraints(), parentUsesSize: true);
    if (animatedSize == null) {
      animatedSize = child!.size;
      oldChildSize = child!.size;
    }
    if (child!.size != oldChildSize) {
      oldChildSize = child!.size;
      sizeAnimation = SizeTween(
        begin: animatedSize,
        end: child!.size,
      ).animate(_curvedAnimation);
      FlutterUtil.nextTick(() {
        controller.forward(from: 0);
      });
    }
    size = animatedSize!;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    context.paintChild(child as RenderObject, offset);
  }
}
