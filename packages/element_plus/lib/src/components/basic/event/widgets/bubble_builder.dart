part of '../index.dart';

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
    if (_BubbleInheritedWidget.getWidget(context) != null) {
      _BubbleInheritedWidget._updateBubbleFlag(context, value);
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
    return _BubbleInheritedWidget(
      flag: flag,
      updateBubbleFlag: updateBubbleFlag,
      child: widget
          .builder(_BubbleInheritedWidget.maybeOf(context) ?? flag ?? false),
    );
  }
}
