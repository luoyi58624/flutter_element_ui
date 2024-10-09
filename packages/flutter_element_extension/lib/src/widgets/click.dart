import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_dart/flutter_element_dart.dart';

class Click extends StatefulWidget {
  /// 点击事件小部件，它与 [GestureDetector] 不同在于，父组件的事件会被子组件的事件默认阻止，
  /// 而 [Click] 则不同，当子组件的点击事件触发时，父组件也会触发点击事件。
  const Click({
    super.key,
    required this.onClick,
    required this.child,
  });

  final VoidCallback onClick;
  final Widget child;

  /// 阻止事件冒泡，执行此函数会阻止祖先所有 [Click] 的点击事件
  static void stopPropagation(BuildContext context) {
    _ClickInheritedWidget._stopPropagation(context);
  }

  @override
  State<Click> createState() => _ClickState();
}

class _ClickState extends State<Click> {
  bool _flag = true;

  void _onTap() {
    if (_flag) widget.onClick();
  }

  void _stopPropagation() {
    _flag = false;
    _ClickInheritedWidget._stopPropagation(context);
  }

  void _reset() {
    if (!_flag) {
      setTimeout(() {
        _flag = true;
      }, 1);
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
        instance.onTap = _onTap;
        instance.onTapUp = (e) {
          _reset();
        };
        instance.onTapCancel = () {
          _reset();
        };
      },
    );

    return _ClickInheritedWidget(
      _stopPropagation,
      child: RawGestureDetector(
        gestures: gestures,
        child: widget.child,
      ),
    );
  }
}

class _ClickGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
    super.rejectGesture(pointer);
  }
}

class _ClickInheritedWidget extends InheritedWidget {
  const _ClickInheritedWidget(
    this.stopPropagation, {
    required super.child,
  });

  final VoidCallback stopPropagation;

  static void _stopPropagation(BuildContext context) {
    final _ClickInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ClickInheritedWidget>();
    if (result != null) {
      result.stopPropagation();
    }
  }

  @override
  bool updateShouldNotify(_ClickInheritedWidget oldWidget) {
    return false;
  }
}
