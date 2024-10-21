part of 'index.dart';

/// 按钮最小宽度
const double _minWidth = 64;

/// 按钮 background、border 禁用透明度
const double _disabledOpacity = 0.6;

/// 按钮 text 禁用透明度
const double _textDisabledOpacity = 0.36;

/// 主题按钮 text 禁用透明度
const double _themeButtonTextDisabledOpacity = 0.85;

/// 按钮动画持续时间，默认 100 毫秒
const _duration = Duration(milliseconds: 100);

/// 按钮默认文本样式
const _defaultTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

/// 按钮组悬停退出延迟器
Timer? _buttonGroupHoverExitTimer;

extension _ButtonColorExtension on Color {
  /// hover 悬停颜色，颜色会变得更浅
  Color hover(BuildContext context) => elLight3(context);

  /// tap 按下颜色，颜色会变得更深
  Color tap(BuildContext context) => elLight3(context, reverse: true);

  /// 应用主题透明背景颜色
  Color themeLightBg(BuildContext context) => elLight9(context);

  /// 应用主题透明边框颜色
  Color themeLightBorder(BuildContext context) => elLight6(context);
}

/// 计算按钮颜色样式
typedef _Prop = ({
  dynamic child,
  double? width,
  double height,
  Color? bgColor,
  Color? color,
  String? type,
  bool text,
  bool bg,
  bool link,
  bool plain,
  bool round,
  bool block,
  BorderRadius borderRadius,
  EdgeInsetsGeometry? padding,
  double iconSize,
  Widget? leftIcon,
  Widget? rightIcon,
  bool circle,
  bool disabled,
  bool loading,
  Widget loadingWidget,
  Widget Function(ElButtonLoadingState state)? loadingBuilder,
});

/// 计算按钮颜色样式
typedef _ColorStyle = ({
  Color? bgColor,
  Color? textColor,
  Color? borderColor,
  Color? loadingTextColor
});

class _ElButtonState extends State<ElButton> {
  /// 如果是按钮组，则会初始化此变量
  _ElButtonGroupInheritedWidget? _groupData;

  /// 如果是按钮组，此变量将保存当前按钮所在的位置
  ChildIndexData? _indexData;

  /// 计算按钮最终的 prop 属性
  late _Prop _prop;

  /// 颜色样式
  late _ColorStyle _colorStyle;

  /// 按钮 child 是否是图标
  late bool _isIconChild;

  @override
  Widget build(BuildContext context) {
    _groupData = _ElButtonGroupInheritedWidget.maybeOf(context);
    if (_groupData == null) {
      ElAssert.themeType(widget.type, 'ElButton');
    } else {
      _indexData = ChildIndexData.of(context);
    }

    _calcProp();

    Widget result = _buildEvent(
      builder: (context) => _buildButtonWrapper(context),
    );

    return _prop.block && !_prop.circle
        ? result
        : UnconstrainedBox(child: result);
  }

  /// 计算 prop 配置
  void _calcProp() {
    final $data = ElButtonTheme.of(context);
    late final double $height;
    late final Color? $bgColor;
    late final String? $type;
    late final bool $text;
    late final bool $bg;
    late final bool $circle;
    late final bool $link;
    late final bool $plain;
    late final bool $round;
    final bool $block = widget.block ?? $data.block ?? false;
    final $loading = widget.loading ?? $data.loading ?? false;
    final $disabled = (widget.disabled ?? $data.disabled ?? false) || $loading;

    if (_groupData == null) {
      $height = widget.height ?? $data.height ?? context.elConfig.size;
      $bgColor = widget.bgColor ?? $data.bgColor;
      $type = widget.type ?? $data.type;
      $circle = widget.circle ?? $data.circle ?? false;
      $text = widget.text ?? $data.text ?? false;
      $bg = widget.bg ?? $data.bg ?? false;
      $link = widget.link ?? $data.link ?? false;
      $plain = widget.plain ?? $data.plain ?? false;
      $round = widget.round ?? $data.round ?? false;
    } else {
      $height = $data.height ?? context.elConfig.size;
      $bgColor = $data.bgColor;
      $type = $data.type;
      $text = $data.text ?? false;
      $bg = $data.bg ?? false;
      $circle = false;
      $link = false;
      $plain = $data.plain ?? false;
      $round = $data.round ?? false;
    }

    final $horizontalPadding = $height / 2;
    final $padding = $circle || $link
        ? null
        : (widget.padding ??
            $data.padding ??
            EdgeInsets.symmetric(horizontal: $horizontalPadding));
    final $borderRadius = $round || $circle
        ? BorderRadius.circular($height / 2)
        : widget.borderRadius ?? $data.borderRadius ?? context.elConfig.radius;

    _prop = (
      child: widget.child ?? $data.child,
      width: widget.width ?? $data.width,
      height: $height,
      bgColor: $bgColor,
      color: widget.color ?? $data.color,
      type: $type,
      text: $text,
      bg: $bg,
      link: $link,
      plain: $plain,
      round: $round,
      block: $block,
      borderRadius: $borderRadius,
      padding: $padding,
      iconSize: widget.iconSize ?? $data.iconSize ?? $height / 2 - 2,
      leftIcon: widget.leftIcon ?? $data.leftIcon,
      rightIcon: widget.rightIcon ?? $data.rightIcon,
      circle: $circle,
      disabled: $disabled,
      loading: $loading,
      loadingWidget: widget.loadingWidget ??
          $data.loadingWidget ??
          const ElLoading(ElIcons.loading),
      loadingBuilder: widget.loadingBuilder ?? $data.loadingBuilder,
    );

    _isIconChild = _prop.child is ElIcon || _prop.child is Icon;
  }

  /// 构建按钮事件
  Widget _buildEvent({required WidgetBuilder builder}) {
    return TapBuilder(
      onTap: widget.onPressed,
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      disabled: _prop.disabled,
      delay: _duration.inMilliseconds,
      builder: (context) {
        return HoverBuilder(
          cursor: _prop.loading
              ? MouseCursor.defer
              : _prop.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          hitTestBehavior: HitTestBehavior.deferToChild,
          disabled: _prop.disabled,
          onHover: widget.onHover,
          onEnter: (e) {
            if (_groupData != null) {
              if (_buttonGroupHoverExitTimer != null) {
                _buttonGroupHoverExitTimer!.cancel();
                _buttonGroupHoverExitTimer = null;
              }
              _groupData!.hoverIndex.value = _indexData!.index;
            }
          },
          onExit: (e) {
            if (_groupData != null) {
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
    _colorStyle = _calcColorStyle(context);

    // 如果是按钮组，将计算后的边框颜色同步到按钮组分割线
    if (_groupData != null) {
      nextTick(() {
        _groupData!.borderColor.value = _colorStyle.borderColor;
      });
    }
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

  /// 计算按钮颜色样式
  _ColorStyle _calcColorStyle(BuildContext context) {
    // 处理自定义加载器按钮外观，如果传递了 loadingBuilder，那么按钮原本内容将被隐藏
    if (_prop.loadingBuilder != null && _prop.loading) {
      return _ButtonStyleUtil.loadingStyle(
        context,
        type: _prop.type,
        bgColor: _prop.bgColor,
        link: _prop.link,
        text: _prop.text,
        plain: _prop.plain,
      );
    } else {
      if (_prop.link) {
        return _ButtonStyleUtil.linkStyle(
          context,
          type: _prop.type,
          disabled: _prop.disabled,
        );
      } else if (_prop.text) {
        return _ButtonStyleUtil.textStyle(
          context,
          type: _prop.type,
          bgColor: _prop.bgColor,
          bg: _prop.bg,
          disabled: _prop.disabled,
        );
      } else {
        if (_prop.type == null && _prop.bgColor == null) {
          return _ButtonStyleUtil.defaultStyle(
            context,
            disabled: _prop.disabled,
          );
        } else {
          if (_prop.plain) {
            return _ButtonStyleUtil.plainStyle(
              context,
              type: _prop.type,
              bgColor: _prop.bgColor,
              disabled: _prop.disabled,
            );
          } else {
            return _ButtonStyleUtil.themeStyle(
              context,
              type: _prop.type,
              bgColor: _prop.bgColor,
              disabled: _prop.disabled,
            );
          }
        }
      }
    }
  }

  Border _calcBorder(BuildContext context, Color? borderColor) {
    if (borderColor == null) return const Border();
    final defaultBorder = Border.all(color: borderColor, width: 1);
    if (_groupData == null) return defaultBorder;
    if (_indexData!.length == 0) return const Border();
    if (_indexData!.length == 1) return defaultBorder;
    final borderSide = BorderSide(color: borderColor, width: 1);
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
