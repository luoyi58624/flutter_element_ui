part of 'index.dart';

class ElStopPropagation extends InheritedWidget {
  /// 阻止事件冒泡小部件，它会在指针按下时立即触发，另一种方式是手动执行 context.stopPropagation()
  const ElStopPropagation({
    super.key,
    required super.child,
    this.enabled = true,
  });

  /// 是否启用阻止冒泡，默认 true
  final bool enabled;

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}

/// 捕获 [ElEvent] 事件冒泡小部件，这通常用于 [GestureDetector] 嵌套 [ElEvent] 时引发事件冒泡的场景。
///
/// 提示：这个小部件会引发 UI 重建（指针按下、指针抬起），不过绝大多数情况下你可以忽视这个问题，
/// 因为如果因为这个小部件造成卡顿，那么你应当考虑优化这个页面。
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
    // 找到最上层 ElBubbleBuilder 所在的位置，让从那个位置触发重建，确保只执行一次 setState
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
