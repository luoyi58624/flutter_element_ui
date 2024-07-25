part of 'message.dart';

/// 构建默认风格样式的消息小部件，模仿以下代码，你可以非常轻松地自定义各种外观
ElMessageBuilder _defaultBuilder =
    (context, message) => ElDefaultMessage(message);

/// Element UI 默认样式消息组件
class ElDefaultMessage extends StatelessWidget {
  const ElDefaultMessage(this.message, {super.key});

  final ElMessage message;

  Widget get messageIcon {
    if (message.type == 'primary') return const ElIcon(ElIcons.elemeFilled);
    if (message.type == 'success') return const ElIcon(ElIcons.successFilled);
    if (message.type == 'warning') return const ElIcon(ElIcons.warningFilled);
    if (message.type == 'error') return const ElIcon(ElIcons.circleCloseFilled);
    return const ElIcon(ElIcons.infoFilled);
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
    return Container(
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
        borderRadius: el.config.cardRadius,
        border: Border.all(color: themeColor.themeLightBorder(context)),
      ),
      child: ElIconTheme(
        color: themeColor,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            messageIcon,
            const Gap(10),
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: maxTextWidth,
              ),
              child: SelectableText(
                message.content,
                style: TextStyle(
                  color: context.isDark ? el.darkTheme.textColor : themeColor,
                  fontWeight: ElFont.medium,
                ),
              ),
            ),
            if (message.showClose) const Gap(10),
            if (message.showClose)
              GestureDetector(
                onTap: () {
                  message.removeMessage();
                },
                child: HoverBuilder(
                  cursor: SystemMouseCursors.click,
                  builder: (context) {
                    return ElIcon(
                      ElIcons.close,
                      color: HoverBuilder.of(context)
                          ? themeColor
                          : context.isDark
                              ? Colors.grey.shade600
                              : Colors.grey.shade400,
                    );
                  },
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
  Color themeLightBg(BuildContext context) => light9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => light8(context);
}
