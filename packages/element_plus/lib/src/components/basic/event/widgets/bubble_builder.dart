part of '../event.dart';

/// 捕获 [ElEvent] 事件冒泡小部件，这通常用于 [GestureDetector] 嵌套 [ElEvent] 时引发事件冒泡的场景。
///
/// 提示：这个小部件会引发 UI 重建（指针按下、指针抬起），一帧的重建不会引起性能问题。
class ElBubbleBuilder extends StatefulWidget {
  const ElBubbleBuilder({super.key, required this.builder});

  final Widget Function(BuildContext context) builder;

  /// 通过当前上下文访问祖先是否阻止了事件冒泡
  static bool of(BuildContext context) =>
      _BubbleInheritedWidget.maybeOf(context) ?? false;

  @override
  State<ElBubbleBuilder> createState() => _ElBubbleBuilderState();
}

class _ElBubbleBuilderState extends State<ElBubbleBuilder> {
  bool? flag;

  void updateBubbleFlag(bool value) {
    if (flag != value) {
      setState(() {
        flag = value == true ? true : null;
      });
    }
    _BubbleInheritedWidget._updateBubbleFlag(context, value);
  }

  @override
  Widget build(BuildContext context) {
    return _BubbleInheritedWidget(
      flag: flag,
      updateBubbleFlag: updateBubbleFlag,
      child: Builder(builder: (context) {
        return widget.builder(context);
      }),
    );
  }
}
