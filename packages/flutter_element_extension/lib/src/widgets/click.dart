import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_extension/flutter_element_extension.dart';
import 'package:flutter_element_ui/flutter_element_ui.dart';

class Click extends StatefulWidget {
  /// 点击事件小部件，该小部件完全照抄 Web 的事件逻辑，它与 [GestureDetector] 不同在于，
  /// 父组件的 [GestureDetector] 会被子组件的 [GestureDetector] 默认阻止，
  /// 而 [Click] 则不同，当子组件的点击事件触发时，父组件也会触发点击事件，
  /// 同时，你可以通过 [stopPropagation] 静态方法阻止祖先默认的点击事件。
  ///
  /// 应用场景：当我们希望父组件的点击事件不被子组件的点击事件所覆盖时，[Click] 小部件将非常有用，
  /// 例如 [ElLink] 链接小部件，即使你包裹了 button 之类带有默认点击事件的小部件，
  /// 你依然可以直接触发默认的链接跳转，若你希望阻止这一行为，只需要在点击事件中添加
  /// Click.stopPropagation(context) 函数即可。
  const Click({
    super.key,
    required this.onClick,
    required this.child,
  });

  final VoidCallback onClick;
  final Widget child;

  /// 根据上下文阻止事件冒泡，它会阻止祖先所有 [Click] 的点击事件
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
    // 依次阻止祖先所有 Click 点击事件
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
