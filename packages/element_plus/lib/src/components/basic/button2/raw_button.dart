import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

typedef ElButtonStyleBuilder = ({Color textColor, BoxDecoration decoration});
typedef ElButtonColorStyle = ({Color bgColor, Color textColor});

abstract class ElRawButton extends StatefulWidget {
  const ElRawButton({
    super.key,
    required this.child,
    this.type,
    this.duration,
    this.curve,
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

  /// 按钮动画过渡时间
  final Duration? duration;

  /// 按钮动画曲线
  final Curve? curve;

  /// 自定义图标尺寸
  final double? iconSize;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件
  final bool block;

  /// 按钮是否自动聚焦
  final bool autofocus;

  /// 是否禁用按钮，当 [loading] 为 true 时，按钮也将被禁用
  final bool disabled;

  /// 开启 loading
  final bool loading;

  /// loading 图标小部件
  final Widget? loadingWidget;

  /// loading 构建器，它会隐藏按钮所有内容，如果不为 null，则会替换 [loadingWidget]
  final Widget Function(BuildContext context)? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  State<ElRawButton> createState();
}

abstract class ElRawButtonState<T extends ElRawButton> extends State<T> {
  late ElButtonSizePreset sizePreset;
  late ElButtonStyleBuilder style;
  late MouseCursor cursor;

  Duration get duration =>
      context.elDuration(widget.duration ?? const Duration(milliseconds: 80));

  Curve get curve => widget.curve ?? Curves.linear;

  double get iconSize => widget.iconSize ?? sizePreset.iconSize!;

  /// 构建按钮样式
  ElButtonStyleBuilder buildButtonStyle(BuildContext context);

  /// 构建按钮外观
  Widget buildButtonWrapper(BuildContext context, Widget child) => child;

  /// 构建按钮内容
  Widget buildButtonContent(BuildContext context) {
    return widget.child is Widget ? widget.child : ElText('${widget.child}');
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
