part of 'message.dart';

/// 封装消息提示队列显示、隐藏、以及交互
class _Message extends StatefulWidget {
  const _Message(
    this.id,
    this.messageDuration,
    this.animationDuration,
    this.builder,
  );

  final int id;
  final int messageDuration;
  final int animationDuration;
  final ElMessageBuilder builder;

  @override
  State<_Message> createState() => _MessageState();
}

class _MessageState extends State<_Message>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> offsetAnimation;
  late final Animation<double> opacityAnimation;
  late final ElMessage message;
  Timer? _removeTimer;
  GlobalKey messageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 通过id拿到消息列表中的对象
    message = $el._messageList.firstWhere((e) => e.id == widget.id);
    // 初始化动画
    controller =
        AnimationController(vsync: this, duration: widget.animationDuration.ms);
    offsetAnimation = Tween<double>(begin: -_messageHeight, end: 0).animate(
        CurvedAnimation(parent: controller, curve: const Cubic(0, 0, 0.2, 1)));
    opacityAnimation = Tween<double>(begin: 0, end: 1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
    controller.forward();
    // 设置移除消息计时器
    setRemoveTimer();
    // 监听分组消息，如果发生变化重置计时器
    message._groupCount.addListener(() {
      _removeTimer!.cancel();
      _removeTimer = null;
      setRemoveTimer();
    });
    message.removeMessage = removeMessage;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// 计算当前消息在页面中的位置
  double get topOffset {
    double result = $el._firstTopOffset!;
    for (final current in $el._messageList) {
      if (current.id == widget.id) break;
      result += current._messageSize.value.height + _messageGap;
    }
    return result;
  }

  /// 设置移除消息计时器
  void setRemoveTimer() {
    _removeTimer ??= removeMessage.delay(widget.messageDuration);
  }

  /// 移除消息
  void removeMessage() async {
    if (!mounted || message._willRemove == true) return;
    // 标记此消息将被移除
    message._willRemove = true;
    // 执行移除动画
    controller.reverse();
    // 动画执行完毕后从列表中移除消息对象
    await widget.animationDuration.ms.delay();
    message._overlayEntry.remove();
    $el._messageList.remove(message);
    // 如果所有消息都被弹出，则重置第一条消息的顶部位置
    if ($el._messageList.isEmpty) $el._firstTopOffset = null;
  }

  @override
  Widget build(BuildContext context) {
    // 设置当前消息的元素尺寸
    ElUtil.nextTick(() {
      message._messageSize.value = messageKey.currentContext!.size!;
    });

    return ObsBuilder(builder: (context) {
      return AnimatedPositioned(
        duration: widget.animationDuration.ms,
        top: MediaQuery.paddingOf(context).top + topOffset,
        left: 0,
        right: 0,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, offsetAnimation.value),
              child: Opacity(
                opacity: opacityAnimation.value,
                child: UnconstrainedBox(
                  child: ElHover(
                    onlyCursor: true,
                    onEnter: (e) {
                      if (_removeTimer != null) {
                        _removeTimer!.cancel();
                        _removeTimer = null;
                      }
                    },
                    onExit: (e) {
                      setRemoveTimer();
                    },
                    builder: (isHover) => SizedBox(
                      key: messageKey,
                      child: ObsBuilder(
                        builder: (context) {
                          return ElBadge(
                            badge: message._groupCount.value,
                            child: widget.builder(context, message),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
