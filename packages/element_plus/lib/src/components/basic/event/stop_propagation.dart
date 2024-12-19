part of 'event.dart';

/// 阻止事件冒泡小部件
class ElStopPropagation extends StatelessWidget {
  const ElStopPropagation({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) {
        _EventInheritedWidget.stopPropagation(context);

        // 查找是否存在 ElBubbleBuilder 小部件，如果有那么需要通知它的回调
        final result = _BubbleInheritedWidget.getWidget(context);
        if (result != null) {
          _BubbleInheritedWidget.triggerFlag = true;
          _BubbleInheritedWidget._updateBubbleFlag(context, true, result);
        }
      },
      child: child,
    );
  }
}
