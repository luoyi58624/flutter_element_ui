part of flutter_element_ui;

const Duration _buttonAnimatedDuration = Duration(milliseconds: 100);

class ElButton2 extends HookWidget {
  const ElButton2(
    this.child, {
    super.key,
    this.onClick,
    this.type,
    this.text = false,
    this.plain = false,
    this.round = false,
    this.block = false,
    this.icon,
    this.rightIcon,
    this.circle = false,
    this.disabled = false,
  });

  /// 支持任意类型子组件，如果是基础类型，则自动渲染为[Text]，如果是[Widget]，则直接渲染，如果为 null，则不做渲染
  final dynamic child;

  /// 点击事件
  final VoidCallback? onClick;

  /// 主题类型
  final ElThemeType? type;

  /// 文字按钮
  final bool text;

  /// 镂空按钮
  final bool plain;

  /// 圆角按钮
  final bool round;

  /// 块级按钮，宽度会充满容器
  final bool block;

  /// 按钮图标，如果[child]为空，则渲染为按钮图标
  final ElIcon? icon;

  /// 按钮右图标，[child]不能为空，否则抛出异常
  final ElIcon? rightIcon;

  /// 圆形图标按钮，仅设置了[icon]属性生效
  final bool circle;

  /// 禁用按钮
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    final currentWidget = HoverBuilder(
      disabled: disabled,
      builder: (isHover) => TapBuilder(
        onTap: onClick,
        disabled: disabled,
        delay: PlatformUtil.isDesktop ? 0 : 50,
        builder: (isTap) => text
            ? _TextButton(child, type: type, round: round, block: block, disabled: disabled)
            : _BaseButton(
                child,
                type: type,
                plain: plain,
                round: round,
                block: block,
                icon: icon,
                rightIcon: rightIcon,
                circle: circle,
                disabled: disabled,
              ),
      ),
    );
    return block ? SizedBox(width: double.maxFinite, child: currentWidget) : UnconstrainedBox(child: currentWidget);
  }
}

class _BaseButton extends ElButton2 {
  const _BaseButton(
    super.child, {
    super.type,
    super.plain,
    super.round,
    super.block,
    super.icon,
    super.rightIcon,
    super.circle,
    super.disabled,
  });

  /// 文字按钮
  bool get isTextButton => DartUtil.isBaseType(child);

  /// 纯图标按钮
  bool get isIconButton => child == null && icon != null;

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useBaseButtonStyle(context, type: type, plain: plain, disabled: disabled);
    final buttonHeight = context.elConfig.buttonHeight;
    return AnimatedContainer(
      duration: _buttonAnimatedDuration,
      height: buttonHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: BorderRadius.circular(round ? buttonHeight / 2 : context.elConfig.buttonRadius),
      ),
      child: buildChild(buttonStyle),
    );
  }

  Widget buildChild(_BaseButtonStyle buttonStyle) {
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
      if (circle) {
        return const SizedBox();
      } else {
        return icon!;
      }
    } else {
      return const SizedBox();
    }
  }
}

class _TextButton extends ElButton2 {
  const _TextButton(super.child, {super.type, super.round, super.block, super.disabled});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useTextButtonStyle(context, type: type, disabled: disabled);
    final buttonHeight = context.elConfig.buttonHeight;
    return AnimatedContainer(
      duration: _buttonAnimatedDuration,
      height: buttonHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: buttonHeight / 2),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        borderRadius: BorderRadius.circular(round ? buttonHeight / 2 : context.elConfig.buttonRadius),
      ),
      child: Text(
        child,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: buttonStyle.textColor,
        ),
        strutStyle: const StrutStyle(
          forceStrutHeight: true,
        ),
      ),
    );
  }
}
