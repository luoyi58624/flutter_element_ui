part of 'index.dart';

/// 消息默认高度
const double _messageHeight = 40;

/// 消息之间的间距
const double _messageGap = 8;

/// 消息小部件，只负责处理消息显示、隐藏动画
class _MessageWidget extends StatefulWidget {
  const _MessageWidget(
    this.id,
    this.closeDuration,
    this.animationDuration,
    this.builder,
  );

  final int id;
  final Duration closeDuration;
  final Duration animationDuration;
  final ElMessageBuilder builder;

  @override
  State<_MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<_MessageWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> offsetAnimation; // 消息偏移动画
  late final Animation<double> opacityAnimation; // 消息透明动画
  late final ElMessageModel message;
  Timer? _removeTimer;
  GlobalKey messageKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // 通过id拿到消息列表中的对象
    message = el.message._messageList.firstWhere((e) => e.id == widget.id);
    // 初始化动画
    controller =
        AnimationController(vsync: this, duration: widget.animationDuration);
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
    double result = el.message._firstTopOffset!;
    for (final current in el.message._messageList) {
      if (current.id == widget.id) break;
      result += current._messageSize.value.height + _messageGap;
    }
    return result;
  }

  /// 设置移除消息计时器
  void setRemoveTimer() {
    _removeTimer ??= setTimeout(
      removeMessage,
      widget.closeDuration.inMilliseconds,
    );
  }

  /// 移除消息
  void removeMessage() async {
    if (!mounted || message._willRemove == true) return;
    // 标记此消息将被移除
    message._willRemove = true;
    // 执行移除动画
    controller.reverse();
    // 动画执行完毕后从列表中移除消息对象
    await widget.animationDuration.delay();
    message._overlayEntry.remove();
    message._overlayEntry.dispose();
    el.message._messageList.remove(message);
    // 如果所有消息都被弹出，则重置第一条消息的顶部位置
    if (el.message._messageList.isEmpty) el.message._firstTopOffset = null;
  }

  @override
  Widget build(BuildContext context) {
    // 绑定窗口尺寸变化监听，这样可以触发重新计算消息偏移布局
    MediaQuery.maybeSizeOf(context);

    // 设置当前消息的元素尺寸
    nextTick(() {
      message._messageSize.value = messageKey.currentContext!.size!;
    });

    return ObsBuilder(builder: (context) {
      return AnimatedPositioned(
        duration: widget.animationDuration,
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
                  child: ElEvent(
                    onEnter: (e) {
                      if (_removeTimer != null) {
                        _removeTimer!.cancel();
                        _removeTimer = null;
                      }
                    },
                    onExit: (e) {
                      setRemoveTimer();
                    },
                    builder: (context) => SizedBox(
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

/// 构建默认风格样式的消息小部件
ElMessageBuilder _defaultBuilder =
    (context, message) => _DefaultMessage(message);

/// Element UI 默认样式消息组件
class _DefaultMessage extends StatelessWidget {
  const _DefaultMessage(this.message);

  final ElMessageModel message;

  Widget get messageIcon {
    if (message.type == El.primary) return const ElIcon(ElIcons.platformEleme);
    if (message.type == El.success) return const ElIcon(ElIcons.success);
    if (message.type == El.warning) return const ElIcon(ElIcons.warning);
    if (message.type == El.error) return const ElIcon(ElIcons.error);
    return const ElIcon(ElIcons.info);
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = context.elThemeColors[message.type]!;
    double maxWidth = context.xs
        ? 250
        : context.sm
            ? 320
            : 450;
    double maxTextWidth = message.showClose ? maxWidth - 100 : maxWidth - 80;
    return SelectionArea(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: maxWidth,
          minHeight: _messageHeight,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: themeColor.themeLightBg(context),
          borderRadius: context.elConfig.cardRadius!,
          border: Border.all(color: themeColor.themeLightBorder(context)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElIconTheme(
              data: ElIconThemeData(color: themeColor),
              child: message.icon ?? messageIcon,
            ),
            const Gap(10),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxTextWidth,
              ),
              child: ElText(
                message.content,
                style: TextStyle(
                  color: context.isDark
                      ? context.darkTheme.textTheme.textStyle.color
                      : themeColor,
                  fontWeight: ElFont.medium,
                ),
              ),
            ),
            if (message.showClose) const Gap(10),
            if (message.showClose)
              ElIconTheme(
                data: ElIconThemeData(
                  color: context.elTheme.iconTheme.color!.withAlpha(150),
                  size: 16,
                ),
                child: ElCloseButton(
                  onTap: message.removeMessage,
                  cursor: SystemMouseCursors.click,
                  iconHoverColor: themeColor,
                  bgHoverColor: themeColor.elLight7(context),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

extension _MessageColorExtension on Color {
  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight8(context);
}
