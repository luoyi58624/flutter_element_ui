part of flutter_element_ui;

/// 默认的文字alpha
const int _defaultTextAlpha = 200;

/// 当按钮处于禁用状态时，更新当前文字颜色的alpha
const int _disabledTextAlpha = 120;

/// 当按钮处于禁用状态时，更新按钮样式透明度
const double _disabledOpacity = 0.6;

abstract class _Button extends StatefulWidget {
  const _Button({
    super.key,
    this.onPressed,
    this.type,
    this.disabled = false,
    this.tooltip,
    this.disabledTooltip,
    this.loading = false,
    this.loadingBuilder,
  });

  /// 点击事件，如果为null按钮将被禁用，但如果此按钮属于[ElButtonGroup]按钮组，点击事件设置为null它也不会禁用，除非你设置[disabled]
  final VoidCallback? onPressed;

  /// 按钮主题类型
  final ElThemeType? type;

  /// 禁用按钮
  final bool disabled;

  /// 提示文字
  final String? tooltip;

  /// 禁用提示文字
  final String? disabledTooltip;

  /// 是否显示loading
  final bool loading;

  /// 自定义loading组件
  final Widget Function(Color color)? loadingBuilder;

  @override
  State<_Button> createState();
}

abstract class _ButtonState<T extends _Button> extends State<T> with ElMouseMixin, ElTapMixin, ElThemeMixin {
  /// 默认文字颜色
  Color? textColor;

  /// 按钮的背景颜色
  Color? bgColor;

  /// 按钮的图标颜色
  Color? iconColor;

  /// 按钮边框
  Border? border;

  /// 按钮边框圆角
  BorderRadius? borderRadius;

  /// 按钮的边框颜色
  Color? borderColor;

  bool get disabledButton => widget.disabled || widget.onPressed == null;

  @override
  bool get disabledHover => disabledButton;

  @override
  bool get disabledTap => disabledButton;

  @override
  void onTapEvent() {
    if (widget.onPressed != null) widget.onPressed!();
  }

  /// 构建普通button主题
  void buildDefaultTheme();

  /// 构建指定类型的主题色
  void buildTypeTheme(ElThemeType type);

  /// 构建按钮
  Widget buildButton();

  Color getThemeTypeColor(ElThemeType type) {
    return ElAppData.of(context).themeColors[type]!;
  }

  @override
  Widget build(BuildContext context) {
    widget.type == null ? buildDefaultTheme() : buildTypeTheme(widget.type!);
    return buildMouseWidget(
      child: buildTapWidget(
        child: buildButton(),
      ),
    );
  }
}

/// Element 普通按钮，提示：[ElButton]实际上是一个[Container]，如果遇到布局问题，请留意flutter中的布局约束。
///
/// https://flutter.cn/docs/ui/layout/constraints
class ElButton extends _Button {
  const ElButton(
    this.text, {
    super.key,
    super.onPressed,
    super.type,
    super.disabled,
    super.tooltip,
    super.disabledTooltip,
    super.loading,
    super.loadingBuilder,
    this.leftIcon,
    this.rightIcon,
    this.height,
    this.iconSize,
    this.plain = false,
    this.round = false,
  });

  /// 按钮文字
  final String text;

  /// 普通按钮左图标
  final IconData? leftIcon;

  /// 普通按钮右图标
  final IconData? rightIcon;

  /// 按钮高度
  final double? height;

  /// 朴素按钮
  final bool plain;

  /// 圆角按钮
  final bool round;

  /// icon图标的尺寸
  final double? iconSize;

  @override
  State<ElButton> createState() => _ElButtonState();
}

class _ElButtonState extends _ButtonState<ElButton> {
  bool get noText => widget.text == '';

  double get iconSize => widget.iconSize ?? $buttonIconSize;

  @override
  double get $radius => widget.round ? 9999 : super.$radius;

  @override
  void buildDefaultTheme() {
    textColor = $textColor;
    iconColor = textColor!.withAlpha(_defaultTextAlpha);
    borderColor = $defaultBorderColor;
    if (super.disabledButton) {
      borderColor = borderColor!.withOpacity(_disabledOpacity);
      textColor = textColor!.withAlpha(_disabledTextAlpha);
      iconColor = iconColor!.withAlpha(_disabledTextAlpha);
    } else {
      bgColor = super.onHover ? $primaryColor.withOpacity(0.1) : null;
      textColor = super.onTap || super.onHover ? $primaryColor : textColor!.withAlpha(_defaultTextAlpha);
      iconColor = super.onTap || super.onHover ? $primaryColor : iconColor;
      borderColor = super.onTap
          ? $primaryColor
          : super.onHover
              ? $primaryColor.withOpacity(0.2)
              : $defaultBorderColor;
    }

    border = Border.all(color: borderColor!);
    borderRadius = BorderRadius.circular($radius);
  }

  @override
  void buildTypeTheme(ElThemeType type) {
    Color themeColor = getThemeTypeColor(type);
    textColor = $textWhiteColor;
    iconColor = textColor;
    if (widget.plain) {
      textColor = super.onTap || super.onHover ? $textWhiteColor : themeColor;
      iconColor = super.onTap || super.onHover ? $textWhiteColor : themeColor;
      border = Border.all(color: themeColor.withOpacity(0.5));
      bgColor = super.onTap
          ? themeColor.darken(15)
          : super.onHover
              ? bgColor
              : themeColor.withAlpha(25);
    } else {
      bgColor = themeColor;
    }
    if (super.disabledButton) {
      if (widget.plain) {
        bgColor = themeColor.withAlpha(25);
        textColor = themeColor.withOpacity(_disabledOpacity);
        iconColor = themeColor.withOpacity(_disabledOpacity);
        border = Border.all(color: themeColor.withOpacity(0.3));
      } else {
        bgColor = bgColor!.withOpacity(_disabledOpacity);
        border = null;
      }
    } else {
      bgColor = super.onTap
          ? themeColor.darken(15)
          : super.onHover
              ? widget.plain
                  ? themeColor
                  : themeColor.withOpacity(0.8)
              : bgColor;
    }
    borderRadius = BorderRadius.circular($radius);
  }

  @override
  Widget buildButton() {
    return Container(
      height: widget.height ?? $buttonHeight,
      padding: border == null
          ? EdgeInsets.symmetric(horizontal: $buttonHorizontal)
          : EdgeInsets.symmetric(horizontal: $buttonHorizontal - 1),
      decoration: BoxDecoration(
        color: bgColor,
        border: border,
        borderRadius: borderRadius,
      ),
      child: UnconstrainedBox(
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.loading)
                Padding(
                  padding: noText ? EdgeInsets.zero : const EdgeInsets.only(right: 6),
                  child: widget.loadingBuilder == null
                      ? ElLoading(size: $buttonIconSize, color: iconColor)
                      : widget.loadingBuilder!(iconColor!),
                ),
              if (widget.leftIcon != null)
                Padding(
                  padding: noText ? EdgeInsets.zero : const EdgeInsets.only(right: 4),
                  child: ElIcon(
                    widget.leftIcon,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
              if (!noText)
                Text(
                  widget.text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              if (widget.rightIcon != null)
                Padding(
                  padding: noText ? EdgeInsets.zero : const EdgeInsets.only(left: 4),
                  child: ElIcon(
                    widget.rightIcon,
                    color: iconColor,
                    size: iconSize,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

///  Element 文字按钮
class ElTextButton extends _Button {
  const ElTextButton(
    this.text, {
    super.key,
    super.onPressed,
    super.type,
    super.disabled,
    super.tooltip,
    super.disabledTooltip,
    super.loading,
    super.loadingBuilder,
    this.height,
    this.bg = false,
  });

  /// 按钮文字
  final String text;

  /// 按钮高度，默认32
  final double? height;

  /// 文字按钮是否添加背景
  final bool bg;

  @override
  State<ElTextButton> createState() => _ElTextButtonState();
}

class _ElTextButtonState extends _ButtonState<ElTextButton> {
  @override
  void buildDefaultTheme() {
    bgColor = ElAppData.of(context).currentTheme.info.withAlpha(160);
    textColor = ElAppData.of(context).currentTheme.textColor;
    if (super.disabledButton) {
      bgColor = widget.bg ? bgColor!.withAlpha(15) : null;
      textColor = textColor!.withAlpha(_disabledTextAlpha);
    } else {
      if (widget.bg) {
        bgColor = super.onTap
            ? bgColor!.withAlpha(50)
            : super.onHover
                ? bgColor!.withAlpha(40)
                : bgColor!.withAlpha(25);
      } else {
        bgColor = super.onTap
            ? bgColor!.withAlpha(50)
            : super.onHover
                ? bgColor!.withAlpha(25)
                : null;
      }
      textColor = textColor!.withAlpha(_defaultTextAlpha);
    }
  }

  @override
  void buildTypeTheme(ElThemeType type) {
    bgColor = ElAppData.of(context).currentTheme.info.withAlpha(160);
    textColor = $textColor;
    if (super.disabledButton) {
      bgColor = widget.bg ? bgColor!.withAlpha(15) : null;
      textColor = getThemeTypeColor(type).withAlpha(_disabledTextAlpha);
    } else {
      if (widget.bg) {
        bgColor = super.onTap
            ? bgColor!.withAlpha(50)
            : super.onHover
                ? bgColor!.withAlpha(40)
                : bgColor!.withAlpha(25);
      } else {
        bgColor = super.onTap
            ? bgColor!.withAlpha(50)
            : super.onHover
                ? bgColor!.withAlpha(25)
                : null;
      }
      textColor = getThemeTypeColor(type);
    }
  }

  @override
  Widget buildButton() {
    return Container(
      height: widget.height ?? $buttonHeight,
      padding: EdgeInsets.symmetric(horizontal: $buttonHorizontal),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular($radius),
      ),
      child: UnconstrainedBox(
        child: Center(
          child: widget.loading
              ? widget.loadingBuilder == null
                  ? ElLoading(size: $buttonIconSize, color: textColor)
                  : widget.loadingBuilder!(textColor!)
              : Text(
                  widget.text,
                  style: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
        ),
      ),
    );
  }
}

///  Element 图标按钮
class ElIconButton extends _Button {
  const ElIconButton(
    this.icon, {
    super.key,
    super.onPressed,
    super.type,
    super.disabled,
    super.tooltip,
    super.disabledTooltip,
    super.loading,
    super.loadingBuilder,
    this.circle = false,
    this.size,
    this.iconSize,
  });

  /// 按钮图标
  final ElIcon icon;

  /// 是否将图标按钮设置为圆形
  final bool circle;

  /// 图标按钮尺寸
  final double? size;

  /// icon图标的尺寸
  final double? iconSize;

  @override
  State<ElIconButton> createState() => _ElIconButtonState();
}

class _ElIconButtonState extends _ButtonState<ElIconButton> {
  double get size => widget.size ?? $buttonHeight;

  double get iconSize => widget.iconSize ?? $buttonIconSize;

  double get _width => widget.circle ? size : size * 1.2;

  double get _height => widget.circle ? size : size;

  double get _horizontal => (size - iconSize / 2) / 2;

  @override
  double get $radius => widget.circle ? 9999 : super.$radius;

  @override
  void buildDefaultTheme() {
    textColor = $textColor;
    borderColor = $defaultBorderColor;
    if (super.disabledButton) {
      borderColor = borderColor!.withOpacity(_disabledOpacity);
      textColor = textColor!.withAlpha(_disabledTextAlpha);
    } else {
      bgColor = super.onHover ? $primaryColor.withOpacity(0.1) : null;
      borderColor = super.onTap
          ? $primaryColor
          : super.onHover
              ? $primaryColor.withOpacity(0.2)
              : $defaultBorderColor;
      textColor = super.onTap || super.onHover ? $primaryColor : textColor!.withAlpha(_defaultTextAlpha);
    }
    border = Border.all(color: borderColor!);
    borderRadius = BorderRadius.circular($radius);
  }

  @override
  void buildTypeTheme(ElThemeType type) {
    bgColor = getThemeTypeColor(type);
    textColor = $textWhiteColor;
    if (super.disabledButton) {
      bgColor = bgColor!.withOpacity(_disabledOpacity);
    } else {
      bgColor = super.onTap
          ? bgColor!.darken(15)
          : super.onHover
              ? bgColor!.withOpacity(0.8)
              : bgColor;
    }
    borderRadius = BorderRadius.circular($radius);
  }

  @override
  Widget buildButton() {
    return UnconstrainedBox(
      child: Container(
        height: _height,
        width: widget.circle ? _width : null,
        padding: widget.circle
            ? null
            : border == null
                ? EdgeInsets.symmetric(horizontal: _horizontal)
                : EdgeInsets.symmetric(horizontal: _horizontal - 1),
        decoration: BoxDecoration(
          color: bgColor,
          border: border,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: widget.loading
              ? widget.loadingBuilder == null
                  ? ElLoading(size: $buttonIconSize, color: textColor)
                  : widget.loadingBuilder!(textColor!)
              : ElDefaultIconStyle(
                  color: textColor,
                  size: iconSize,
                  child: widget.icon,
                ),
        ),
      ),
    );
  }
}
