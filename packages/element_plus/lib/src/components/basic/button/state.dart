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
const int _duration = 100;

/// 按钮默认文本样式
const _defaultTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

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
      builder: (context) => buildButtonWrapper(context),
    );

    return _prop.block && !_prop.circle
        ? result
        : UnconstrainedBox(child: result);
  }

  void _calcProp() {
    final $data = ElButtonTheme.of(context);
    final $height = widget.height ?? $data.height ?? context.elConfig.size;
    final $circle = widget.circle ?? $data.circle ?? false;
    final $link = widget.link ?? $data.link ?? false;
    final $round = widget.round ?? $data.round ?? false;
    final $loading = widget.loading ?? $data.loading ?? false;
    final $disabled = (widget.disabled ?? $data.disabled ?? false) || $loading;
    final $horizontalPadding = $height / 2;
    final $padding = $circle || $link
        ? null
        : (widget.padding ??
            $data.padding ??
            ($round
                ? EdgeInsets.symmetric(horizontal: $horizontalPadding * 1.25)
                : EdgeInsets.symmetric(horizontal: $horizontalPadding)));
    final $borderRadius = $round || $circle
        ? BorderRadius.circular($height / 2)
        : widget.borderRadius ?? $data.borderRadius ?? context.elConfig.radius;

    _prop = (
      child: widget.child ?? $data.child,
      width: widget.width ?? $data.width,
      height: $height,
      bgColor: widget.bgColor ?? $data.bgColor,
      color: widget.color ?? $data.color,
      type: widget.type ?? $data.type,
      text: widget.text ?? $data.text ?? false,
      bg: widget.bg ?? $data.bg ?? false,
      link: $link,
      plain: widget.plain ?? $data.plain ?? false,
      round: $round,
      block: widget.block ?? $data.block ?? false,
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
    PointerHoverEventListener? hoverEvent;
    if (_groupData != null || widget.onHover != null) {
      hoverEvent = (e) {
        if (_groupData != null) {
          _groupData!.hoverIndex.value = _indexData!.index;
        }
        if (widget.onHover != null) {
          widget.onHover!(e);
        }
      };
    }
    return TapBuilder(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
      },
      onTapDown: (e) {
        if (_groupData != null) {
          _groupData!.isActive.value = true;
        }
        if (widget.onTapDown != null) {
          widget.onTapDown!(e);
        }
      },
      onTapUp: (e) {
        if (_groupData != null) {
          _groupData!.isActive.value = false;
        }
        if (widget.onTapUp != null) {
          widget.onTapUp!(e);
        }
      },
      onTapCancel: () {
        if (_groupData != null) {
          _groupData!.isActive.value = false;
        }
        if (widget.onTapCancel != null) {
          widget.onTapCancel!();
        }
      },
      disabled: _prop.disabled,
      delay: _duration,
      builder: (context) {
        return HoverBuilder(
          disabled: _prop.disabled,
          cursor: _prop.loading
              ? MouseCursor.defer
              : _prop.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          hitTestBehavior: HitTestBehavior.deferToChild,
          onHover: hoverEvent,
          onEnter: _groupData == null
              ? null
              : (e) {
                  _groupData!.hoverIndex.value = _indexData!.index;
                },
          onExit: _groupData == null
              ? null
              : (e) {
                  _groupData!.hoverIndex.value = -1;
                },
          builder: (context) => builder(context),
        );
      },
    );
  }

  /// 构建按钮外观
  Widget buildButtonWrapper(BuildContext context) {
    final $colorStyle = calcColorStyle(context);

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
        return buildButtonContent(context);
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
        color: $colorStyle.textColor,
      ),
      child: AnimatedDecoratedBox(
        duration: context.elDuration(const Duration(milliseconds: _duration)),
        decoration: BoxDecoration(
          color: $colorStyle.bgColor,
          border: calcBorder(context, $colorStyle.borderColor),
          borderRadius: calcBorderRadius(context),
        ),
        child: result,
      ),
    );

    if (_prop.loadingBuilder != null && _prop.loading) {
      assert($colorStyle.loadingTextColor != null,
          ElAssert.elementError('ElButton loadingBuilder color 参数不能为空'));
      result = Stack(
        children: [
          result,
          Positioned.fill(
            child: ElDefaultTextStyle.merge(
              style: _defaultTextStyle.copyWith(
                color: $colorStyle.loadingTextColor,
              ),
              child: Center(
                child: buildIconTheme(
                  color: $colorStyle.loadingTextColor,
                  child: _prop.loadingBuilder!(
                    ElButtonLoadingState(
                      color: $colorStyle.loadingTextColor!,
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
  Widget buildIconTheme({required Widget child, Color? color}) {
    return ElIconTheme(
      data: ElIconThemeData(
        size: _prop.iconSize,
        color: color,
      ),
      child: child,
    );
  }

  /// 构建按钮内容
  Widget buildButtonContent(BuildContext context) {
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

    $child = buildIconTheme(
      color: ElDefaultTextStyle.of(context).style.color,
      child: childContent,
    );

    return $child;
  }

  /// 计算按钮颜色样式
  _ColorStyle calcColorStyle(BuildContext context) {
    final $elTheme = context.elTheme;
    final $defaultBorderColor = $elTheme.borderColor;
    final $isDark = context.isDark;
    final $isHover = context.isHover;
    final $isTap = context.isTap;

    Color? $bgColor;
    Color? $textColor;
    Color? $borderColor;
    Color? $loadingTextColor;

    // 处理自定义加载器按钮外观，如果传递了 loadingBuilder，那么按钮原本内容将被隐藏
    if (_prop.loadingBuilder != null && _prop.loading) {
      if (_prop.link || _prop.text) {
        $loadingTextColor = _prop.type == null && _prop.bgColor == null
            ? $elTheme.regularTextColor
            : context.elThemeColors[_prop.type]!;
      } else {
        $bgColor = $isDark
            ? const Color.fromRGBO(57, 57, 57, 1.0)
            : const Color.fromRGBO(224, 224, 224, 1.0);
        $loadingTextColor = $isDark
            ? const Color.fromRGBO(118, 118, 118, 1.0)
            : const Color.fromRGBO(166, 166, 166, 1.0);
        if ((_prop.type == null && _prop.bgColor == null) || _prop.plain) {
          $borderColor = $isDark
              ? const Color.fromRGBO(57, 57, 57, 1.0)
              : const Color.fromRGBO(224, 224, 224, 1.0);
        }
      }
    } else {
      // 链接按钮
      if (_prop.link) {
        $textColor = (_prop.type == null
                ? $elTheme.regularTextColor
                : context.elThemeColors[_prop.type]!)
            .buildEventColor(
          context,
          tapBuilder: (color) => color.tap(context),
          hoverBuilder: (color) => color.withOpacity(_disabledOpacity),
        );
        if (_prop.disabled) {
          $textColor = $textColor.withOpacity(_textDisabledOpacity);
        }
      }
      // 文字按钮
      else if (_prop.text) {
        final pageBgColor = $elTheme.bgColor;
        if (_prop.bg) {
          $bgColor = pageBgColor
              .deepen(4)
              .on($isHover, color: pageBgColor.deepen(2))
              .on($isTap, color: pageBgColor.deepen(8));
        } else {
          if ($isTap) {
            $bgColor = pageBgColor.deepen(8);
          } else if ($isHover) {
            $bgColor = pageBgColor.deepen(4);
          }
        }
        $textColor = _prop.type == null && _prop.bgColor == null
            ? $elTheme.regularTextColor
            : context.elThemeColors[_prop.type]!;
        if (_prop.disabled) {
          $textColor = $textColor.withOpacity(_textDisabledOpacity);
        }
      } else {
        // 默认按钮
        if (_prop.type == null && _prop.bgColor == null) {
          $bgColor = $isTap || $isHover
              ? $elTheme.primary.themeLightBg(context)
              : $elTheme.bgColor;

          $textColor =
              $isTap || $isHover ? $elTheme.primary : $elTheme.regularTextColor;
          if (_prop.disabled) {
            $textColor = $textColor.withOpacity(_textDisabledOpacity);
          }

          $borderColor = $isTap
              ? $elTheme.primary
              : $isHover
                  ? $elTheme.primary.themeLightBorder(context)
                  : $defaultBorderColor;

          if (_prop.disabled) {
            $borderColor = $borderColor.withOpacity(_disabledOpacity);
          }
        } else {
          final $themeColor =
              _prop.bgColor ?? context.elThemeColors[_prop.type]!;

          // 镂空按钮
          if (_prop.plain) {
            $bgColor = PlatformUtil.isDesktop
                ? ($isTap
                    ? $themeColor.tap(context)
                    : $isHover
                        ? $themeColor
                        : $themeColor.themeLightBg(context))
                : ($isTap ? $themeColor : $themeColor.themeLightBg(context));

            $textColor = $isTap || $isHover
                ? $themeColor.elTextColor(context)
                : $themeColor;

            $borderColor = PlatformUtil.isDesktop
                ? ($isTap
                    ? $themeColor.tap(context)
                    : $isHover
                        ? $themeColor
                        : $themeColor.themeLightBorder(context))
                : ($isTap
                    ? $themeColor
                    : $themeColor.themeLightBorder(context));

            if (_prop.disabled) {
              $bgColor = $bgColor.withOpacity(_disabledOpacity);
              $textColor = $textColor.withOpacity(_textDisabledOpacity);
              $borderColor = $borderColor.withOpacity(_disabledOpacity);
            }
          }
          // 主题按钮
          else {
            $bgColor = $isTap
                ? $themeColor.tap(context)
                : $isHover
                    ? $themeColor.hover(context)
                    : $themeColor;

            $textColor = $themeColor.elTextColor(context);
            if (_prop.disabled) {
              $bgColor = $bgColor.withOpacity(_disabledOpacity);
              $textColor =
                  $textColor.withOpacity(_themeButtonTextDisabledOpacity);
            }
          }
        }
      }
    }

    return (
      bgColor: $bgColor,
      textColor: $textColor,
      borderColor: $borderColor,
      loadingTextColor: $loadingTextColor,
    );
  }

  Border calcBorder(BuildContext context, Color? borderColor) {
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

  BorderRadiusGeometry? calcBorderRadius(BuildContext context) {
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
