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

class _ElButtonState extends State<ElButton> {
  /// 如果是按钮组，则会初始化此变量
  _ElButtonGroupInheritedWidget? _groupData;

  /// 如果是按钮组，此变量将保存当前按钮所在的位置
  ElChildIndex? _indexData;

  late _ButtonProp _prop;
  late _ColorStyle _colorStyle;
  bool _isTap = false;
  bool _isHover = false;

  bool get _isIconChild => _prop.child is ElIcon || _prop.child is Icon;

  bool get _hasGroup => _groupData != null;

  @override
  Widget build(BuildContext context) {
    _groupData = _ElButtonGroupInheritedWidget.maybeOf(context);
    if (_hasGroup) {
      _indexData = ElChildIndex.of(context);
    } else {
      ElAssert.themeType(widget.type, 'ElButton');
    }

    _prop = _ButtonProp.create(context, widget, _hasGroup);

    Widget result = _buildButtonEvent();

    return _prop.block && !_prop.circle
        ? result
        : UnconstrainedBox(child: result);
  }

  /// 构建按钮事件
  Widget _buildButtonEvent() {
    return ElTapBuilder(
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
        if (widget.onTapDown != null) widget.onTapDown!(e);
        if (_hasGroup) {
          _groupData!.activeIndex.value = _indexData!.index;
        }
      },
      onTapUp: (e) {
        setState(() {
          _isTap = false;
        });
        if (widget.onTapUp != null) widget.onTapUp!(e);
        if (_hasGroup) {
          _groupData!.activeIndex.value = -1;
        }
      },
      onTapCancel: () {
        setState(() {
          _isTap = false;
        });
        if (widget.onTapCancel != null) widget.onTapCancel!();
        if (_hasGroup) {
          _groupData!.activeIndex.value = -1;
        }
      },
      disabled: _prop.disabled,
      triggerBuild: false,
      delay: _duration.inMilliseconds,
      builder: (context) {
        if (_prop.disabled) _isHover = false;
        return MouseRegion(
          cursor: _prop.loading
              ? MouseCursor.defer
              : _prop.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          hitTestBehavior: HitTestBehavior.deferToChild,
          onHover: widget.onHover,
          onEnter: _prop.disabled
              ? null
              : (e) {
                  setState(() {
                    _isHover = true;
                  });
                  if (_hasGroup) {
                    _groupData!.hoverIndex.value = _indexData!.index;
                  }
                },
          onExit: _prop.disabled
              ? null
              : (e) {
                  setState(() {
                    _isHover = false;
                  });
                  if (_hasGroup) {
                    _groupData!.hoverIndex.value = -1;
                  }
                },
          child: Builder(builder: (context) {
            // if (_hasGroup) {
            //   final $isSelected = _ButtonGroupUtil.isSelected(
            //     _groupData!.modelValue,
            //     _indexData!.index,
            //   );
            //   if ($isSelected) {
            //     $isHover = true;
            //   }
            // }

            _colorStyle = _calcColorStyle();
            return _buildButtonWrapper(context);
          }),
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

  /// 计算按钮颜色样式
  _ColorStyle _calcColorStyle() {
    late _ColorStyle colors;
    if (_prop.loadingBuilder != null && _prop.loading) {
      return _Preset.loadingButton(
        context,
        type: _prop.type,
        bgColor: _prop.bgColor,
        link: _prop.link,
        text: _prop.text,
        plain: _prop.plain,
      );
    } else {
      if (_prop.link) {
        if (_isTap) {
          colors = _Preset.linkButtonActive(
            context,
            type: _prop.type,
          );
        } else if (_isHover) {
          colors = _Preset.linkButtonHover(
            context,
            type: _prop.type,
          );
        } else {
          colors = _Preset.linkButton(
            context,
            type: _prop.type,
          );
        }
        return colors.linkButtonDisabled(_prop.disabled);
      } else if (_prop.text) {
        if (_isTap) {
          colors = _Preset.textButtonActive(
            context,
            type: _prop.type,
            bgColor: _prop.bgColor,
            bg: _prop.bg,
          );
        } else if (_isHover) {
          colors = _Preset.textButtonHover(
            context,
            type: _prop.type,
            bgColor: _prop.bgColor,
            bg: _prop.bg,
          );
        } else {
          colors = _Preset.textButton(
            context,
            type: _prop.type,
            bgColor: _prop.bgColor,
            bg: _prop.bg,
          );
        }
        return colors.textButtonDisabled(_prop.disabled);
      } else {
        if (_prop.type == null && _prop.bgColor == null) {
          if (_isTap) {
            colors = _Preset.defaultButtonActive(context);
          } else if (_isHover) {
            colors = _Preset.defaultButtonHover(context);
          } else {
            colors = _Preset.defaultButton(context);
          }
          return colors.defaultButtonDisabled(_prop.disabled);
        } else {
          if (_prop.plain) {
            if (_isTap) {
              colors = _Preset.plainButtonActive(
                context,
                type: _prop.type,
                bgColor: _prop.bgColor,
              );
            } else if (_isHover) {
              colors = _Preset.plainButtonHover(
                context,
                type: _prop.type,
                bgColor: _prop.bgColor,
              );
            } else {
              colors = _Preset.plainButton(
                context,
                type: _prop.type,
                bgColor: _prop.bgColor,
              );
            }
            return colors.plainButtonDisabled(_prop.disabled);
          } else {
            if (_isTap) {
              colors = _Preset.themeButtonActive(
                context,
                type: _prop.type,
                bgColor: _prop.bgColor,
              );
            } else if (_isHover) {
              colors = _Preset.themeButtonHover(
                context,
                type: _prop.type,
                bgColor: _prop.bgColor,
              );
            } else {
              colors = _Preset.themeButton(
                context,
                type: _prop.type,
                bgColor: _prop.bgColor,
              );
            }
            return colors.themeButtonDisabled(_prop.disabled);
          }
        }
      }
    }
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

/// 按钮颜色样式
class _ColorStyle {
  Color? bgColor;
  Color? textColor;
  Color? borderColor;
  Color? loadingTextColor;

  _ColorStyle({
    this.bgColor,
    this.textColor,
    this.borderColor,
    this.loadingTextColor,
  });
}

/// 按钮最终 prop 配置
class _ButtonProp {
  final dynamic child;
  final double? width;
  final double height;
  final Color? bgColor;
  final Color? color;
  final String? type;
  final bool text;
  final bool bg;
  final bool link;
  final bool plain;
  final bool round;
  final bool block;
  final ElBorderBuilder borderBuilder;
  final BorderRadius borderRadius;
  final EdgeInsetsGeometry? padding;
  final double iconSize;
  final Widget? leftIcon;
  final Widget? rightIcon;
  final bool circle;
  final bool disabled;
  final bool loading;
  final Widget loadingWidget;
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;

  _ButtonProp({
    required this.child,
    required this.width,
    required this.height,
    required this.bgColor,
    required this.color,
    required this.type,
    required this.text,
    required this.bg,
    required this.link,
    required this.plain,
    required this.round,
    required this.block,
    required this.borderBuilder,
    required this.borderRadius,
    required this.padding,
    required this.iconSize,
    required this.leftIcon,
    required this.rightIcon,
    required this.circle,
    required this.disabled,
    required this.loading,
    required this.loadingWidget,
    required this.loadingBuilder,
  });

  /// 通过工厂函数创建按钮最终 prop 配置
  factory _ButtonProp.create(
    BuildContext context,
    ElButton widget,
    bool hasGroup,
  ) {
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

    if (hasGroup) {
      $height = $data.height ?? context.elConfig.size;
      $bgColor = $data.bgColor;
      $type = $data.type;
      $text = $data.text ?? false;
      $bg = $data.bg ?? false;
      $circle = false;
      $link = false;
      $plain = $data.plain ?? false;
      $round = $data.round ?? false;
    } else {
      $height = widget.height ?? $data.height ?? context.elConfig.size;
      $bgColor = widget.bgColor ?? $data.bgColor;
      $type = widget.type ?? $data.type;
      $circle = widget.circle ?? $data.circle ?? false;
      $text = widget.text ?? $data.text ?? false;
      $bg = widget.bg ?? $data.bg ?? false;
      $link = widget.link ?? $data.link ?? false;
      $plain = widget.plain ?? $data.plain ?? false;
      $round = widget.round ?? $data.round ?? false;
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

    double? $iconSize = widget.iconSize ?? $data.iconSize;
    if ($iconSize == null) {
      if ($height >= 36) {
        $iconSize = $height / 2 - 2;
      } else {
        $iconSize = $height / 2;
      }
    }

    return _ButtonProp(
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
      borderBuilder:
          widget.borderBuilder ?? $data.borderBuilder ?? _borderBuilder,
      borderRadius: $borderRadius,
      padding: $padding,
      iconSize: $iconSize,
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
  }

  static Border _borderBuilder(Color color) =>
      Border.all(width: 1.0, color: color);
}

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

extension _ColorStyleExtension on _ColorStyle {
  _ColorStyle defaultButtonDisabled(bool disabled) {
    if (disabled) {
      textColor = textColor!.withOpacity(_textDisabledOpacity);
      borderColor = borderColor!.withOpacity(_disabledOpacity);
    }
    return this;
  }

  _ColorStyle themeButtonDisabled(bool disabled) {
    if (disabled) {
      bgColor = bgColor!.withOpacity(_disabledOpacity);
      textColor = textColor!.withOpacity(_themeButtonTextDisabledOpacity);
    }
    return this;
  }

  _ColorStyle plainButtonDisabled(bool disabled) {
    if (disabled) {
      bgColor = bgColor!.withOpacity(_disabledOpacity);
      textColor = textColor!.withOpacity(_textDisabledOpacity);
      borderColor = borderColor!.withOpacity(_disabledOpacity);
    }
    return this;
  }

  _ColorStyle textButtonDisabled(bool disabled) {
    if (disabled) {
      textColor = textColor!.withOpacity(_textDisabledOpacity);
    }
    return this;
  }

  _ColorStyle linkButtonDisabled(bool disabled) {
    if (disabled) {
      textColor = textColor!.withOpacity(_textDisabledOpacity);
    }
    return this;
  }
}
