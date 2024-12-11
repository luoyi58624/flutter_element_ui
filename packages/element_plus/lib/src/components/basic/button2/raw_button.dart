part of 'index.dart';

/// Element UI 按钮抽象类
abstract class ElRawButton extends StatefulWidget {
  const ElRawButton({
    super.key,
    required this.child,
    this.type,
    this.duration = const Duration(milliseconds: 64),
    this.curve = Curves.linear,
    this.textStyle,
    this.autofocus = false,
    this.disabled = false,
    this.loading = false,
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

  /// 按钮是否自动聚焦
  final bool autofocus;

  /// 是否禁用按钮，当 [loading] 为 true 时，按钮也将被禁用
  final bool disabled;

  /// 开启 loading
  final bool loading;

  /// 点击事件
  final VoidCallback? onPressed;

  @override
  State<ElRawButton> createState();
}

abstract class ElRawButtonState<T extends ElRawButton> extends State<T>
    with ElSizeMixin<T, ElButtonSizePreset> {
  Widget get child =>
      widget.child is Widget ? widget.child : ElText('${widget.child}');

  Duration get duration => context.elDuration(widget.duration);

  late ElButtonSizePreset sizePreset;

  @override
  ElButtonSizePreset mini(BuildContext context) {
    return const ElButtonSizePreset(
        width: 48, height: 28, fontSize: 12, iconSize: 12);
  }

  @override
  ElButtonSizePreset small(BuildContext context) {
    return const ElButtonSizePreset(
        width: 56, height: 32, fontSize: 14, iconSize: 14);
  }

  @override
  ElButtonSizePreset medium(BuildContext context) {
    return const ElButtonSizePreset(
        width: 64, height: 36, fontSize: 15, iconSize: 16);
  }

  @override
  ElButtonSizePreset large(BuildContext context) {
    return const ElButtonSizePreset(
        width: 72, height: 40, fontSize: 16, iconSize: 18);
  }

  /// 计算按钮的背景颜色
  Color calcBgColor(BuildContext context, Color color) => color;

  /// 计算按钮的文字颜色
  Color calcTextColor(BuildContext context, Color color) => color;

  /// 构建按钮外观
  Widget buildWrapper(BuildContext context);

  @override
  Widget build(BuildContext context) {
    sizePreset = getSizePreset();
    MouseCursor $cursor = widget.loading
        ? MouseCursor.defer
        : widget.disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click;

    return ElEvent(
      disabled: widget.disabled || widget.loading,
      autofocus: widget.autofocus,
      cursor: $cursor,
      canRequestFocus: !widget.disabled,
      tapUpDelay: widget.duration.inMilliseconds,
      builder: (context) => buildWrapper(context),
    );
  }
}
