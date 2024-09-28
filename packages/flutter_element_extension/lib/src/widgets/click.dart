import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_extension/flutter_element_extension.dart';

/// 点击事件小部件，它与 [GestureDetector] 不同在于，即使手势竞争失败也依然会触发点击事件，
/// 同时，你可以
class Click extends StatefulWidget {
  const Click({
    super.key,
    required this.onClick,
    required this.child,
  });

  final VoidCallback onClick;
  final Widget child;

  /// 根据上下文阻止事件冒泡
  static void stopPropagation(BuildContext context) {
    _ClickInheritedWidget.of(context).stopPropagation();
  }

  @override
  State<Click> createState() => _ClickState();
}

class _ClickState extends State<Click> {
  bool _flag = true;

  void _onTap() {
    if (_flag) {
      widget.onClick();
    }
  }

  void _stopPropagation() {
    _flag = false;
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

  static _ClickInheritedWidget of(BuildContext context) {
    final _ClickInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ClickInheritedWidget>();
    assert(result != null, 'No _ClickInheritedWidget found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ClickInheritedWidget oldWidget) {
    return false;
  }
}
