part of 'index.dart';

class _ElButtonState extends State<ElButton> {
  /// 如果是按钮组，则会初始化此变量
  _ElButtonGroupInheritedWidget? _groupData;

  /// 如果是按钮组，此变量将保存当前按钮所在的位置
  ChildIndexData? _indexData;

  /// 按钮 prop 配置
  late _ButtonProp _prop;

  /// 按钮颜色样式
  late _ColorStyle _colorStyle;

  /// child 是否是图标
  bool get _isIconChild => _prop.child is ElIcon || _prop.child is Icon;

  /// 当前是否处于按钮组环境下
  bool get _hasGroup => _groupData != null;

  @override
  Widget build(BuildContext context) {
    _groupData = _ElButtonGroupInheritedWidget.maybeOf(context);
    if (_hasGroup) {
      _indexData = ChildIndexData.of(context);
    } else {
      ElAssert.themeType(widget.type, 'ElButton');
    }

    _prop = _ButtonProp.create(context, widget, _hasGroup);

    Widget result = _buildEvent(
      builder: (context) {
        bool $isHover = context.isHover;
        bool $isTap = context.isTap;

        if (_hasGroup) {
          final $isSelected = _ButtonGroupUtil.isSelected(
            _groupData!.modelValue,
            _indexData!.index,
          );
          if ($isSelected) {
            $isHover = true;
          }
        }

        _colorStyle = _ButtonStyleUtil._calcColorStyle(
          context,
          prop: _prop,
          isHover: $isHover,
          isTap: $isTap,
        );

        if (_hasGroup) {
          nextTick(() {
            _groupData!.borderColor.value = _colorStyle.borderColor;
          });
        }
        return _buildButtonWrapper(context);
      },
    );

    return _prop.block && !_prop.circle
        ? result
        : UnconstrainedBox(child: result);
  }

  /// 构建按钮事件
  Widget _buildEvent({required WidgetBuilder builder}) {
    return ElTapBuilder(
      onTap: () {
        if (widget.onPressed != null) widget.onPressed!();
        if (_hasGroup) {
          _groupData!.onChanged(_indexData!.index);
        }
      },
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: _prop.disabled,
      delay: _duration.inMilliseconds,
      builder: (context) {
        return ElHoverBuilder(
          cursor: _prop.loading
              ? MouseCursor.defer
              : _prop.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          hitTestBehavior: HitTestBehavior.deferToChild,
          disabled: _prop.disabled,
          onHover: widget.onHover,
          onEnter: (e) {
            if (_hasGroup) {
              if (_buttonGroupHoverExitTimer != null) {
                _buttonGroupHoverExitTimer!.cancel();
                _buttonGroupHoverExitTimer = null;
              }
              _groupData!.hoverIndex.value = _indexData!.index;
            }
          },
          onExit: (e) {
            if (_hasGroup) {
              _buttonGroupHoverExitTimer = setTimeout(() {
                _groupData!.hoverIndex.value = -1;
              }, _duration.inMilliseconds);
            }
          },
          builder: (context) => builder(context),
        );
      },
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

    result = ElDefaultTextStyle.merge(
      style: _defaultTextStyle.copyWith(
        color: _colorStyle.textColor,
      ),
      child: AnimatedDecoratedBox(
        duration: context.elDuration(_duration),
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
            child: ElDefaultTextStyle.merge(
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

    childContent = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if ($leftIcon != null) $leftIcon,
        childContent,
        if ($rightIcon != null) $rightIcon,
      ],
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
    final defaultBorder = _prop.borderBuilder(borderColor);
    if (_groupData == null) return defaultBorder;
    if (_indexData!.length == 0) return const Border();
    if (_indexData!.length == 1) return defaultBorder;
    final borderSide = BorderSide(
      color: borderColor,
      width: max(defaultBorder.left.width, defaultBorder.right.width),
    );
    if (_indexData!.index == 0) {
      return Border(
        top: borderSide,
        bottom: borderSide,
        left: borderSide,
      );
    }
    if (_indexData!.index == _indexData!.length! - 1) {
      return Border(
        top: borderSide,
        bottom: borderSide,
        right: borderSide,
      );
    }
    return Border(
      top: borderSide,
      bottom: borderSide,
    );
  }

  BorderRadiusGeometry? _calcBorderRadius(BuildContext context) {
    if (_groupData == null) return _prop.borderRadius;
    if (_indexData!.length == 1) return _prop.borderRadius;
    if (_indexData!.index == 0) {
      return BorderRadius.only(
        topLeft: _prop.borderRadius.topLeft,
        bottomLeft: _prop.borderRadius.bottomLeft,
      );
    }
    if (_indexData!.index == _indexData!.length! - 1) {
      return BorderRadius.only(
        topRight: _prop.borderRadius.topRight,
        bottomRight: _prop.borderRadius.bottomRight,
      );
    }
    return null;
  }
}
