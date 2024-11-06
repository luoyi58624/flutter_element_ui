part of 'index.dart';

class ElStopPropagation extends InheritedWidget {
  /// 阻止事件冒泡小部件
  const ElStopPropagation({
    super.key,
    required super.child,
  });

  /// 从当前上下文获取 [ElStopPropagation] 实例，并以 [ElStopPropagation] 实例所在 Element Tree 的位置执行阻止冒泡函数，
  /// 此函数由支持事件冒泡的小部件调用，并不需要暴露给用户
  static void _of(
    BuildContext context,
    void Function(BuildContext context) stopPropagation,
  ) {
    final result =
        context.getElementForInheritedWidgetOfExactType<ElStopPropagation>();
    if (result != null) stopPropagation(result);
  }

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}

abstract class _EventBubbleWidget extends StatefulWidget {
  /// 事件冒泡小部件抽象类
  const _EventBubbleWidget({super.key});

  /// 阻止事件冒泡，执行此函数会从当前持有的 context 开始，阻止上层祖先所有的点击事件（包括 onTapDown），
  /// 然后会在释放时自动重置。
  ///
  /// 提示：此函数不会引起 UI 重建，它只是更新一个 bool 标识，阻止上层点击事件的具体逻辑执行。
  static void stopPropagation(BuildContext context) {
    _EventBubbleInheritedWidget._stopPropagation(context);
  }
}

abstract class _EventBubbleWidgetState<T extends _EventBubbleWidget>
    extends State<T> {
  /// 一个标识，表示是否允许冒泡，若此属性为 false，则阻止当前所有类型的点击事件触发
  bool bubbleFlag = true;

  void _stopPropagation() {
    if (bubbleFlag) {
      bubbleFlag = false;
      _EventBubbleInheritedWidget._stopPropagation(context);
    }
  }

  void _resetPropagation() {
    if (!bubbleFlag) {
      bubbleFlag = true;
      _EventBubbleInheritedWidget._resetPropagation(context);
    }
  }

  void reset() {
    if (mounted) {
      final result =
          context.getInheritedWidgetOfExactType<_EventBubbleInheritedWidget>();
      if (result != null) {
        setTimeout(() {
          result.resetPropagation();
        }, 1);
      }
    }
  }

  Widget builder(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return _EventBubbleInheritedWidget(
      stopPropagation: _stopPropagation,
      resetPropagation: _resetPropagation,
      child: builder(context),
    );
  }
}

class _EventBubbleInheritedWidget extends InheritedWidget {
  const _EventBubbleInheritedWidget({
    required super.child,
    required this.stopPropagation,
    required this.resetPropagation,
  });

  final VoidCallback stopPropagation;
  final VoidCallback resetPropagation;

  static void _stopPropagation(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_EventBubbleInheritedWidget>();
    if (result != null) {
      result.stopPropagation();
    }
  }

  static void _resetPropagation(BuildContext context) {
    final result =
        context.getInheritedWidgetOfExactType<_EventBubbleInheritedWidget>();
    if (result != null) {
      result.resetPropagation();
    }
  }

  @override
  bool updateShouldNotify(_EventBubbleInheritedWidget oldWidget) => false;
}
