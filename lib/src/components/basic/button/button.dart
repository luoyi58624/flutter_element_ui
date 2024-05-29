part of flutter_element_ui;

class ElButton2 extends HookWidget {
  const ElButton2(
    this.data, {
    super.key,
    this.onClick,
    this.type,
    this.text = false,
    this.plain = false,
    this.round = false,
    this.circle = false,
    this.disabled = false,
  });

  /// 文字
  final String data;

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

  /// 圆形按钮
  final bool circle;

  /// 禁用按钮
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElHoverBuilder(
      builder: (isHover) => ElTapBuilder(
        onTap: onClick,
        builder: (isTap) => text ? _TextButton(data, type: type) : _BaseButton(data, type: type),
      ),
    );
  }
}

class _BaseButton extends ElButton2 {
  const _BaseButton(super.data, {super.type});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useBaseButtonStyle(context, type: type);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: context.elConfig.buttonHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: context.elConfig.buttonHorizontal),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        border: buttonStyle.border,
        borderRadius: BorderRadius.circular(context.elConfig.buttonRadius),
      ),
      child: Text(
        data,
        style: TextStyle(
          color: buttonStyle.textColor,
        ),
      ),
    );
  }
}

class _TextButton extends ElButton2 {
  const _TextButton(super.data, {super.type});

  @override
  Widget build(BuildContext context) {
    final buttonStyle = _useTextButtonStyle(context, type: type);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      height: context.elConfig.buttonHeight,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: context.elConfig.buttonHorizontal),
      decoration: BoxDecoration(
        color: buttonStyle.bgColor,
        borderRadius: BorderRadius.circular(context.elConfig.buttonRadius),
      ),
      child: Text(
        data,
        style: TextStyle(
          color: buttonStyle.textColor,
        ),
      ),
    );
  }
}
