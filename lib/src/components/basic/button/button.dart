part of flutter_element_ui;

class ElButton extends HookWidget {
  const ElButton(
    this.child, {
    super.key,
    this.onClick,
    this.style,
  });

  /// 支持任意类型子组件：
  /// * 如果是基础类型，则自动渲染为[Text]
  /// * 如果是[Widget]，则直接渲染
  final dynamic child;

  /// 点击事件
  final VoidCallback? onClick;

  /// 按钮样式
  final ElButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final $style = context.elConfig.buttonStyle.merge(style ?? ElButtonTheme.maybeOf(context));
    final currentWidget = ElHoverBuilder(
      disabled: $style.disabled!,
      builder: (isHover) => ElTapBuilder(
        onTap: onClick,
        disabled: $style.disabled!,
        delay: PlatformUtil.isDesktop ? 0 : 50,
        builder: (isTap) => _BaseButton(child, style: $style),
      ),
    );
    return $style.block!
        ? SizedBox(width: double.maxFinite, child: currentWidget)
        : UnconstrainedBox(child: currentWidget);
  }
}

class _BaseButton extends ElButton {
  const _BaseButton(super.child, {super.style});

  /// 文字按钮
  bool get isTextButton => DartUtil.isBaseType(child);

  /// 纯图标按钮
  bool get isIconButton => child is ElIcon;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useButtonStyle(context, style!);
    final buttonHeight = style!.height!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: buttonHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: style!.radius ?? BorderRadius.circular(style!.round! ? buttonHeight / 2 : 4),
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_ButtonStyle buttonStyle) {
    if (isTextButton) {
      return Text(
        child,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: buttonStyle.textColor,
        ),
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
        ),
      );
    } else if (isIconButton) {
      if (style!.circle!) {
        return const SizedBox();
      } else {
        return child;
      }
    } else {
      return const SizedBox();
    }
  }
}
