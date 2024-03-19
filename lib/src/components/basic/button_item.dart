part of flutter_element_ui;

abstract class _ButtonItem extends _Button {
  const _ButtonItem({
    required super.key,
    super.disabled,
  }) : assert(key is ValueKey<int>, '请传递包含当前按钮索引的ValueKey');

  @override
  State<_ButtonItem> createState();
}

abstract class _ButtonItemState<T extends _ButtonItem> extends _ButtonState<T> {
  /// 按钮当前索引的key
  late int currentIndex = (widget.key as ValueKey<int>).value;

  /// 按钮组数据
  _ButtonGroupData get buttonGroupData;

  /// 按钮组的长度
  int get childrenLength;

  @override
  bool get disabledButton => widget.disabled;

  @override
  Widget build(BuildContext context) {
    buildButtonItemTheme();
    return buildMouseWidget(
      child: buildTapWidget(
        child: buildButton(),
      ),
    );
  }

  @override
  void onEnterEvent(PointerEnterEvent event) {
    buttonGroupData.setOnEnterIndex(currentIndex);
  }

  @override
  void onTapEvent() {
    switch (buttonGroupData.buttonGroupType) {
      case _ButtonGroupType.base:
        if (buttonGroupData.onPressed != null) buttonGroupData.onPressed!(currentIndex);
        break;
      case _ButtonGroupType.single:
        if (buttonGroupData.onChange != null) {
          if (buttonGroupData.index != currentIndex) {
            buttonGroupData.onChange!(currentIndex);
          }
        }
        break;
      case _ButtonGroupType.multiple:
        if (buttonGroupData.onChangeList != null) {
          List<int> indexList = buttonGroupData.indexList;
          int targetIndex = indexList.indexOf(currentIndex);
          if (targetIndex == -1) {
            indexList.add(currentIndex);
          } else {
            indexList.removeAt(targetIndex);
          }
          buttonGroupData.onChangeList!(indexList);
        }
        break;
    }
  }

  void buildButtonItemTheme() {
    if (buttonGroupData.type == null) {
      buildDefaultTheme();
      border = caleDefaultButtonGroupBorder(borderColor!);
      borderRadius = caleButtonGroupBorderRadius($radius);
    } else {
      buildTypeTheme(buttonGroupData.type!);
      border = caleTypeButtonGroupBorder();
      borderRadius = caleButtonGroupBorderRadius($radius);
    }
    switch (buttonGroupData.buttonGroupType) {
      case _ButtonGroupType.base:
        break;
      case _ButtonGroupType.single:
        if (currentIndex == buttonGroupData.index) {
          if (buttonGroupData.type == null) {
            bgColor = $primaryColor.withOpacity(0.1);
            textColor = $primaryColor;
            iconColor = $primaryColor;
          } else {
            bgColor = getThemeTypeColor(buttonGroupData.type!);
            textColor = $textWhiteColor;
            iconColor = $textWhiteColor;
          }
        } else {
          bgColor = null;
          if (buttonGroupData.type == null) {
            textColor = disabledButton
                ? $textColor.withAlpha(_disabledTextAlpha)
                : onHover
                    ? $primaryColor
                    : $textColor;
            iconColor = textColor;
          } else {
            textColor = disabledButton
                ? $textColor.withAlpha(_disabledTextAlpha)
                : onHover
                    ? getThemeTypeColor(buttonGroupData.type!)
                    : $textColor;
            iconColor = textColor;
          }
        }
        break;
      case _ButtonGroupType.multiple:
        if (buttonGroupData.indexList.contains(currentIndex)) {
          if (buttonGroupData.type == null) {
            bgColor = $primaryColor.withOpacity(0.1);
            textColor = $primaryColor;
            iconColor = $primaryColor;
          } else {
            bgColor = getThemeTypeColor(buttonGroupData.type!);
            textColor = $textWhiteColor;
            iconColor = $textWhiteColor;
          }
        } else {
          bgColor = null;
          if (buttonGroupData.type == null) {
            textColor = disabledButton
                ? $textColor.withAlpha(_disabledTextAlpha)
                : onHover
                    ? $primaryColor
                    : $textColor;
            iconColor = textColor;
          } else {
            textColor = disabledButton
                ? $textColor.withAlpha(_disabledTextAlpha)
                : onHover
                    ? getThemeTypeColor(buttonGroupData.type!)
                    : $textColor;
            iconColor = textColor;
          }
        }
        break;
    }
  }

  /// 计算默认样式的按钮组边框
  Border? caleDefaultButtonGroupBorder(Color borderColor) {
    Border allBorder = Border.all(color: borderColor, width: $buttonGroupBorderWidth);
    BorderSide borderSide = BorderSide(color: borderColor, width: $buttonGroupBorderWidth);
    // 如果只有2个button组成，那么只需要简单计算动态切换左右边框即可
    if (childrenLength == 2) {
      if (currentIndex == 0) {
        return buttonGroupData.onEnterIndex == currentIndex
            ? allBorder
            : Border(top: borderSide, left: borderSide, bottom: borderSide);
      } else {
        return buttonGroupData.onEnterIndex == currentIndex
            ? allBorder
            : Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    }
    // 2个以上的button组成的按钮组，需要额外考虑中间的button边框计算
    else {
      // 计算第一个按钮的边缘情况，当鼠标进入第一个按钮后面一个的按钮，那么第一个按钮取消右边框，因为后面那一个按钮需要绘制所有边框
      if (currentIndex == 0) {
        if (buttonGroupData.onEnterIndex == 1) {
          return Border(top: borderSide, left: borderSide, bottom: borderSide);
        } else {
          return allBorder;
        }
      }
      // 计算最后一个按钮的边缘情况，当鼠标进入最后一个按钮，返回全边框，否则不绘制左边框，因为前一个按钮已经绘制了右边框
      else if (currentIndex == childrenLength - 1) {
        if (buttonGroupData.onEnterIndex == childrenLength - 1) {
          return allBorder;
        } else {
          return Border(top: borderSide, right: borderSide, bottom: borderSide);
        }
      }
      // 计算中间按钮的边缘情况，默认返回绘制上边框、下边框、右边框
      else {
        if (buttonGroupData.onEnterIndex == currentIndex) {
          return allBorder;
        }
        // 如果最后一个按钮被选中，那么前一个按钮就无需绘制右边框
        if (buttonGroupData.onEnterIndex == childrenLength - 1) {
          if (currentIndex == childrenLength - 2) {
            return Border(top: borderSide, bottom: borderSide);
          }
        }
        return Border(top: borderSide, right: borderSide, bottom: borderSide);
      }
    }
  }

  /// 计算拥有主题类型的按钮组的边框
  Border? caleTypeButtonGroupBorder() {
    BorderSide borderSide = BorderSide(color: $defaultBorderColor, width: $buttonGroupBorderWidth);
    if (currentIndex == 0) {
      return Border(
        top: borderSide,
        left: borderSide,
        right: borderSide,
        bottom: borderSide,
      );
    } else {
      return Border(
        top: borderSide,
        right: borderSide,
        bottom: borderSide,
      );
    }
  }

  /// 计算按钮组的边框圆角
  BorderRadius caleButtonGroupBorderRadius(double radius) {
    late BorderRadius borderRadius;
    if (childrenLength == 2) {
      if (currentIndex == 0) {
        borderRadius = BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
      } else {
        borderRadius = BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));
      }
    } else {
      if (currentIndex == 0) {
        borderRadius = BorderRadius.only(topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
      } else if (currentIndex == childrenLength - 1) {
        borderRadius = BorderRadius.only(topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));
      } else {
        borderRadius = BorderRadius.zero;
      }
    }
    return borderRadius;
  }
}

/// 按钮组的按钮项，你必须设置当前下标key，用于定位当前按钮所在的位置。
///
/// 例：
/// ```dart
/// const ElButtonGroup(
///   children: [
///     ElButtonItem(
///       key: ValueKey(0), // 下标位置
///       'Item 1',
///     ),
///     ElButtonItem(
///        key: ValueKey(1),
///       'Item 2',
///     ),
///   ],
/// ),
class ElButtonItem extends _ButtonItem {
  const ElButtonItem(
    this.text, {
    required super.key,
    this.leftIcon,
    this.rightIcon,
    super.disabled,
  });

  /// 按钮文字
  final String text;

  /// 普通按钮左图标
  final ElIcon? leftIcon;

  /// 普通按钮右图标
  final ElIcon? rightIcon;

  @override
  State<ElButtonItem> createState() => _ElButtonItemState();
}

class _ElButtonItemState extends _ButtonItemState<ElButtonItem> {
  @override
  _ElButtonGroupData get buttonGroupData => _ElButtonGroupData.of(context);

  @override
  int get childrenLength => buttonGroupData.children.length;

  EdgeInsets get _buttonPadding {
    // 必须单独处理一下多选的padding，否则会存在对齐问题
    if (widget.type == null || buttonGroupData.buttonGroupType != _ButtonGroupType.multiple) {
      return border == null
          ? EdgeInsets.symmetric(horizontal: $buttonHorizontal)
          : EdgeInsets.symmetric(horizontal: $buttonHorizontal - 1);
    } else {
      return border == null
          ? EdgeInsets.symmetric(horizontal: $buttonHorizontal)
          : EdgeInsets.symmetric(horizontal: $buttonHorizontal - 1);
      // if (currentIndex == 0) {
      //   if (buttonGroupData.indexList.contains(currentIndex)) {
      //     return border == null
      //         ? EdgeInsets.symmetric(horizontal: $buttonHorizontal)
      //         : EdgeInsets.only(left: $buttonHorizontal - 1, right: $buttonHorizontal);
      //   }
      // }
      // return border == null
      //     ? EdgeInsets.symmetric(horizontal: $buttonHorizontal)
      //     : EdgeInsets.symmetric(horizontal: $buttonHorizontal - 1);
    }
  }

  @override
  Widget buildButton() {
    return Container(
      height: $buttonHeight,
      padding: _buttonPadding,
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
              if (widget.leftIcon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: ElDefaultIconStyle(
                    color: iconColor,
                    size: $buttonIconSize,
                    child: widget.leftIcon!,
                  ),
                ),
              Text(
                widget.text,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (widget.rightIcon != null)
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: ElDefaultIconStyle(
                    color: iconColor,
                    size: $buttonIconSize,
                    child: widget.rightIcon!,
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
    bgColor = themeColor;
    if (super.disabledButton) {
      bgColor = bgColor!.withOpacity(_disabledOpacity);
      border = null;
    } else {
      bgColor = super.onTap
          ? themeColor.darken(15)
          : super.onHover
              ? themeColor.withOpacity(0.8)
              : bgColor;
    }
    borderRadius = BorderRadius.circular($radius);
  }
}

class ElIconButtonItem extends _ButtonItem {
  const ElIconButtonItem(
    this.icon, {
    required super.key,
    super.disabled,
  }) : assert(key is ValueKey<int>, '请传递包含当前按钮索引的ValueKey');

  /// 按钮图标
  final ElIcon icon;

  @override
  State<ElIconButtonItem> createState() => _ElIconButtonItemState();
}

class _ElIconButtonItemState extends _ButtonItemState<ElIconButtonItem> {
  double get _horizontal => ($buttonHeight - $buttonIconSize / 2) / 2;

  @override
  _ElIconButtonGroupData get buttonGroupData => _ElIconButtonGroupData.of(context);

  @override
  int get childrenLength => buttonGroupData.children.length;

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
    super.buildButtonItemTheme();
    return UnconstrainedBox(
      child: Container(
        height: $buttonHeight,
        // width: 40,
        padding: border == null
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
                  size: $buttonIconSize,
                  child: widget.icon,
                ),
        ),
      ),
    );
  }
}
