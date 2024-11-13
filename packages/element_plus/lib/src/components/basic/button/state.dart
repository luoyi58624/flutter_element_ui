part of 'index.dart';

/// 按钮最小宽度
const double _minWidth = 64;

/// 按钮动画持续时间，默认 100 毫秒
const _duration = Duration(milliseconds: 100);

/// 按钮默认文本样式
const _defaultTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

class _ElButtonState extends State<ElButton> {
  /// 如果是按钮组，则会初始化此变量
  _ElButtonGroupInheritedWidget? _groupData;

  /// 如果是按钮组，此变量将保存当前按钮所在的位置
  ElChildIndex? _indexData;

  /// 如果是按钮组，当前按钮是否被选中
  bool _isSelected = false;

  /// 按钮最终的 prop 配置
  late _ButtonProp _prop;

  /// 按钮颜色样式
  late _ButtonColorStyle _colorStyle;

  late MouseCursor _cursor;

  bool _isTap = false;
  bool _isHover = false;

  bool get _isIconChild => _prop.child is ElIcon || _prop.child is Icon;

  bool get _hasGroup => _groupData != null;

  @override
  Widget build(BuildContext context) {
    _groupData = _ElButtonGroupInheritedWidget.maybeOf(context);
    if (_hasGroup) {
      _indexData = ElChildIndex.of(context);
      _isSelected = false;
      if (_groupData!.modelValue != null) {
        if (_groupData!.modelValue is List) {
          if (_groupData!.modelValue.contains(_indexData!.index)) {
            _isSelected = true;
          }
        } else if (_groupData!.modelValue == _indexData!.index) {
          _isSelected = true;
        }
      }
    } else {
      ElAssert.themeType(widget.type, 'ElButton');
    }

    _prop = _ButtonProp.create(context, widget, _hasGroup);

    _cursor = _prop.loading
        ? MouseCursor.defer
        : _prop.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click;
    Widget result = _buildButtonEvent();

    return (_prop.block || _groupData != null) && !_prop.circle
        ? result
        : UnconstrainedBox(child: result);
  }

  /// 构建按钮事件
  Widget _buildButtonEvent() {
    return ElEvent(
      cursor: _cursor,
      hitTestBehavior: HitTestBehavior.deferToChild,
      onHover: widget.onHover,
      onEnter: (e) {
        setState(() {
          _isHover = true;
        });
        if (_hasGroup) {
          _groupData!.hoverIndex.value = _indexData!.index;
        }
      },
      onExit: (e) {
        setState(() {
          _isHover = false;
        });
        if (_hasGroup) {
          _groupData!.hoverIndex.value = -1;
        }
      },
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!();
        if (_hasGroup) {
          _groupData!.onChanged(_indexData!.index);
        }
      },
      onTapDown: (e) {
        setState(() {
          _isTap = true;
        });
        if (widget.onTapDown != null) widget.onTapDown!(e.toDetails);
        if (_hasGroup) {
          _groupData!.tapIndex.value = _indexData!.index;
        }
      },
      onTapUp: (e) {
        setState(() {
          _isTap = false;
        });
        if (widget.onTapUp != null) widget.onTapUp!(e.toDetails);
        if (_hasGroup) {
          _groupData!.tapIndex.value = -1;
        }
      },
      onTapCancel: () {
        setState(() {
          _isTap = false;
        });
        if (widget.onTapCancel != null) widget.onTapCancel!();
        if (_hasGroup) {
          _groupData!.tapIndex.value = -1;
        }
      },
      disabled: _prop.disabled,
      tapUpDelay: max(_duration.inMilliseconds, 100),
      child: Builder(
        builder: (context) {
          if (_prop.disabled) {
            _isHover = false;
            if (_hasGroup) {
              nextTick(() {
                _groupData!.hoverIndex.value = -1;
              });
            }
          }
          if (_prop.loading && _prop.loadingBuilder != null) {
            _colorStyle = _ButtonColors.loadingButton(
              context,
              bgColor: _prop.bgColor,
              link: _prop.link,
              text: _prop.text,
              plain: _prop.plain,
            );
          } else {
            final $colorStyleProp = (
              bgColor: _prop.bgColor,
              plain: _prop.plain,
              text: _prop.text,
              bg: _prop.bg,
              link: _prop.link,
              disabled: _prop.disabled,
            );
            if (_groupData == null ||
                _groupData!.type == _ButtonGroupType.none) {
              _colorStyle = _ButtonColors.calcColorStyle(
                context,
                prop: $colorStyleProp,
                isHover: _isHover,
                isTap: _isTap,
              );
            } else {
              _colorStyle = _ButtonColors.calcGroupColorStyle(
                context,
                prop: $colorStyleProp,
                isHover: _isHover,
                isTap: _isTap,
                isSelected: _isSelected,
              );
            }
          }
          return _buildButtonWrapper(context);
        },
      ),
    );
  }

  /// 构建按钮外观
  Widget _buildButtonWrapper(BuildContext context) {
    final $constraints = _prop.link
        ? null
        : BoxConstraints(
            minHeight: _prop.height,
            minWidth: (_prop.circle
                ? _prop.height
                : _prop.width ??
                    (_isIconChild ? _prop.height * 1.25 : _minWidth)),
          );

    Widget result = Center(
      child: Builder(builder: (context) {
        return _buildButtonContent(context);
      }),
    );

    if (_prop.padding != null) {
      result = Padding(padding: _prop.padding!, child: result);
    }

    if ($constraints != null) {
      result = ConstrainedBox(constraints: $constraints, child: result);
    }

    result = ElAnimatedDefaultTextStyle(
      duration: context.elDuration(_prop.duration),
      style: _defaultTextStyle.copyWith(
        color: _colorStyle.textColor,
      ),
      child: AnimatedDecoratedBox(
        duration: context.elDuration(_prop.duration),
        decoration: BoxDecoration(
          color: _colorStyle.bgColor,
          border: _calcBorder(context, _colorStyle.borderColor),
          borderRadius: _calcBorderRadius(context),
        ),
        child: result,
      ),
    );

    if (_prop.loadingBuilder != null && _prop.loading) {
      assert(_colorStyle.loadingTextColor != null,
          ElAssert.elementError('ElButton loadingBuilder color 参数不能为空'));
      result = Stack(
        children: [
          result,
          Positioned.fill(
            child: ElDefaultTextStyle(
              style: _defaultTextStyle.copyWith(
                color: _colorStyle.loadingTextColor,
              ),
              child: Center(
                child: _buildIconTheme(
                  color: _colorStyle.loadingTextColor,
                  child: _prop.loadingBuilder!(
                    ElButtonLoadingState(
                      color: _colorStyle.loadingTextColor!,
                      size: _prop.iconSize,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }
    return result;
  }

  /// 构建默认的图标主题
  Widget _buildIconTheme({required Widget child, Color? color}) {
    return ElIconTheme(
      data: ElIconThemeData(
        size: _prop.iconSize,
        color: color,
      ),
      child: child,
    );
  }

  /// 构建按钮内容
  Widget _buildButtonContent(BuildContext context) {
    late Widget $child;
    if (_prop.child is Widget) {
      $child = _prop.child;
    } else {
      $child = ElText('${_prop.child}');
    }

    Widget? $leftIcon = _prop.leftIcon;
    Widget? $rightIcon = _prop.rightIcon;
    if (_prop.loadingBuilder == null && _prop.loading) {
      if ($leftIcon != null) {
        $leftIcon = _prop.loadingWidget;
      } else if ($rightIcon != null) {
        $rightIcon = _prop.loadingWidget;
      } else {
        if (!_isIconChild) {
          $leftIcon = _prop.loadingWidget;
        }
      }
    }

    Widget childContent = Padding(
      padding: EdgeInsets.only(
        left: $leftIcon != null ? 6.0 : 0.0,
        right: $rightIcon != null ? 6.0 : 0.0,
      ),
      child: _prop.loadingBuilder == null &&
              _prop.leftIcon == null &&
              _prop.loading &&
              _isIconChild
          ? _prop.loadingWidget
          : $child,
    );

    childContent = DefaultSelectionStyle(
      mouseCursor: _cursor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ($leftIcon != null) $leftIcon,
          childContent,
          if ($rightIcon != null) $rightIcon,
        ],
      ),
    );

    if (_prop.loadingBuilder != null) {
      childContent = Opacity(
        opacity: _prop.loading == true ? 0.0 : 1.0,
        child: childContent,
      );
    }

    $child = _buildIconTheme(
      color: ElDefaultTextStyle.of(context).style.color,
      child: childContent,
    );

    return $child;
  }

  Border _calcBorder(BuildContext context, Color? borderColor) {
    if (borderColor == null) return const Border();
    final defaultBorder = Border.all(
      color: borderColor,
      width: _isHover || _isTap || _isSelected
          ? _prop.borderActiveWidth
          : _prop.borderWidth,
    );
    if (!_hasGroup) return defaultBorder;
    if (_indexData!.length == 0) return const Border();
    if (_indexData!.length == 1) return defaultBorder;
    final borderSide = BorderSide(
      color: borderColor,
      width: max(defaultBorder.left.width, defaultBorder.right.width),
    );
    final isHorizontal = _groupData!.axis == Axis.horizontal;
    if (_indexData!.index == 0) {
      return Border(
        top: borderSide,
        bottom: isHorizontal ? borderSide : BorderSide.none,
        left: borderSide,
        right: !isHorizontal ? borderSide : BorderSide.none,
      );
    }
    if (_indexData!.index == _indexData!.length! - 1) {
      return Border(
        top: isHorizontal ? borderSide : BorderSide.none,
        bottom: borderSide,
        left: !isHorizontal ? borderSide : BorderSide.none,
        right: borderSide,
      );
    }
    return Border(
      top: isHorizontal ? borderSide : BorderSide.none,
      bottom: isHorizontal ? borderSide : BorderSide.none,
      left: !isHorizontal ? borderSide : BorderSide.none,
      right: !isHorizontal ? borderSide : BorderSide.none,
    );
  }

  BorderRadiusGeometry? _calcBorderRadius(BuildContext context) {
    if (!_hasGroup) return _prop.borderRadius;

    final isHorizontal = _groupData!.axis == Axis.horizontal;
    if (_indexData!.length == 1) return _prop.borderRadius;
    if (_indexData!.index == 0) {
      return BorderRadius.only(
        topLeft: _prop.borderRadius.topLeft,
        topRight: !isHorizontal ? _prop.borderRadius.topLeft : Radius.zero,
        bottomLeft: isHorizontal ? _prop.borderRadius.bottomLeft : Radius.zero,
      );
    }
    if (_indexData!.index == _indexData!.length! - 1) {
      return BorderRadius.only(
        topRight: isHorizontal ? _prop.borderRadius.topRight : Radius.zero,
        bottomLeft: !isHorizontal ? _prop.borderRadius.topLeft : Radius.zero,
        bottomRight: _prop.borderRadius.bottomRight,
      );
    }
    return null;
  }
}
