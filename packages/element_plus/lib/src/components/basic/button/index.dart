import 'dart:math';

import 'package:collection/collection.dart';
import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../themes/components/basic/button.dart';
import '../../../themes/components/basic/icon.dart';
import '../../feedback/loading/loading.dart';

part 'button_group.dart';

part 'button_colors.dart';

/// 按钮最小宽度
const double _minWidth = 64;

/// 按钮动画持续时间，默认 100 毫秒
const _duration = Duration(milliseconds: 100);

/// 按钮默认文本样式
const _defaultTextStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w500);

class ElButton extends StatefulWidget {
  /// Element UI 按钮小部件
  const ElButton({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text,
    this.bg,
    this.link,
    this.plain,
    this.round,
    this.block,
    this.flex,
    this.borderBuilder,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.circle,
    this.disabled,
    this.loading,
    this.loadingWidget,
    this.loadingBuilder,
    this.onPressed,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onHover,
  });

  /// 子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 按钮宽度，按钮的宽度受多种因素影响，具体表现有以下几种情况（按优先级排序）：
  /// * [block]，它会解除按钮约束，通常情况下按钮将充满整个空间，这取决于父级约束条件
  /// * [link]，按钮宽度、高度、内边距全部清空，和普通文字无异
  /// * [circle]，按钮宽度强制等于高度，因为此时按钮是圆形
  /// * [width]，这一步用户指定的宽度才会生效，注意：宽度约束为 minWidth
  /// * 最后：如果 [child] 是 [ElIcon] 或 [Icon]，那么 width = height * 1.25，否则最小宽度为 64 像素
  final double? width;

  /// 按钮高度
  final double? height;

  /// 自定义按钮背景颜色，此属性会替代 [type]
  final Color? bgColor;

  /// 按钮文字、图标颜色，如果为空，则根据 [bgColor] 自动计算为全局默认的文字颜色
  final Color? color;

  /// 主题类型
  final String? type;

  /// 文字按钮
  final bool? text;

  /// 文字按钮是否添加默认背景
  final bool? bg;

  /// 链接按钮，相比文字按钮，它没有任何边距、以及宽高
  final bool? link;

  /// 镂空按钮
  final bool? plain;

  /// 圆角按钮
  final bool? round;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件，
  /// 所以，块级按钮的宽度将由父级约束决定
  final bool? block;

  /// 如果处于按钮组中，同时按钮设置了 [block] 属性，你可以设置当前按钮所占用的空间比例
  final int? flex;

  /// 构建自定义边框
  final ElBorderBuilder? borderBuilder;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 自定义图标尺寸
  final double? iconSize;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆形按钮，按钮宽度强制和高度保持一致
  final bool? circle;

  /// 是否禁用按钮
  final bool? disabled;

  /// 开启 loading
  final bool? loading;

  /// loading 图标小部件
  final Widget? loadingWidget;

  /// loading 构建器，它会隐藏按钮所有内容，如果不为 null，则会替换 [loadingWidget]
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;

  /// 按下事件
  final GestureTapDownCallback? onTapDown;

  /// 松开按下事件
  final GestureTapUpCallback? onTapUp;

  /// 取消点击事件
  final GestureTapCancelCallback? onTapCancel;

  /// 悬停事件
  final PointerHoverEventListener? onHover;

  @override
  State<ElButton> createState() => _ElButtonState();
}

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

  bool _isTap = false;
  bool _isHover = false;

  bool get _isIconChild => _prop.child is ElIcon || _prop.child is Icon;

  bool get _hasGroup => _groupData != null;

  @override
  Widget build(BuildContext context) {
    _groupData = _ElButtonGroupInheritedWidget.maybeOf(context);
    if (_hasGroup) {
      _indexData = ElChildIndex.of(context);
      _isSelected = _ButtonGroupUtil.isSelected(
        _groupData!.modelValue,
        _indexData!.index,
      );
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
        if (_prop.disabled) {
          _isHover = false;
          if (_hasGroup) {
            nextTick(() {
              _groupData!.hoverIndex.value = -1;
            });
          }
        }
        return ElHoverBuilder(
          cursor: _prop.loading
              ? MouseCursor.defer
              : _prop.disabled
                  ? SystemMouseCursors.forbidden
                  : SystemMouseCursors.click,
          hitTestBehavior: HitTestBehavior.deferToChild,
          onHover: _prop.disabled
              ? null
              : (e) {
                  if (widget.onHover != null) widget.onHover!(e);
                  if (_isHover == false) {
                    setState(() {
                      _isHover = true;
                    });
                  }
                  if (_hasGroup) {
                    _groupData!.hoverIndex.value = _indexData!.index;
                  }
                },
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
          builder: (context) {
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
    final defaultBorder = _prop.borderBuilder(ElButtonBorderState(
      color: borderColor,
      isHover: _isHover,
      isTap: _isTap,
      isSelected: _isSelected,
    ));
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

/// 按钮最终 prop 配置
class _ButtonProp {
  final dynamic child;
  final double? width;
  final double height;
  final Color? bgColor;
  final Color? color;
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
    late final bool $text;
    late final bool $bg;
    late final bool $circle;
    late final bool $link;
    late final bool $plain;
    late final bool $round;
    late final ElBorderBuilder $borderBuilder;
    final bool $block = widget.block ?? $data.block ?? false;
    final $loading = widget.loading ?? $data.loading ?? false;
    final $disabled = (widget.disabled ?? $data.disabled ?? false) || $loading;

    if (hasGroup) {
      $height = $data.height ?? context.elConfig.size;
      $bgColor = $data.bgColor ?? context.elThemeColors[$data.type];
      $text = $data.text ?? false;
      $bg = $data.bg ?? false;
      $circle = false;
      $link = false;
      $plain = $data.plain ?? false;
      $round = $data.round ?? false;
      $borderBuilder = $data.borderBuilder ?? defaultBorderBuilder;
    } else {
      $height = widget.height ?? $data.height ?? context.elConfig.size;
      $bgColor = widget.bgColor ??
          $data.bgColor ??
          context.elThemeColors[widget.type ?? $data.type];
      $circle = widget.circle ?? $data.circle ?? false;
      $text = widget.text ?? $data.text ?? false;
      $bg = widget.bg ?? $data.bg ?? false;
      $link = widget.link ?? $data.link ?? false;
      $plain = widget.plain ?? $data.plain ?? false;
      $round = widget.round ?? $data.round ?? false;
      $borderBuilder =
          widget.borderBuilder ?? $data.borderBuilder ?? defaultBorderBuilder;
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
      text: $text,
      bg: $bg,
      link: $link,
      plain: $plain,
      round: $round,
      block: $block,
      borderBuilder: $borderBuilder,
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

  static Border defaultBorderBuilder(ElButtonBorderState state) =>
      Border.all(width: 1.0, color: state.color);
}
