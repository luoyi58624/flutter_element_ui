import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../event/index.dart';

abstract class RawButton extends StatelessWidget {
  const RawButton({
    super.key,
    required this.child,
    this.autofocus = false,
    this.loading = false,
    this.disabled = false,
    this.onPressed,
  });

  /// 子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 按钮是否自动聚焦
  final bool autofocus;

  /// 开启 loading
  final bool loading;

  /// 是否禁用按钮，当 [loading] 为 true 时，按钮也将被禁用
  final bool disabled;

  /// 点击事件
  final VoidCallback? onPressed;

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
      builder: (context) => buildWrapper(context),
    );
  }
}
