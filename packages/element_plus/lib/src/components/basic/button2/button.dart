import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import '../../feedback/loading/loading.dart';

typedef ElButtonStyleBuilder = ({Color textColor, BoxDecoration decoration});
typedef ElButtonColorStyle = ({Color bgColor, Color textColor});

class ElButton2 extends StatefulWidget {
  const ElButton2({
    super.key,
    required this.child,
    this.duration,
    this.curve,
    this.type,
    this.bgColor,
    this.width,
    this.height,
    this.leftIcon,
    this.rightIcon,
    this.round = false,
    this.padding,
    this.iconSize,
    this.block = false,
    this.autofocus = false,
    this.disabled = false,
    this.loading = false,
    this.loadingWidget,
    this.loadingBuilder,
    this.onPressed,
  });

  /// 子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 按钮动画过渡时间
  final Duration? duration;

  /// 按钮动画曲线
  final Curve? curve;

  /// 主题类型，默认 primary
  final String? type;

  /// 自定义颜色按钮，它会覆盖 [type] 属性
  final Color? bgColor;

  /// 按钮最小宽度，按钮的宽度受多种因素影响，具体表现有以下几种情况（按优先级排序）：
  /// * [block]，它会解除按钮约束，通常情况下按钮将充满整个空间，这取决于父级约束条件
  /// * [circle]，按钮宽度强制等于高度，因为此时按钮是圆形
  /// * [width]，用户自定义宽度
  /// * 最后：如果 [child] 是 [ElIcon] 或 [Icon]，那么默认宽度等于 height * 1.25
  final double? width;

  /// 按钮高度
  final double? height;

  /// 自定义图标尺寸
  final double? iconSize;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件
  final bool block;

  /// 按钮是否自动聚焦
  final bool autofocus;

  /// 是否禁用按钮，当 [loading] 为 true 时，按钮也将被禁用
  final bool disabled;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆角按钮
  final bool round;

  /// 自定义按钮内边距
  final EdgeInsets? padding;

  /// 开启 loading
  final bool loading;

  /// loading 图标小部件
  final Widget? loadingWidget;

  /// loading 构建器，它会隐藏按钮所有内容，如果不为 null，则会替换 [loadingWidget]
  final Widget Function(BuildContext context)? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  State<ElButton2> createState() => ElButton2State();
}

class ElButton2State<T extends ElButton2> extends State<T> {
  late ElButtonSizePreset sizePreset;
  late ElButtonStyleBuilder style;
  late MouseCursor cursor;

  Duration get duration =>
      context.elDuration(widget.duration ?? const Duration(milliseconds: 80));

  Curve get curve => widget.curve ?? Curves.linear;

  double get iconSize => widget.iconSize ?? sizePreset.iconSize!;

  bool get isIconChild => widget.child is ElIcon || widget.child is Icon;

  bool get isDefaultButton => widget.type == null && widget.bgColor == null;

  /// 按钮最小高度
  double get minHeight => widget.height ?? sizePreset.height!;

  /// 按钮最小宽度
  double get minWidth =>
      widget.width ??
      (isIconChild ? sizePreset.height! * 1.25 : sizePreset.width!);

  /// 按钮内边距
  EdgeInsets get padding =>
      widget.padding ??
      EdgeInsets.symmetric(horizontal: sizePreset.height! / 2);

  Widget get loadingWidget =>
      widget.loadingWidget ?? const ElLoading(ElIcons.loading);

  /// 获取按钮主题背景颜色，如果 bgColor 不为 null，则返回 bgColor，否则根据 type 返回预设主题色
  Color get themeBgColor {
    if (widget.bgColor != null) return widget.bgColor!;
    return context.elThemeColors[widget.type ?? El.primary]!;
  }

  ElButtonColorStyle buildLoadingBuilderStyle(BuildContext context) {
    final bgColor = context.isDark
        ? const Color.fromRGBO(57, 57, 57, 1.0)
        : const Color.fromRGBO(224, 224, 224, 1.0);
    final textColor = context.isDark
        ? const Color.fromRGBO(118, 118, 118, 1.0)
        : const Color.fromRGBO(166, 166, 166, 1.0);

    return (bgColor: bgColor, textColor: textColor);
  }

  /// 构建按钮样式
  ElButtonStyleBuilder buildButtonStyle(BuildContext context) {
    if (widget.loadingBuilder != null && widget.loading) {
      final loadingStyle = buildLoadingBuilderStyle(context);

      return (
        textColor: loadingStyle.textColor,
        decoration: BoxDecoration(
          color: loadingStyle.bgColor,
          borderRadius: BorderRadius.circular(sizePreset.radius!),
        ),
      );
    }

    late Color bgColor;
    late Color textColor;
    if (isDefaultButton) {
      bgColor = context.isDark ? Colors.grey.shade800 : Colors.grey.shade200;
      textColor = context.elTheme.textTheme.regularStyle.color!;

      if (context.hasTap) {
        bgColor = bgColor.elLight2(context, reverse: true);
      } else if (context.hasHover) {
        bgColor = bgColor.elLight1(context, reverse: true);
      }
    } else {
      bgColor = themeBgColor;
      textColor = bgColor.elTextColor(context);

      if (context.hasTap) {
        bgColor = bgColor.elLight3(context, reverse: true);
      } else if (context.hasHover) {
        bgColor = bgColor.elLight3(context);
      }
    }

    if (widget.disabled || widget.loading) {
      bgColor = bgColor.elLight5(context);
      textColor = isDefaultButton
          ? textColor.elLight6(context)
          : textColor.elLight5(context);
    }

    return (
      textColor: textColor,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(sizePreset.radius!),
      ),
    );
  }

  /// 构建按钮外观
  Widget buildButtonWrapper(BuildContext context, Widget child) {
    Widget result = ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: minHeight,
        minWidth: minWidth,
      ),
      child: AnimatedDecoratedBox(
        duration: duration,
        curve: curve,
        decoration: style.decoration,
        child: Padding(
          padding: padding,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
    if (widget.loadingBuilder != null && widget.loading) {
      result = Stack(
        children: [
          result,
          Positioned.fill(
            child: Center(
              child: widget.loadingBuilder!(context),
            ),
          ),
        ],
      );
    }

    return result;
  }

  /// 构建按钮内容
  Widget buildButtonContent(BuildContext context) {
    Widget result =
        widget.child is Widget ? widget.child : ElText('${widget.child}');

    Widget? $leftIcon = widget.leftIcon;
    Widget? $rightIcon = widget.rightIcon;
    if (widget.loadingBuilder == null && widget.loading) {
      if ($leftIcon != null) {
        $leftIcon = loadingWidget;
      } else if ($rightIcon != null) {
        $rightIcon = loadingWidget;
      } else {
        if (!isIconChild) {
          $leftIcon = loadingWidget;
        }
      }
    }

    result = Padding(
      padding: EdgeInsets.only(
        left: $leftIcon != null ? 6.0 : 0.0,
        right: $rightIcon != null ? 6.0 : 0.0,
      ),
      child: widget.loadingBuilder == null &&
              widget.leftIcon == null &&
              widget.loading &&
              isIconChild
          ? loadingWidget
          : result,
    );

    result = DefaultSelectionStyle(
      mouseCursor: cursor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if ($leftIcon != null) $leftIcon,
          result,
          if ($rightIcon != null) $rightIcon,
        ],
      ),
    );

    if (widget.loadingBuilder != null) {
      result = Opacity(
        opacity: widget.loading == true ? 0.0 : 1.0,
        child: result,
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    sizePreset = ElApp.of(context).sizePreset.button.apply(context);

    cursor = widget.loading
        ? MouseCursor.defer
        : widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click;

    Widget result = ElEvent(
        disabled: widget.disabled || widget.loading,
        autofocus: widget.autofocus,
        cursor: cursor,
        canRequestFocus: !widget.disabled,
        tapUpDelay: duration.inMilliseconds,
        onTap: widget.onPressed,
        builder: (context) {
          style = buildButtonStyle(context);
          return _AnimatedWidget(
            duration: duration,
            curve: curve,
            textStyle: TextStyle(
              color: style.textColor,
              fontSize: sizePreset.fontSize,
              fontWeight: FontWeight.w500,
            ),
            iconThemeData: ElIconThemeData(
              size: iconSize,
              color: style.textColor,
            ),
            child: Builder(builder: (context) {
              return buildButtonWrapper(
                context,
                buildButtonContent(context),
              );
            }),
          );
        });
    if (!widget.block) {
      result = UnconstrainedBox(
        child: result,
      );
    }
    return result;
  }
}

class _AnimatedWidget extends ImplicitlyAnimatedWidget {
  const _AnimatedWidget({
    required super.duration,
    super.curve,
    required this.textStyle,
    required this.iconThemeData,
    required this.child,
  });

  final TextStyle textStyle;
  final ElIconThemeData iconThemeData;
  final Widget child;

  @override
  AnimatedWidgetBaseState<_AnimatedWidget> createState() =>
      _AnimatedWidgetState();
}

class _AnimatedWidgetState extends AnimatedWidgetBaseState<_AnimatedWidget> {
  TextStyleTween? _textStyle;
  ElIconThemeDataTween? _iconThemeData;

  @override
  Widget build(BuildContext context) {
    return ElDefaultTextStyle(
      style: _textStyle!.evaluate(animation),
      child: ElIconTheme(
        data: _iconThemeData!.evaluate(animation),
        child: widget.child,
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _textStyle = visitor(_textStyle, widget.textStyle,
            (dynamic value) => TextStyleTween(begin: value as TextStyle))
        as TextStyleTween;
    _iconThemeData = visitor(
            _iconThemeData,
            widget.iconThemeData,
            (dynamic value) =>
                ElIconThemeDataTween(begin: value as ElIconThemeData))
        as ElIconThemeDataTween;
  }
}
