import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

import '../../feedback/loading/loading.dart';

/// 构建的按钮颜色记录
typedef ElButtonColorRecord = ({
  Color? bgColor,
  Color? textColor,
  Color? borderColor,
});

class ElButton2 extends StatefulWidget {
  const ElButton2({
    super.key,
    required this.child,
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

  /// 自定义 loading 构建器，有些按钮不适合 Element 默认 loading 风格，比如：[ElLinkButton]，
  /// [loadingBuilder] 的优先级高于 [loadingWidget]，它会隐藏按钮当前内容，然后绘制自定义小部件。
  final WidgetBuilder? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  State<ElButton2> createState() => ElButton2State();
}

class ElButton2State<T extends ElButton2> extends State<T> {
  late ElCommonSizePreset commonSizePreset;
  late ElButtonSizePreset buttonSizePreset;
  late ElButtonColorRecord colorRecord;
  late MouseCursor cursor;
  late bool _triggerLoadingBuilder;

  Widget get child =>
      widget.child is Widget ? widget.child : ElText('${widget.child}');

  /// 装饰器过渡动画持续时间
  Duration get decorationDuration =>
      context.elDuration(const Duration(milliseconds: 80));

  /// 按钮主题类型
  String? get type => widget.type;

  /// 按钮背景颜色
  Color? get bgColor => widget.bgColor;

  /// 如果 [type]、[bgColor] 均为 null，那么按钮为默认风格按钮
  bool get isDefaultButton => type == null && bgColor == null;

  /// 装饰器过渡动画曲线
  Curve get decorationCurve => Curves.linear;

  /// 文本动画过渡持续时间，默认跟随装饰器
  Duration get textDuration => decorationDuration;

  /// 文本动画曲线，默认跟随装饰器
  Curve get textCurve => decorationCurve;

  /// 自定义 loading 构造器
  WidgetBuilder? get loadingBuilder => widget.loadingBuilder;

  /// 图标尺寸
  double get iconSize => widget.iconSize ?? buttonSizePreset.iconSize!;

  /// 是否是单纯的图标按钮
  bool get isIconChild => widget.child is Icon;

  /// 按钮最小高度
  double get minHeight => widget.height ?? commonSizePreset.size!;

  /// 按钮最小宽度
  double get minWidth =>
      widget.width ??
      (isIconChild
          ? commonSizePreset.size! * 1.25
          : buttonSizePreset.minWidth!);

  /// 按钮内边距
  EdgeInsets get padding =>
      widget.padding ??
      EdgeInsets.symmetric(horizontal: commonSizePreset.size! / 2);

  /// 是否启用圆角按钮
  bool get round => widget.round;

  /// 按钮边框圆角
  BorderRadius? get borderRadius =>
      round ? BorderRadius.circular(minHeight / 2) : commonSizePreset.radius!;

  /// 按钮边框
  Border? get border => null;

  /// 默认的加载器小部件
  Widget get loadingWidget =>
      widget.loadingWidget ?? const ElLoading(ElIcons.loading);

  /// 获取按钮主题背景颜色，如果 bgColor 不为 null，则返回 bgColor，否则根据 type 返回预设主题色
  Color get themeBgColor {
    if (bgColor != null) return bgColor!;
    return context.elThemeColors[type ?? El.primary]!;
  }

  /// 构建可交互按钮颜色集合，目前主要包括 背景、文字、边框 三种颜色，
  /// 创建的对象会赋值给 [colorRecord] 变量
  ElButtonColorRecord buildColorRecord(BuildContext context) {
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
      bgColor: bgColor,
      textColor: textColor,
      borderColor: null,
    );
  }

  /// 当 [_triggerLoadingBuilder] 被激活时，则会调用此方法而不是 [buildColorRecord]，
  /// 此方法返回的是自定义 loadingBuilder 需要的背景、文字颜色
  ElButtonColorRecord buildLoadingColorRecord(BuildContext context) {
    final bgColor = context.isDark
        ? const Color.fromRGBO(57, 57, 57, 1.0)
        : const Color.fromRGBO(224, 224, 224, 1.0);
    final textColor = context.isDark
        ? const Color.fromRGBO(118, 118, 118, 1.0)
        : const Color.fromRGBO(166, 166, 166, 1.0);

    return (
      bgColor: bgColor,
      textColor: textColor,
      borderColor: null,
    );
  }

  /// 根据之前计算好的颜色开始构建按钮 [BoxDecoration] 装饰对象，它会在 [buildButtonWrapper] 构建按钮外观方法中执行，
  /// 如果你重写了 [buildButtonWrapper] 方法，那么此方法不会调用
  BoxDecoration buildDecoration(BuildContext context) {
    return BoxDecoration(
      color: colorRecord.bgColor,
      borderRadius: borderRadius,
      border: border,
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
        duration: decorationDuration,
        curve: decorationCurve,
        decoration: buildDecoration(context),
        child: Padding(
          padding: padding,
          child: Center(
            child: child,
          ),
        ),
      ),
    );
    return result;
  }

  /// 构建按钮内容
  Widget buildButtonContent(BuildContext context) {
    Widget result = child;

    Widget? $leftIcon = widget.leftIcon;
    Widget? $rightIcon = widget.rightIcon;
    if (loadingBuilder == null && widget.loading) {
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

    double paddingValue = ElSize.applyDouble(
      context,
      [4.0, 5.0, 6.0, 7.0, 8.0],
    );

    result = Padding(
      padding: EdgeInsets.only(
        left: $leftIcon != null ? paddingValue : 0.0,
        right: $rightIcon != null ? paddingValue : 0.0,
      ),
      child: loadingBuilder == null &&
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

    return result;
  }

  void onPressed() {
    widget.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    commonSizePreset = context.commonSizePreset;
    buttonSizePreset = el.sizePreset.button.apply(context);
    _triggerLoadingBuilder = loadingBuilder != null && widget.loading;
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
        tapUpDelay: decorationDuration.inMilliseconds,
        onTap: onPressed,
        builder: (context) {
          if (_triggerLoadingBuilder) {
            colorRecord = buildLoadingColorRecord(context);
          } else {
            colorRecord = buildColorRecord(context);
          }

          return _AnimatedWidget(
            duration: textDuration,
            curve: textCurve,
            textStyle: TextStyle(
              color: colorRecord.textColor,
              fontSize: buttonSizePreset.fontSize,
              fontWeight: FontWeight.w500,
            ),
            iconThemeData: ElIconThemeData(
              size: iconSize,
              color: colorRecord.textColor,
            ),
            child: Builder(builder: (context) {
              Widget result = buildButtonWrapper(
                context,
                Opacity(
                  opacity: _triggerLoadingBuilder ? 0 : 1,
                  child: buildButtonContent(context),
                ),
              );
              if (loadingBuilder != null && widget.loading) {
                result = Stack(
                  children: [
                    result,
                    Positioned.fill(
                      child: Center(
                        child: loadingBuilder!(context),
                      ),
                    ),
                  ],
                );
              }
              return result;
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

/// 简单封装了文本、图标动画小部件
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
