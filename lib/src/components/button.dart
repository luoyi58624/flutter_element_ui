part of flutter_element_ui;

enum _ButtonType { base, text, icon }

const double _defaultSize = 32;
const double _defaultIconSize = 16;

/// 默认水平间距
const double _defaultHorizontal = 15;

/// 默认的文字alpha
const int _defaultTextAlpha = 200;

/// 当按钮处于禁用状态时，更新当前文字颜色的alpha
const int _disabledTextAlpha = 120;

/// 图标比文字更小的alpha，在flutter中，图标的颜色似乎比文字更重
const int _iconAlphaDiff = 40;

/// 当按钮处于禁用状态时，更新按钮样式透明度
const double _disabledOpacity = 0.6;

Widget _materialLoading(Color color) => SizedBox(
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );

class ElButton extends StatefulWidget {
  /// 渲染普通按钮，提示：[ElButton]实际上是一个[Container]，如果遇到布局问题，请留意flutter中的布局约束。
  ///
  /// https://flutter.cn/docs/ui/layout/constraints
  const ElButton(
    this.text, {
    super.key,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.height,
    this.type,
    this.iconSize = _defaultIconSize,
    this.plain = false,
    this.round = false,
    this.disabled = false,
    this.tooltip,
    this.disabledTooltip,
    this.loading = false,
    this.loadingBuilder,
  })  : _buttonType = _ButtonType.base,
        icon = null,
        bg = false,
        circle = false,
        size = 0;

  /// 渲染文字按钮
  const ElButton.text(
    this.text, {
    super.key,
    this.onPressed,
    this.height,
    this.type,
    this.disabled = false,
    this.bg = false,
    this.tooltip,
    this.disabledTooltip,
    this.loading = false,
    this.loadingBuilder,
  })  : _buttonType = _ButtonType.text,
        icon = null,
        iconSize = 0,
        leftIcon = null,
        rightIcon = null,
        plain = false,
        round = false,
        circle = false,
        size = 0;

  /// 渲染图标按钮
  const ElButton.icon(
    this.icon, {
    super.key,
    this.onPressed,
    this.type,
    this.circle = false,
    this.size = _defaultSize,
    this.iconSize = _defaultIconSize,
    this.disabled = false,
    this.tooltip,
    this.disabledTooltip,
    this.loading = false,
    this.loadingBuilder,
  })  : _buttonType = _ButtonType.icon,
        text = null,
        leftIcon = null,
        rightIcon = null,
        height = null,
        bg = false,
        round = false,
        plain = false;

  final _ButtonType _buttonType;

  /// 点击事件，如果为null按钮将被禁用，但如果此按钮属于[ElButtonGroup]按钮组，点击事件设置为null它也不会禁用，除非你设置[disabled]
  final VoidCallback? onPressed;

  /// 按钮文字
  final String? text;

  /// 按钮图标
  final IconData? icon;

  /// 按钮主题类型
  final ElThemeType? type;

  /// 普通按钮左图标
  final IconData? leftIcon;

  /// 普通按钮右图标
  final IconData? rightIcon;

  /// 普通按钮、文字按钮的高度，默认32
  final double? height;

  /// 朴素按钮
  final bool plain;

  /// 圆角按钮
  final bool round;

  /// 禁用按钮
  final bool disabled;

  /// 文字按钮是否添加背景
  final bool bg;

  /// 是否将图标按钮设置为圆形
  final bool circle;

  /// 图标按钮尺寸
  final double size;

  /// icon图标的尺寸
  final double iconSize;

  /// 提示文字
  final String? tooltip;

  /// 禁用提示文字
  final String? disabledTooltip;

  /// 是否显示loading
  final bool loading;

  /// 自定义loading组件
  final Widget Function(Color color)? loadingBuilder;

  @override
  State<ElButton> createState() => _ElButtonState();
}

class _ElButtonState extends State<ElButton> {
  bool _onHover = false;
  bool _onTap = false;

  /// 此按钮是否属于按钮组成员，如果父级组件存在[ElButtonGroup]，那么它为true
  late bool _isButtonGroupItem;

  /// 按钮当前索引的key，如果是single、multiple按钮组，那么此值必须存在
  int? _currentKeyValue;

  bool get _disabledButton {
    if (_isButtonGroupItem) {
      return widget.disabled;
    } else {
      return widget.disabled || widget.onPressed == null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _ElButtonGroupData? buttonGroupData = _ElButtonGroupData.of(context);
    _isButtonGroupItem = buttonGroupData != null;
    if (_isButtonGroupItem) {
      if (buttonGroupData!.buttonGroupType == _ButtonGroupType.single || buttonGroupData.buttonGroupType == _ButtonGroupType.multiple) {
        assert(widget.key != null && widget.key is ValueKey<int>,
            '你声明了${buttonGroupData.buttonGroupType.name}按钮组，但是ElButton的key参数却没有设置ValueKey<int>，请传递包含当前按钮索引的ValueKey');
        _currentKeyValue = (widget.key! as ValueKey<int>).value;
      }
    }
    late Widget buttonWidget;
    switch (widget._buttonType) {
      case _ButtonType.base:
        assert(widget.text != null, 'text不能为null');
        buttonWidget = _BaseButton(
          onHover: _onHover,
          onTap: _onTap,
          disabledButton: _disabledButton,
          currentKeyValue: _currentKeyValue,
          isButtonGroupItem: _isButtonGroupItem,
          buttonGroupData: buttonGroupData,
          text: widget.text!,
          type: widget.type,
          height: widget.height ?? _defaultSize,
          plain: widget.plain,
          round: widget.round,
          leftIcon: widget.leftIcon,
          rightIcon: widget.rightIcon,
          iconSize: widget.iconSize,
          loading: widget.loading,
          loadingBuilder: widget.loadingBuilder,
        );
        break;
      case _ButtonType.text:
        assert(widget.text != null, 'text不能为null');
        buttonWidget = _TextButton(
          onHover: _onHover,
          onTap: _onTap,
          disabledButton: _disabledButton,
          text: widget.text!,
          type: widget.type,
          height: widget.height ?? _defaultSize,
          bg: widget.bg,
          loading: widget.loading,
          loadingBuilder: widget.loadingBuilder,
        );
        break;
      case _ButtonType.icon:
        assert(widget.icon != null, 'icon不能为null');
        buttonWidget = _IconButton(
          onHover: _onHover,
          onTap: _onTap,
          disabledButton: _disabledButton,
          icon: widget.icon!,
          type: widget.type,
          circle: widget.circle,
          size: widget.size,
          iconSize: widget.iconSize,
          loading: widget.loading,
          loadingBuilder: widget.loadingBuilder,
        );
        break;
    }
    if (widget.tooltip != null && widget.onPressed != null) {
      buttonWidget = Tooltip(
        message: widget.tooltip,
        child: buttonWidget,
      );
    }
    if (widget.disabledTooltip != null && widget.onPressed == null) {
      buttonWidget = Tooltip(
        message: widget.disabledTooltip,
        child: buttonWidget,
      );
    }
    return MouseRegion(
      onEnter: _disabledButton
          ? null
          : (e) {
              setState(() {
                _onHover = true;
              });
            },
      onExit: _disabledButton
          ? null
          : (e) {
              setState(() {
                _onHover = false;
              });
            },
      cursor: _disabledButton ? SystemMouseCursors.forbidden : SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: _disabledButton
            ? null
            : (e) {
                setState(() {
                  _onTap = true;
                });
              },
        onTapCancel: _disabledButton
            ? null
            : () {
                setState(() {
                  _onTap = false;
                });
              },
        onTap: _disabledButton
            ? null
            : () {
                setState(() {
                  _onTap = false;
                });
                if (_isButtonGroupItem) {
                  if (widget.onPressed != null) widget.onPressed!();
                  switch (buttonGroupData!.buttonGroupType) {
                    case _ButtonGroupType.base:
                      break;
                    case _ButtonGroupType.single:
                      if (buttonGroupData.onChange != null) {
                        if (buttonGroupData.index != _currentKeyValue) {
                          buttonGroupData.onChange!(_currentKeyValue!);
                        }
                      }
                      break;
                    case _ButtonGroupType.multiple:
                      if (buttonGroupData.onChangeList != null) {
                        List<int> indexList = buttonGroupData.indexList;
                        int targetIndex = indexList.indexOf(_currentKeyValue!);
                        if (targetIndex == -1) {
                          indexList.add(_currentKeyValue!);
                        } else {
                          indexList.removeAt(targetIndex);
                        }
                        buttonGroupData.onChangeList!(indexList);
                      }
                      break;
                  }
                } else {
                  widget.onPressed!();
                }
              },
        child: buttonWidget,
      ),
    );
  }
}

class _BaseButton extends StatelessWidget {
  const _BaseButton({
    required this.onHover,
    required this.onTap,
    required this.disabledButton,
    this.currentKeyValue,
    required this.isButtonGroupItem,
    required this.buttonGroupData,
    required this.text,
    this.type,
    required this.height,
    required this.plain,
    required this.round,
    this.leftIcon,
    this.rightIcon,
    required this.iconSize,
    required this.loading,
    this.loadingBuilder,
  });

  final bool onHover;
  final bool onTap;
  final bool disabledButton;
  final int? currentKeyValue;
  final bool isButtonGroupItem;
  final _ElButtonGroupData? buttonGroupData;
  final String text;
  final ElThemeType? type;
  final double height;
  final bool plain;
  final bool round;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double iconSize;
  final bool loading;
  final Widget Function(Color color)? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    return isButtonGroupItem
        ? _buildGroupButton(context)
        : type == null
            ? _buildDefaultButton(context)
            : _buildThemeButton(context);
  }

  Widget _buildChild(BuildContext context, Color textColor, Color iconColor) {
    bool noText = text == '';
    return UnconstrainedBox(
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (loading)
              Padding(
                padding: noText ? EdgeInsets.zero : const EdgeInsets.only(right: 6),
                child: loadingBuilder == null
                    ? CupertinoActivityIndicator(
                        radius: 8,
                        color: type == null ? textColor : ElApp.of(context).theme.white,
                      )
                    : loadingBuilder!(iconColor),
              ),
            if (leftIcon != null)
              Padding(
                padding: noText ? EdgeInsets.zero : const EdgeInsets.only(right: 4),
                child: Icon(
                  leftIcon,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
            if (!noText)
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            if (rightIcon != null)
              Padding(
                padding: noText ? EdgeInsets.zero : const EdgeInsets.only(left: 4),
                child: Icon(
                  rightIcon,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefaultButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color iconColor = textColor.withAlpha(_defaultTextAlpha - _iconAlphaDiff);
    Color? bgColor;
    Color borderColor = ElApp.of(context).theme.borderColor;
    if (disabledButton) {
      borderColor = borderColor.withOpacity(_disabledOpacity);
      textColor = textColor.withAlpha(_disabledTextAlpha);
      iconColor = iconColor.withAlpha(_disabledTextAlpha - _iconAlphaDiff);
    } else {
      bgColor = onHover ? primaryColor.withOpacity(0.1) : null;
      textColor = onTap || onHover ? primaryColor : textColor.withAlpha(_defaultTextAlpha);
      iconColor = onTap || onHover ? primaryColor : iconColor;
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
        borderRadius: BorderRadius.circular(getBorderRadius(context)),
      ),
      child: _buildChild(context, textColor, iconColor),
    );
  }

  Widget _buildThemeButton(BuildContext context) {
    Color themeColor = ElApp.of(context).themeColors[type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    Color iconColor = textColor;
    Color? bgColor;
    Border? border;
    if (plain) {
      textColor = onTap || onHover ? textColor : themeColor;
      iconColor = onTap || onHover ? textColor : themeColor;
      border = Border.all(color: themeColor.withOpacity(0.5));
      bgColor = onTap
          ? themeColor.darken(15)
          : onHover
              ? bgColor
              : themeColor.withAlpha(25);
    } else {
      bgColor = themeColor;
    }
    if (disabledButton) {
      if (plain) {
        bgColor = themeColor.withAlpha(25);
        textColor = themeColor.withOpacity(_disabledOpacity);
        iconColor = themeColor.withOpacity(_disabledOpacity);
        border = Border.all(color: themeColor.withOpacity(0.3));
      } else {
        bgColor = bgColor!.withOpacity(_disabledOpacity);
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
        borderRadius: BorderRadius.circular(getBorderRadius(context)),
      ),
      child: _buildChild(context, textColor, iconColor),
    );
  }

  Widget _buildGroupButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color iconColor = textColor.withAlpha(_defaultTextAlpha - _iconAlphaDiff);
    Color? bgColor;
    Color borderColor = ElApp.of(context).theme.borderColor;
    if (disabledButton) {
      borderColor = borderColor.withOpacity(_disabledOpacity);
      textColor = textColor.withAlpha(_disabledTextAlpha);
      iconColor = iconColor.withAlpha(_disabledTextAlpha - _iconAlphaDiff);
    } else {
      bgColor = onHover ? primaryColor.withOpacity(0.1) : null;
      textColor = onTap || onHover ? primaryColor : textColor.withAlpha(_defaultTextAlpha);
      iconColor = onTap || onHover ? primaryColor : iconColor;
      borderColor = onTap
          ? primaryColor
          : onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
    }
    late Border border;
    late BorderRadius borderRadius;
    double radius = getBorderRadius(context);
    BorderSide borderSide = BorderSide(color: borderColor);
    if (buttonGroupData!.children.length == 2) {
      if (currentKeyValue == 0) {
        border = Border.all(color: borderColor);
        borderRadius = BorderRadius.only();
      }
    } else {}
    if (currentKeyValue == 0) {
      border = Border(left: borderSide, top: borderSide, bottom: borderSide);
    } else if (currentKeyValue == buttonGroupData!.children.length - 1) {
      border = Border(right: borderSide, top: borderSide, bottom: borderSide);
    } else {}
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: _defaultHorizontal),
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(round ? 9999 : ElApp.of(context).theme.radius),
      ),
      child: _buildChild(context, textColor, iconColor),
    );
  }

  double getBorderRadius(BuildContext context) {
    return round ? 9999 : ElApp.of(context).theme.radius;
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.onHover,
    required this.onTap,
    required this.disabledButton,
    required this.text,
    this.type,
    required this.height,
    required this.bg,
    required this.loading,
    this.loadingBuilder,
  });

  final bool onHover;
  final bool onTap;
  final bool disabledButton;
  final String text;
  final ElThemeType? type;
  final double height;
  final bool bg;
  final bool loading;
  final Widget Function(Color color)? loadingBuilder;

  @override
  Widget build(BuildContext context) {
    Color? bgColor = ElApp.of(context).theme.info.withAlpha(160);
    Color textColor = ElApp.of(context).theme.textBlack;
    if (disabledButton) {
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
        borderRadius: BorderRadius.circular(ElApp.of(context).theme.radius),
      ),
      child: UnconstrainedBox(
        child: Center(
          child: loading
              ? loadingBuilder == null
                  ? _materialLoading(textColor)
                  : loadingBuilder!(textColor)
              : Text(
                  text,
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

class _IconButton extends StatelessWidget {
  const _IconButton({
    required this.onHover,
    required this.onTap,
    required this.disabledButton,
    required this.icon,
    this.type,
    required this.circle,
    required this.size,
    required this.iconSize,
    required this.loading,
    this.loadingBuilder,
  });

  final bool onHover;
  final bool onTap;
  final bool disabledButton;
  final IconData icon;
  final ElThemeType? type;
  final bool circle;
  final double size;
  final double iconSize;
  final bool loading;
  final Widget Function(Color color)? loadingBuilder;

  double get _width => circle ? size : size * 1.2;

  double get _height => circle ? size : size;

  @override
  Widget build(BuildContext context) {
    return UnconstrainedBox(
      child: type == null ? _buildDefaultButton(context) : _buildThemeButton(context),
    );
  }

  Widget _buildIcon(Color color) {
    return Center(
      child: loading
          ? loadingBuilder == null
              ? _materialLoading(color)
              : loadingBuilder!(color)
          : Icon(
              icon,
              color: color,
              size: iconSize,
            ),
    );
  }

  Widget _buildDefaultButton(BuildContext context) {
    var primaryColor = ElApp.of(context).theme.primary;
    var textColor = ElApp.of(context).theme.textBlack;
    Color? bgColor;
    Color borderColor = ElApp.of(context).theme.borderColor;
    if (disabledButton) {
      borderColor = borderColor.withOpacity(_disabledOpacity);
      textColor = textColor.withAlpha(_disabledTextAlpha - _iconAlphaDiff);
    } else {
      bgColor = onHover ? primaryColor.withOpacity(0.1) : null;
      borderColor = onTap
          ? primaryColor
          : onHover
              ? primaryColor.withOpacity(0.2)
              : borderColor;
      textColor = onTap || onHover ? primaryColor : textColor.withAlpha(_defaultTextAlpha - _iconAlphaDiff);
    }
    return Container(
      width: _width,
      height: _height,
      decoration: BoxDecoration(
        color: bgColor,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(circle ? 9999 : ElApp.of(context).theme.radius),
      ),
      child: _buildIcon(textColor),
    );
  }

  Widget _buildThemeButton(BuildContext context) {
    Color bgColor = ElApp.of(context).themeColors[type!]!;
    Color textColor = ElApp.of(context).theme.textWhite;
    if (disabledButton) {
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
        borderRadius: BorderRadius.circular(circle ? 9999 : ElApp.of(context).theme.radius),
      ),
      child: _buildIcon(textColor),
    );
  }
}
