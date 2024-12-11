part of 'index.dart';

/// Element UI 按钮抽象类
abstract class ElRawButton extends StatelessWidget {
  const ElRawButton({
    super.key,
    this.type,
    this.duration = _duration,
    this.autofocus = false,
    this.disabled = false,
    this.loading = false,
    this.onPressed,
  });

  /// 主题类型，默认 primary
  final String? type;

  /// 按钮颜色过渡时间
  final Duration duration;

  /// 按钮是否自动聚焦
  final bool autofocus;

  /// 是否禁用按钮，当 [loading] 为 true 时，按钮也将被禁用
  final bool disabled;

  /// 开启 loading
  final bool loading;

  /// 点击事件
  final VoidCallback? onPressed;

  /// 计算按钮的背景颜色
  Color calcBgColor(BuildContext context, Color color) => color;

  /// 计算按钮的文字颜色
  Color calcTextColor(BuildContext context, Color color) => color;

  /// 构建按钮外观
  Widget buildWrapper(BuildContext context);

  @override
  Widget build(BuildContext context) {
    MouseCursor $cursor = loading
        ? MouseCursor.defer
        : disabled
            ? SystemMouseCursors.forbidden
            : SystemMouseCursors.click;

    return ElEvent(
      disabled: disabled || loading,
      autofocus: autofocus,
      cursor: $cursor,
      canRequestFocus: !disabled,
      tapUpDelay: duration.inMilliseconds,
      builder: (context) => buildWrapper(context),
    );
  }
}
