part of flutter_element_ui;

enum _ButtonType { base, text, icon }

const double _defaultRadius = 4;

class ElButton extends StatefulWidget {
  /// 渲染普通按钮
  const ElButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.type,
    this.plain = false,
    this.round = false,
  })  : _buttonType = _ButtonType.base,
        text = null,
        icon = null,
        circle = false,
        size = 0;

  /// 渲染文字按钮
  const ElButton.text({
    super.key,
    required this.onPressed,
    required this.text,
    this.type,
  })  : _buttonType = _ButtonType.text,
        child = null,
        icon = null,
        plain = false,
        round = false,
        circle = false,
        size = 0;

  /// 渲染图标按钮
  const ElButton.icon({
    super.key,
    required this.onPressed,
    required this.icon,
    this.type,
    this.circle = false,
    this.size = 32,
  })  : _buttonType = _ButtonType.icon,
        child = null,
        text = null,
        round = false,
        plain = false;

  final _ButtonType _buttonType;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final IconData? icon;
  final ElThemeType? type;

  /// 朴素按钮
  final bool plain;

  /// 圆角按钮
  final bool round;

  /// 是否将图标按钮设置为圆形
  final bool circle;

  /// 图标按钮尺寸
  final double size;

  @override
  State<ElButton> createState() => _ElButtonState();
}

class _ElButtonState extends State<ElButton> {
  bool _onHover = false;
  bool _onTap = false;

  @override
  Widget build(BuildContext context) {
    late Widget buttonWidget;
    switch (widget._buttonType) {
      case _ButtonType.base:
        assert(widget.child != null, 'child不能为null');
        buttonWidget = _BaseButton(
          onPressed: widget.onPressed,
          onHover: _onHover,
          onTap: _onTap,
          type: widget.type,
          plain: widget.plain,
          round: widget.round,
          child: widget.child!,
        );
        break;
      case _ButtonType.text:
        assert(widget.text != null && widget.text != '', 'text不能为null或空字符串');
        break;
      case _ButtonType.icon:
        assert(widget.icon != null, 'icon不能为null');
        buttonWidget = _IconButton(
          onPressed: widget.onPressed,
          onHover: _onHover,
          onTap: _onTap,
          type: widget.type,
          icon: widget.icon!,
          circle: widget.circle,
          size: widget.size,
        );
        break;
    }
    return MouseRegion(
      onEnter: widget.onPressed != null
          ? (e) {
              setState(() {
                _onHover = true;
              });
            }
          : null,
      onExit: widget.onPressed != null
          ? (e) {
              setState(() {
                _onHover = false;
              });
            }
          : null,
      cursor: widget.onPressed != null ? SystemMouseCursors.click : SystemMouseCursors.forbidden,
      child: GestureDetector(
        onTapDown: widget.onPressed != null
            ? (e) {
                setState(() {
                  _onTap = true;
                });
              }
            : null,
        onTapCancel: widget.onPressed != null
            ? () {
                setState(() {
                  _onTap = false;
                });
              }
            : null,
        onTap: widget.onPressed != null
            ? () {
                setState(() {
                  _onTap = false;
                });
                widget.onPressed!();
              }
            : null,
        child: buttonWidget,
      ),
    );
  }
}

class _BaseButton extends _DesktopEventWidget {
  const _BaseButton({
    required super.onPressed,
    required super.onHover,
    required super.onTap,
    required this.child,
    this.type,
    required this.plain,
    required this.round,
  });

  final Widget child;
  final ElThemeType? type;
  final bool plain;
  final bool round;

  double get roundValue => round ? 9999 : _defaultRadius;

  @override
  Widget build(BuildContext context) {
    return type == null ? buildDefaultButton(context) : buildThemeButton(context);
  }

  Widget buildDefaultButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color? backgroundColor;
    Color borderColor = ElApp.of(context).theme.defaultBorderColor;
    if (onPressed == null) {
      borderColor = borderColor.withOpacity(0.6);
      textColor = textColor.withAlpha(120);
    } else {
      backgroundColor = onHover ? primaryColor.withOpacity(0.1) : null;
      borderColor = onTap
          ? primaryColor
          : onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
    }
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(roundValue),
      ),
      child: UnconstrainedBox(
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(color: textColor),
            child: child,
          ),
        ),
      ),
    );
  }

  Widget buildThemeButton(BuildContext context) {
    Color backgroundColor = ElApp.of(context).themeColors[type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    Border? border;
    if (onPressed == null) {
      backgroundColor = backgroundColor.withOpacity(0.6);
    } else if (plain) {
      textColor = onTap || onHover ? textColor : backgroundColor;
      border = Border.all(color: backgroundColor.withOpacity(0.5));
      backgroundColor = onTap
          ? _ColorUtil.darken(backgroundColor, 15)
          : onHover
              ? backgroundColor
              : backgroundColor.withAlpha(25);
    } else {
      textColor = const Color(0xffffffff);
      backgroundColor = onTap
          ? _ColorUtil.getLightnessColor(backgroundColor, 0.85)
          : onHover
              ? backgroundColor.withOpacity(0.8)
              : backgroundColor;
    }
    return Container(
      padding: border == null
          ? const EdgeInsets.symmetric(vertical: 8, horizontal: 15)
          : const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: border,
        borderRadius: BorderRadius.circular(roundValue),
      ),
      child: UnconstrainedBox(
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(color: textColor),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _IconButton extends _DesktopEventWidget {
  const _IconButton({
    required super.onPressed,
    required super.onHover,
    required super.onTap,
    required this.icon,
    this.type,
    required this.circle,
    required this.size,
  });

  final IconData icon;
  final ElThemeType? type;
  final bool circle;
  final double size;

  double get _roundValue => circle ? 9999 : _defaultRadius;

  double get _width => circle ? size : size * 1.2;

  double get _height => circle ? size : size;

  @override
  Widget build(BuildContext context) {
    return type == null ? buildDefaultButton(context) : buildThemeButton(context);
  }

  Widget buildIcon(Color color) {
    return UnconstrainedBox(
      child: Center(
        child: Icon(
          icon,
          color: color,
          size: 18,
        ),
      ),
    );
  }

  Widget buildDefaultButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color? backgroundColor;
    Color borderColor = ElApp.of(context).theme.defaultBorderColor;
    if (onPressed == null) {
      borderColor = borderColor.withOpacity(0.6);
      textColor = textColor.withAlpha(120);
    } else {
      backgroundColor = onHover ? primaryColor.withOpacity(0.1) : null;
      borderColor = onTap
          ? primaryColor
          : onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
      textColor = textColor.withAlpha(160);
    }
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(_roundValue),
      ),
      child: buildIcon(textColor),
    );
  }

  Widget buildThemeButton(BuildContext context) {
    Color backgroundColor = ElApp.of(context).themeColors[type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    if (onPressed == null) {
      backgroundColor = backgroundColor.withOpacity(0.6);
    } else {
      textColor = const Color(0xffffffff);
      backgroundColor = onTap
          ? _ColorUtil.getLightnessColor(backgroundColor, 0.85)
          : onHover
              ? backgroundColor.withOpacity(0.8)
              : backgroundColor;
    }
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(_roundValue),
      ),
      child: buildIcon(textColor),
    );
  }
}
