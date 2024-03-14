part of flutter_element_ui;

enum _ButtonType { base, text, icon }

const double _defaultSize = 32;
const double _defaultRadius = 4;

/// 默认水平间距
const double _defaultHorizontal = 15;

/// 默认的文字alpha
const int _defaultTextAlpha = 200;

/// 当按钮处于禁用状态时，更新当前文字颜色的alpha
const int _disabledTextAlpha = 120;

/// 当按钮处于禁用状态时，更新按钮样式透明度
const double _disabledOpacity = 0.6;

class ElButton extends StatefulWidget {
  /// 渲染普通按钮，提示：button实际上是一个[Container]元素，如果遇到布局问题，请留意flutter中的布局约束。
  ///
  /// https://flutter.cn/docs/ui/layout/constraints
  const ElButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.height,
    this.type,
    this.plain = false,
    this.round = false,
  })  : _buttonType = _ButtonType.base,
        text = null,
        icon = null,
        bg = false,
        circle = false,
        size = 0;

  /// 渲染文字按钮
  const ElButton.text(
    this.text, {
    super.key,
    required this.onPressed,
    this.height,
    this.type,
    this.bg = false,
  })  : _buttonType = _ButtonType.text,
        child = null,
        icon = null,
        plain = false,
        round = false,
        circle = false,
        size = 0;

  /// 渲染图标按钮
  const ElButton.icon(
    this.icon, {
    super.key,
    required this.onPressed,
    this.type,
    this.circle = false,
    this.size = _defaultSize,
  })  : _buttonType = _ButtonType.icon,
        child = null,
        text = null,
        height = null,
        bg = false,
        round = false,
        plain = false;

  final _ButtonType _buttonType;
  final VoidCallback? onPressed;
  final Widget? child;
  final String? text;
  final IconData? icon;
  final ElThemeType? type;

  /// 普通按钮、文字按钮的高度，默认32
  final double? height;

  /// 朴素按钮
  final bool plain;

  /// 圆角按钮
  final bool round;

  /// 文字按钮是否添加背景
  final bool bg;

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
          height: widget.height ?? _defaultSize,
          plain: widget.plain,
          round: widget.round,
          child: widget.child!,
        );
        break;
      case _ButtonType.text:
        assert(widget.text != null && widget.text != '', 'text不能为null或空字符串');
        buttonWidget = _TextButton(
          onPressed: widget.onPressed,
          onHover: _onHover,
          onTap: _onTap,
          text: widget.text!,
          type: widget.type,
          height: widget.height ?? _defaultSize,
          bg: widget.bg,
        );
        break;
      case _ButtonType.icon:
        assert(widget.icon != null, 'icon不能为null');
        buttonWidget = _IconButton(
          onPressed: widget.onPressed,
          onHover: _onHover,
          onTap: _onTap,
          icon: widget.icon!,
          type: widget.type,
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
    required this.height,
    required this.plain,
    required this.round,
  });

  final Widget child;
  final ElThemeType? type;
  final double height;
  final bool plain;
  final bool round;

  double get _roundValue => round ? 9999 : _defaultRadius;

  @override
  Widget build(BuildContext context) {
    return type == null ? _buildDefaultButton(context) : _buildThemeButton(context);
  }

  Widget _buildChild(Color color) {
    return UnconstrainedBox(
      child: Center(
        child: DefaultTextStyle(
          style: TextStyle(color: color),
          child: child,
        ),
      ),
    );
  }

  Widget _buildDefaultButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color? bgColor;
    Color borderColor = ElApp.of(context).theme.defaultBorderColor;
    if (onPressed == null) {
      borderColor = borderColor.withOpacity(_disabledOpacity);
      textColor = textColor.withAlpha(_disabledTextAlpha);
    } else {
      bgColor = onHover ? primaryColor.withOpacity(0.1) : null;
      textColor = onTap || onHover ? primaryColor : textColor.withAlpha(_defaultTextAlpha);
      borderColor = onTap
          ? primaryColor
          : onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
    }
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: _defaultHorizontal),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(_roundValue),
      ),
      child: _buildChild(textColor),
    );
  }

  Widget _buildThemeButton(BuildContext context) {
    Color themeColor = ElApp.of(context).themeColors[type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    Color? bgColor;
    Border? border;
    if (plain) {
      textColor = onTap || onHover ? textColor : themeColor;
      border = Border.all(color: themeColor.withOpacity(0.5));
      bgColor = onTap
          ? themeColor.darken(15)
          : onHover
              ? bgColor
              : themeColor.withAlpha(25);
    } else {
      textColor = const Color(0xffffffff);
      bgColor = themeColor;
    }
    if (onPressed == null) {
      if (plain) {
        bgColor = themeColor.withAlpha(25);
        textColor = themeColor.withOpacity(_disabledOpacity);
        border = Border.all(color: themeColor.withOpacity(0.3));
      } else {
        bgColor = bgColor!.withOpacity(_disabledOpacity);
        textColor = const Color(0xffffffff);
        border = null;
      }
    } else {
      bgColor = onTap
          ? themeColor.darken(15)
          : onHover
              ? themeColor.withOpacity(0.8)
              : bgColor;
    }
    return Container(
      height: height,
      padding: border == null
          ? const EdgeInsets.symmetric(horizontal: _defaultHorizontal)
          : const EdgeInsets.symmetric(horizontal: _defaultHorizontal - 1),
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        borderRadius: BorderRadius.circular(_roundValue),
      ),
      child: _buildChild(textColor),
    );
  }
}

class _TextButton extends _DesktopEventWidget {
  const _TextButton({
    required super.onPressed,
    required super.onHover,
    required super.onTap,
    required this.text,
    this.type,
    required this.height,
    required this.bg,
  });

  final String text;
  final ElThemeType? type;
  final double height;
  final bool bg;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = ElApp.of(context).theme.info.withAlpha(160);
    Color textColor = ElApp.of(context).theme.textBlack;
    if (onPressed == null) {
      bgColor = bg ? bgColor.withAlpha(15) : null;
      textColor =
          type == null ? textColor.withAlpha(_disabledTextAlpha) : ElApp.of(context).themeColors[type!]!.withAlpha(_disabledTextAlpha);
    } else {
      if (bg) {
        bgColor = onTap
            ? bgColor.withAlpha(50)
            : onHover
                ? bgColor.withAlpha(40)
                : bgColor.withAlpha(25);
      } else {
        bgColor = onTap
            ? bgColor.withAlpha(50)
            : onHover
                ? bgColor.withAlpha(25)
                : null;
      }

      if (type == null) {
        textColor = textColor.withAlpha(_defaultTextAlpha);
      } else {
        textColor = ElApp.of(context).themeColors[type!]!;
      }
    }
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: _defaultHorizontal),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_defaultRadius),
      ),
      child: UnconstrainedBox(
        child: Center(
          child: DefaultTextStyle(
            style: TextStyle(color: textColor),
            child: Text(text),
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

  double get _width => circle ? size : size * 1.2;

  double get _height => circle ? size : size;

  double get _roundValue => circle ? 9999 : _defaultRadius;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: type == null ? _buildDefaultButton(context) : _buildThemeButton(context),
    );
  }

  Widget _buildIcon(Color color) {
    return Center(
      child: Icon(
        icon,
        color: color,
        size: 18,
      ),
    );
  }

  Widget _buildDefaultButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color? bgColor;
    Color borderColor = ElApp.of(context).theme.defaultBorderColor;
    if (onPressed == null) {
      borderColor = borderColor.withOpacity(_disabledOpacity);
      textColor = textColor.withAlpha(_disabledTextAlpha);
    } else {
      bgColor = onHover ? primaryColor.withOpacity(0.1) : null;
      borderColor = onTap
          ? primaryColor
          : onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
      textColor = onTap || onHover ? primaryColor : textColor.withAlpha(_defaultTextAlpha);
    }
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(_roundValue),
      ),
      child: _buildIcon(textColor),
    );
  }

  Widget _buildThemeButton(BuildContext context) {
    Color bgColor = ElApp.of(context).themeColors[type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    if (onPressed == null) {
      bgColor = bgColor.withOpacity(_disabledOpacity);
    } else {
      bgColor = onTap
          ? bgColor.darken(15)
          : onHover
              ? bgColor.withOpacity(0.8)
              : bgColor;
    }
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(_roundValue),
      ),
      child: _buildIcon(textColor),
    );
  }
}
