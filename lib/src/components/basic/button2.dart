part of flutter_element_ui;

enum _ButtonType { base, text, icon }

Widget _materialLoading(Color color) => SizedBox(
      width: 14,
      height: 14,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        color: color,
      ),
    );

/// Element UI 按钮组件
class ElButton2 extends StatefulWidget {
  /// 渲染普通按钮，提示：[ElButton2]实际上是一个[Container]，如果遇到布局问题，请留意flutter中的布局约束。
  ///
  /// https://flutter.cn/docs/ui/layout/constraints
  const ElButton2(
    this.text, {
    super.key,
    this.onPressed,
    this.leftIcon,
    this.rightIcon,
    this.height,
    this.type,
    this.iconSize = _buttonHeight,
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
  const ElButton2.text(
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
  const ElButton2.icon(
    this.icon, {
    super.key,
    this.onPressed,
    this.type,
    this.circle = false,
    this.size = _buttonHeight,
    this.disabled = false,
    this.tooltip,
    this.disabledTooltip,
    this.loading = false,
    this.loadingBuilder,
    this.iconSize,
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
  final ElIcon? icon;

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
  final double? iconSize;

  /// 提示文字
  final String? tooltip;

  /// 禁用提示文字
  final String? disabledTooltip;

  /// 是否显示loading
  final bool loading;

  /// 自定义loading组件
  final Widget Function(Color color)? loadingBuilder;

  @override
  State<ElButton2> createState() => _ElButtonState2();
}

class _ElButtonState2 extends State<ElButton2> with ElMouseMixin, ElTapMixin {
  /// 此按钮是否属于按钮组成员，如果父级组件存在[ElButtonGroup]，那么它为true
  late bool _isButtonGroupItem;

  /// 按钮组数据
  _ElButtonGroupData? buttonGroupData;

  /// 按钮当前索引的key，如果是按钮组，那么此值必须存在
  int? _currentKeyValue;

  bool get _disabledButton {
    if (_isButtonGroupItem) {
      return widget.disabled;
    } else {
      return widget.disabled || widget.onPressed == null;
    }
  }

  @override
  bool get disabledHover => _disabledButton;

  @override
  bool get disabledTap => _disabledButton;

  @override
  void onEnterEvent(PointerEnterEvent event) {
    if (_isButtonGroupItem) {
      buttonGroupData!.setOnEnterIndex(_currentKeyValue!);
    }
  }

  @override
  void onTapEvent() {
    if (_isButtonGroupItem) {
      if (widget.onPressed != null) widget.onPressed!();
      switch (buttonGroupData!.buttonGroupType) {
        case _ButtonGroupType.base:
          break;
        case _ButtonGroupType.single:
          if (buttonGroupData!.onChange != null) {
            if (buttonGroupData!.index != _currentKeyValue) {
              buttonGroupData!.onChange!(_currentKeyValue!);
            }
          }
          break;
        case _ButtonGroupType.multiple:
          if (buttonGroupData!.onChangeList != null) {
            List<int> indexList = buttonGroupData!.indexList;
            int targetIndex = indexList.indexOf(_currentKeyValue!);
            if (targetIndex == -1) {
              indexList.add(_currentKeyValue!);
            } else {
              indexList.removeAt(targetIndex);
            }
            buttonGroupData!.onChangeList!(indexList);
          }
          break;
      }
    } else {
      widget.onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    buttonGroupData = _ElButtonGroupData.of(context);
    _isButtonGroupItem = buttonGroupData != null;
    if (_isButtonGroupItem) {
      assert(
          widget.key != null && widget.key is ValueKey<int>, '你声明了ElButtonGroup，但是ElButton的key参数却没有设置ValueKey<int>，请传递包含当前按钮索引的ValueKey');
      _currentKeyValue = (widget.key! as ValueKey<int>).value;
    }
    late Widget buttonWidget;
    switch (widget._buttonType) {
      case _ButtonType.base:
        assert(widget.text != null, 'text不能为null');
        buttonWidget = _BaseButton(
          buttonType: widget._buttonType,
          onHover: onHover,
          onTap: onTap,
          disabledButton: _disabledButton,
          currentKeyValue: _currentKeyValue,
          isButtonGroupItem: _isButtonGroupItem,
          buttonGroupData: buttonGroupData,
          text: widget.text!,
          type: widget.type,
          height: widget.height ?? _buttonHeight,
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
          buttonType: widget._buttonType,
          onHover: onHover,
          onTap: onTap,
          disabledButton: _disabledButton,
          currentKeyValue: _currentKeyValue,
          isButtonGroupItem: _isButtonGroupItem,
          buttonGroupData: buttonGroupData,
          text: widget.text!,
          type: widget.type,
          height: widget.height ?? _buttonHeight,
          bg: widget.bg,
          loading: widget.loading,
          loadingBuilder: widget.loadingBuilder,
        );
        break;
      case _ButtonType.icon:
        assert(widget.icon != null, 'icon不能为null');
        buttonWidget = _IconButton(
          buttonType: widget._buttonType,
          onHover: onHover,
          onTap: onTap,
          disabledButton: _disabledButton,
          currentKeyValue: _currentKeyValue,
          isButtonGroupItem: _isButtonGroupItem,
          buttonGroupData: buttonGroupData,
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
    return buildMouseWidget(
      child: buildTapWidget(
        child: buttonWidget,
      ),
    );
  }
}

class _BaseButton extends _Button2 {
  const _BaseButton({
    required super.buttonType,
    required super.onHover,
    required super.onTap,
    required super.disabledButton,
    required super.currentKeyValue,
    required super.isButtonGroupItem,
    required super.buttonGroupData,
    super.type,
    required super.round,
    required super.loading,
    super.loadingBuilder,
    required this.text,
    required this.height,
    required this.plain,
    this.leftIcon,
    this.rightIcon,
    this.iconSize,
  });

  final String text;
  final double height;
  final bool plain;
  final IconData? leftIcon;
  final IconData? rightIcon;
  final double? iconSize;

  @override
  _ButtonState2 createState() => _BaseButtonState();
}

class _BaseButtonState extends _ButtonState2<_BaseButton> {
  bool get noText => widget.text == '';

  /// 默认水平间距
  static const double _defaultHorizontal = 15;

  @override
  Widget build(BuildContext context) {
    super.buildButtonTheme();
    return Container(
      height: widget.height,
      padding: border == null
          ? const EdgeInsets.symmetric(horizontal: _defaultHorizontal)
          : const EdgeInsets.symmetric(horizontal: _defaultHorizontal - 1),
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
                      ? CupertinoActivityIndicator(
                          radius: 8,
                          color: widget.type == null ? textColor : ElThemeData.white,
                        )
                      : widget.loadingBuilder!(iconColor!),
                ),
              if (widget.leftIcon != null)
                Padding(
                  padding: noText ? EdgeInsets.zero : const EdgeInsets.only(right: 4),
                  child: Icon(
                    widget.leftIcon,
                    color: iconColor,
                    size: widget.iconSize,
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
                  child: Icon(
                    widget.rightIcon,
                    color: iconColor,
                    size: widget.iconSize,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void buildDefaultTheme() {
    textColor = textBlack;
    iconColor = textColor!.withAlpha(_defaultTextAlpha - _iconAlphaDiff);
    borderColor = defaultBorderColor;
    if (widget.disabledButton) {
      borderColor = borderColor!.withOpacity(_disabledOpacity);
      textColor = textColor!.withAlpha(_disabledTextAlpha);
      iconColor = iconColor!.withAlpha(_disabledTextAlpha - _iconAlphaDiff);
    } else {
      bgColor = widget.onHover ? primaryColor.withOpacity(0.1) : null;
      textColor = widget.onTap || widget.onHover ? primaryColor : textColor!.withAlpha(_defaultTextAlpha);
      iconColor = widget.onTap || widget.onHover ? primaryColor : iconColor;
      borderColor = widget.onTap
          ? primaryColor
          : widget.onHover
              ? primaryColor.withOpacity(0.2)
              : defaultBorderColor;
    }

    border = Border.all(color: borderColor!);
    borderRadius = BorderRadius.circular(radius);
  }

  @override
  void buildTypeTheme(ElThemeType type) {
    Color themeColor = getThemeTypeColor(type);
    textColor = textWhite;
    iconColor = textColor;
    if (widget.plain) {
      textColor = widget.onTap || widget.onHover ? textWhite : themeColor;
      iconColor = widget.onTap || widget.onHover ? textWhite : themeColor;
      border = Border.all(color: themeColor.withOpacity(0.5));
      bgColor = widget.onTap
          ? themeColor.darken(15)
          : widget.onHover
              ? bgColor
              : themeColor.withAlpha(25);
    } else {
      bgColor = themeColor;
    }
    if (widget.disabledButton) {
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
      bgColor = widget.onTap
          ? themeColor.darken(15)
          : widget.onHover
              ? widget.plain
                  ? themeColor
                  : themeColor.withOpacity(0.8)
              : bgColor;
    }
    borderRadius = BorderRadius.circular(radius);
  }
}

class _TextButton extends _Button2 {
  const _TextButton({
    required super.buttonType,
    required super.onHover,
    required super.onTap,
    required super.disabledButton,
    super.currentKeyValue,
    required super.isButtonGroupItem,
    required super.buttonGroupData,
    required this.text,
    super.type,
    required this.height,
    required this.bg,
    required super.loading,
    super.loadingBuilder,
  });

  final String text;
  final double height;
  final bool bg;

  @override
  _ButtonState2 createState() => _TextButtonState();
}

class _TextButtonState extends _ButtonState2<_TextButton> {
  @override
  Widget build(BuildContext context) {
    bgColor = ElApp.of(context).theme.info.withAlpha(160);
    textColor = textBlack;
    if (widget.disabledButton) {
      bgColor = widget.bg ? bgColor!.withAlpha(15) : null;
      textColor =
          widget.type == null ? textColor!.withAlpha(_disabledTextAlpha) : getThemeTypeColor(widget.type!).withAlpha(_disabledTextAlpha);
    } else {
      if (widget.bg) {
        bgColor = widget.onTap
            ? bgColor!.withAlpha(50)
            : widget.onHover
                ? bgColor!.withAlpha(40)
                : bgColor!.withAlpha(25);
      } else {
        bgColor = widget.onTap
            ? bgColor!.withAlpha(50)
            : widget.onHover
                ? bgColor!.withAlpha(25)
                : null;
      }
      if (widget.type == null) {
        textColor = textColor!.withAlpha(_defaultTextAlpha);
      } else {
        textColor = getThemeTypeColor(widget.type!);
      }
    }
    return Container(
      height: widget.height,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: UnconstrainedBox(
        child: Center(
          child: widget.loading
              ? widget.loadingBuilder == null
                  ? _materialLoading(textColor!)
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

class _IconButton extends _Button2 {
  const _IconButton({
    required super.buttonType,
    required super.onHover,
    required super.onTap,
    required super.disabledButton,
    super.currentKeyValue,
    required super.isButtonGroupItem,
    required super.buttonGroupData,
    required this.icon,
    super.type,
    required super.circle,
    required this.size,
    this.iconSize,
    required super.loading,
    super.loadingBuilder,
  });

  final ElIcon icon;
  final double size;
  final double? iconSize;

  @override
  _ButtonState2 createState() => _IconButtonState();
}

class _IconButtonState extends _ButtonState2<_IconButton> {
  double get iconSize => widget.iconSize ?? ElApp.of(context).theme.iconSize;

  double get _width => widget.circle ? widget.size : widget.size * 1.2;

  double get _height => widget.circle ? widget.size : widget.size;

  /// 默认水平间距
  double get _defaultHorizontal => (widget.size - iconSize / 2) / 2;

  bool get isCircleButton => widget.circle && !widget.isButtonGroupItem;

  @override
  Widget build(BuildContext context) {
    super.buildButtonTheme();
    return UnconstrainedBox(
      child: Container(
        height: _height,
        width: isCircleButton ? _width : null,
        padding: isCircleButton
            ? null
            : border == null
                ? EdgeInsets.symmetric(horizontal: _defaultHorizontal)
                : EdgeInsets.symmetric(horizontal: _defaultHorizontal - 1),
        decoration: BoxDecoration(
          color: bgColor,
          border: border,
          borderRadius: borderRadius,
        ),
        child: Center(
          child: widget.loading
              ? widget.loadingBuilder == null
                  ? _materialLoading(textColor!)
                  : widget.loadingBuilder!(textColor!)
              : ElDefaultIconStyle(
                  color: textColor,
                  child: widget.icon,
                ),
        ),
      ),
    );
  }

  @override
  void buildDefaultTheme() {
    textColor = textBlack;
    borderColor = defaultBorderColor;
    if (widget.disabledButton) {
      borderColor = borderColor!.withOpacity(_disabledOpacity);
      textColor = textColor!.withAlpha(_disabledTextAlpha - _iconAlphaDiff);
    } else {
      bgColor = widget.onHover ? primaryColor.withOpacity(0.1) : null;
      borderColor = widget.onTap
          ? primaryColor
          : widget.onHover
              ? primaryColor.withOpacity(0.2)
              : defaultBorderColor;
      textColor = widget.onTap || widget.onHover ? primaryColor : textColor!.withAlpha(_defaultTextAlpha - _iconAlphaDiff);
    }
    border = Border.all(color: borderColor!);
    borderRadius = BorderRadius.circular(radius);
  }

  @override
  void buildTypeTheme(ElThemeType type) {
    bgColor = getThemeTypeColor(type);
    textColor = textWhite;
    if (widget.disabledButton) {
      bgColor = bgColor!.withOpacity(_disabledOpacity);
    } else {
      bgColor = widget.onTap
          ? bgColor!.darken(15)
          : widget.onHover
              ? bgColor!.withOpacity(0.8)
              : bgColor;
    }
    borderRadius = BorderRadius.circular(radius);
  }
}

abstract class _Button2 extends StatefulWidget {
  const _Button2({
    required this.buttonType,
    required this.onHover,
    required this.onTap,
    required this.disabledButton,
    this.currentKeyValue,
    required this.isButtonGroupItem,
    this.buttonGroupData,
    this.type,
    this.round = false,
    this.circle = false,
    required this.loading,
    this.loadingBuilder,
  });

  final _ButtonType buttonType;
  final bool onHover;
  final bool onTap;
  final bool disabledButton;
  final int? currentKeyValue;
  final bool isButtonGroupItem;
  final _ElButtonGroupData? buttonGroupData;
  final ElThemeType? type;
  final bool round;
  final bool circle;
  final bool loading;
  final Widget Function(Color color)? loadingBuilder;

  @override
  State<_Button2> createState() => _ButtonState2();
}

class _ButtonState2<T extends _Button2> extends State<T> {
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

  /// 默认的按钮边框圆角
  double get radius => widget.round || widget.circle ? 9999 : ElApp.of(context).theme.radius;

  Color get primaryColor => ElApp.of(context).theme.primary;

  Color get textWhite => ElApp.of(context).darkTheme.textColor;

  Color get textBlack => ElApp.of(context).theme.textColor;

  Color get defaultBorderColor => ElApp.of(context).theme.defaultBorderColor;

  /// 当前按钮是否是默认类型的button
  bool get isDefaultTypeButton {
    if (widget.isButtonGroupItem) {
      return widget.buttonGroupData!.type == null;
    } else {
      return widget.type == null;
    }
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  /// 构建普通button主题
  void buildDefaultTheme() {}

  /// 构建指定类型的主题色
  void buildTypeTheme(ElThemeType type) {}

  Color getThemeTypeColor(ElThemeType type) {
    return ElApp.of(context).themeColors[type]!;
  }

  /// 构建按钮主题，它适用于所有button，不过按钮主题的具体实现由子类决定
  void buildButtonTheme() {
    if (widget.isButtonGroupItem) {
      if (widget.buttonGroupData!.type == null) {
        buildDefaultTheme();
        border = caleDefaultButtonGroupBorder(borderColor!);
        borderRadius = caleButtonGroupBorderRadius(radius);
      } else {
        buildTypeTheme(widget.buttonGroupData!.type!);
        border = caleTypeButtonGroupBorder();
        borderRadius = caleButtonGroupBorderRadius(radius);
      }
      switch (widget.buttonGroupData!.buttonGroupType) {
        case _ButtonGroupType.base:
          break;
        case _ButtonGroupType.single:
          if (widget.currentKeyValue == widget.buttonGroupData!.index) {
            if (widget.buttonGroupData!.type == null) {
              bgColor = primaryColor.withOpacity(0.1);
              textColor = primaryColor;
              iconColor = primaryColor;
            } else {
              bgColor = getThemeTypeColor(widget.buttonGroupData!.type!);
              textColor = textWhite;
              iconColor = textWhite;
              border = null;
            }
          } else {
            bgColor = null;
            if (widget.buttonGroupData!.type == null) {
              textColor = widget.onHover ? primaryColor : textBlack;
              iconColor = textColor;
            } else {
              textColor = widget.onHover ? getThemeTypeColor(widget.buttonGroupData!.type!) : textBlack;
              iconColor = textColor;
            }
          }
          break;
        case _ButtonGroupType.multiple:
          break;
      }
    } else {
      widget.type == null ? buildDefaultTheme() : buildTypeTheme(widget.type!);
    }
  }

  /// 计算默认样式的按钮组边框
  Border? caleDefaultButtonGroupBorder(Color borderColor) {
    BorderSide borderSide = BorderSide(color: borderColor);
    if (widget.buttonGroupData!.children.length == 2) {
      if (widget.currentKeyValue == 0) {
        return widget.buttonGroupData!.onEnterIndex == widget.currentKeyValue
            ? Border.all(color: borderColor)
            : Border(top: borderSide, left: borderSide, bottom: borderSide);
      } else {
        return widget.buttonGroupData!.onEnterIndex == widget.currentKeyValue
            ? Border.all(color: borderColor)
            : Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    } else {
      // 计算第一个按钮的边缘情况，当鼠标进入第一个按钮后面一个的按钮，那么第一个按钮取消右边框，因为后面那一个按钮需要绘制所有边框
      if (widget.currentKeyValue == 0) {
        if (widget.buttonGroupData!.onEnterIndex == 1) {
          return Border(top: borderSide, left: borderSide, bottom: borderSide);
        } else {
          return Border.all(color: borderColor);
        }
      }
      // 计算最后一个按钮的边缘情况，当鼠标进入最后一个按钮，返回全边框，否则不绘制左边框，因为前一个按钮已经绘制了右边框
      else if (widget.currentKeyValue == widget.buttonGroupData!.children.length - 1) {
        if (widget.buttonGroupData!.onEnterIndex == widget.buttonGroupData!.children.length - 1) {
          return Border.all(color: borderColor);
        } else {
          return Border(top: borderSide, right: borderSide, bottom: borderSide);
        }
      }
      // 计算中间按钮的边缘情况，默认返回绘制上边框、下边框、右边框
      else {
        if (widget.buttonGroupData!.onEnterIndex == widget.currentKeyValue) {
          return Border.all(color: borderColor);
        }
        // 如果最后一个按钮被选中，那么前一个按钮就无需绘制右边框
        if (widget.buttonGroupData!.onEnterIndex == widget.buttonGroupData!.children.length - 1) {
          if (widget.currentKeyValue == widget.buttonGroupData!.children.length - 2) {
            return Border(top: borderSide, bottom: borderSide);
          }
        }
        return Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    }
  }

  /// 计算拥有主题类型的按钮组的边框
  Border? caleTypeButtonGroupBorder() {
    if (widget.buttonGroupData!.buttonGroupType == _ButtonGroupType.base) {
      BorderSide borderSide = BorderSide(color: textWhite, width: 0.5);
      if (widget.buttonGroupData!.children.length == 2) {
        if (widget.currentKeyValue == 0) {
          return Border(right: borderSide);
        }
      } else {
        if (widget.currentKeyValue != widget.buttonGroupData!.children.length - 1) {
          return Border(right: borderSide);
        }
      }
    } else {
      BorderSide borderSide = BorderSide(color: defaultBorderColor);
      if (widget.buttonGroupData!.children.length == 2) {
        if (widget.currentKeyValue == 0) {
          return Border(top: borderSide, left: borderSide, bottom: borderSide);
        } else {
          return Border(top: borderSide, right: borderSide, bottom: borderSide);
        }
      } else {
        return Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    }

    return null;
  }

  /// 计算按钮组的边框圆角
  BorderRadius caleButtonGroupBorderRadius(double radius) {
    late BorderRadius borderRadius;
    if (widget.buttonGroupData!.children.length == 2) {
      if (widget.currentKeyValue == 0) {
        borderRadius = BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
      } else {
        borderRadius = BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));
      }
    } else {
      if (widget.currentKeyValue == 0) {
        borderRadius = BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
      } else if (widget.currentKeyValue == widget.buttonGroupData!.children.length - 1) {
        borderRadius = BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));
      } else {
        borderRadius = BorderRadius.zero;
      }
    }
    return borderRadius;
  }
}
