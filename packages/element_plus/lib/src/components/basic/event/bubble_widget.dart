part of 'index.dart';

/// 阻止事件冒泡小部件，它会在指针按下时立即触发，如果你希望在其他时间点阻止事件冒泡（例如只阻止 onTap 但不阻止 onTapDown），
/// 你可以在 onTap 事件中执行 context.stopPropagation() 函数。
class ElStopPropagation extends InheritedWidget {
  const ElStopPropagation({
    super.key,
    required super.child,
  });

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}

/// 捕获 [ElEvent] 事件冒泡小部件，这通常用于 [GestureDetector] 嵌套 [ElEvent] 时引发事件冒泡的场景
class ElBubbleBuilder extends StatefulWidget {
  const ElBubbleBuilder({super.key, required this.builder});

  /// 构建小部件，回调参数为停止冒泡 bool 标识，如果为 true，意味着后代组件发出停止冒泡的信号
  final Widget Function(bool stopBubble) builder;

  @override
  State<ElBubbleBuilder> createState() => _ElBubbleBuilderState();
}

class _ElBubbleBuilderState extends State<ElBubbleBuilder> {
  bool? flag;

  void updateBubbleFlag(bool value) {
    if (_ElBubbleInheritedWidget.getWidget(context) != null) {
      _ElBubbleInheritedWidget._updateBubbleFlag(context, value);
    } else {
      if (flag != value) {
        setState(() {
          flag = value == true ? true : null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _ElBubbleInheritedWidget(
      flag: flag,
      updateBubbleFlag: updateBubbleFlag,
      child: widget
          .builder(_ElBubbleInheritedWidget.maybeOf(context) ?? flag ?? false),
    );
  }
}

class _ElBubbleInheritedWidget extends InheritedWidget {
  const _ElBubbleInheritedWidget({
    required super.child,
    required this.flag,
    required this.updateBubbleFlag,
  });

  final bool? flag;
  final ElBoolVoidCallback updateBubbleFlag;

  /// 执行 stopPropagation 时会寻找是否存在 [_ElBubbleInheritedWidget] 小部件，
  /// 如果存在，那么会将此标识符设置为 true，当指针释放时根据此标识重置状态。
  static bool triggerFlag = false;

  static bool? maybeOf(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<_ElBubbleInheritedWidget>()
      ?.flag;

  static _ElBubbleInheritedWidget? getWidget(BuildContext context) =>
      context.getInheritedWidgetOfExactType<_ElBubbleInheritedWidget>();

  static void _updateBubbleFlag(BuildContext context, bool value,
      [_ElBubbleInheritedWidget? widget]) {
    (widget ?? getWidget(context))?.updateBubbleFlag(value);
  }

  @override
  bool updateShouldNotify(_ElBubbleInheritedWidget oldWidget) =>
      flag != oldWidget.flag;
}
