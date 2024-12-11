part of 'index.dart';

/// Element UI 按钮抽象类
abstract class ElRawButton extends StatefulWidget {
  const ElRawButton({
    super.key,
    required this.child,
    this.type,
    this.duration = const Duration(milliseconds: 80),
    this.curve = Curves.linear,
    this.textStyle,
    this.block = false,
    this.autofocus = false,
    this.disabled = false,
    this.loading = false,
    this.loadingWidget = const ElLoading(ElIcons.loading),
    this.loadingBuilder,
    this.onPressed,
  });

  /// 子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 主题类型，默认 primary
  final String? type;

  /// 按钮动画过渡时间
  final Duration duration;

  /// 按钮动画曲线
  final Curve curve;

  /// 自定义文本样式，其样式会通过 [ElDefaultTextStyle] 注入
  final TextStyle? textStyle;

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
  final Widget Function(ElButtonLoadingData data)? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  State<ElRawButton> createState();
}

abstract class ElRawButtonState<T extends ElRawButton> extends State<T> {
  Duration get duration => context.elDuration(widget.duration);

  late ElButtonSizePreset sizePreset;
  late MouseCursor cursor;

  /// 定义按钮初始背景颜色
  Color get bgColor;

  /// 定义按钮初始文本颜色
  Color get textColor;

  /// 计算按钮交互背景颜色
  Color calcBgColor(BuildContext context, Color color) => color;

  /// 计算按钮交互文字颜色
  Color calcTextColor(BuildContext context, Color color) => color;

  /// 构建按钮外观
  Widget buildWrapper(BuildContext context, Widget child);

  /// 构建按钮内容
  Widget buildContent(BuildContext context) {
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
      tapUpDelay: widget.duration.inMilliseconds,
      builder: (context) => buildWrapper(
        context,
        buildContent(context),
      ),
    );
    if (!widget.block) {
      result = UnconstrainedBox(
        child: result,
      );
    }
    return result;
  }
}
