import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:element_dart/element_dart.dart';

class TapWidget extends StatefulWidget {
  /// 此组件的默认行为是允许点击事件冒泡，子组件默认情况下不会阻止父组件的点击事件，
  /// 相反，此组件提供 [stopPropagation] 函数让用户手动阻止冒泡行为。
  const TapWidget({
    super.key,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    required this.child,
  });

  final GestureTapCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final Widget child;

  /// 阻止事件冒泡，执行此函数会阻止祖先所有 [TapWidget] 的点击事件
  static void stopPropagation(BuildContext context) {
    _TapInheritedWidget._stopPropagation(context);
  }

  @override
  State<TapWidget> createState() => _TapWidgetState();
}

class _TapWidgetState extends State<TapWidget> {
  bool _flag = true;

  void _onTap() {
    if (_flag) {
      if (widget.onTap != null) widget.onTap!();
    }
  }

  void _onTapDown(TapDownDetails e) {
    if (_flag) {
      if (widget.onTapDown != null) widget.onTapDown!(e);
    }
  }

  void _onTapUp(TapUpDetails e) {
    _reset();
    if (_flag) {
      if (widget.onTapUp != null) widget.onTapUp!(e);
    }
  }

  void _onTapCancel() {
    _reset();
    if (_flag) {
      if (widget.onTapCancel != null) widget.onTapCancel!();
    }
  }

  void _stopPropagation() {
    _flag = false;
    _TapInheritedWidget._stopPropagation(context);
  }

  void _reset() {
    if (!_flag) {
      setTimeout(() {
        _flag = true;
      }, 16);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<Type, GestureRecognizerFactory> gestures =
        <Type, GestureRecognizerFactory>{};

    gestures[_ClickGestureRecognizer] =
        GestureRecognizerFactoryWithHandlers<_ClickGestureRecognizer>(
      () => _ClickGestureRecognizer(),
      (instance) {
        instance
          ..onTapDown = _onTapDown
          ..onTap = _onTap
          ..onTapUp = _onTapUp
          ..onTapCancel = _onTapCancel;
      },
    );

    return _TapInheritedWidget(
      _stopPropagation,
      child: RawGestureDetector(
        gestures: gestures,
        child: widget.child,
      ),
    );
  }
}

class _ClickGestureRecognizer extends TapGestureRecognizer {
  /// 重写点击拒绝事件，将拒绝变为允许
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    super.rejectGesture(pointer);
  }
}

class _TapInheritedWidget extends InheritedWidget {
  const _TapInheritedWidget(
    this.stopPropagation, {
    required super.child,
  });

  final VoidCallback stopPropagation;

  static void _stopPropagation(BuildContext context) {
    final _TapInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_TapInheritedWidget>();
    if (result != null) {
      result.stopPropagation();
    }
  }

  @override
  bool updateShouldNotify(_TapInheritedWidget oldWidget) => false;
}
