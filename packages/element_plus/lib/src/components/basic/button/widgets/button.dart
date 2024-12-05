import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

import 'raw_button.dart';

class ElButton2 extends RawButton {
  const ElButton2({
    super.key,
    required super.child,
    this.type,
    this.width,
    this.height,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 主题类型
  final String? type;
  final double? width;
  final double? height;

  @override
  Widget buildWrapper(BuildContext context) {
    Widget result = child is Widget ? child : ElText('$child');
    final $height = context.elConfig.size!;
    result = UnconstrainedBox(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: $height,
        ),
        child: AnimatedDecoratedBox(
          duration: context.elDuration(const Duration(milliseconds: 200)),
          decoration: BoxDecoration(
            color: context.hasHover
                ? context.elTheme.primary
                : context.elLayout.bgColor,
            borderRadius: context.elConfig.radius,
            border: Border.all(
              width: 2.0,
              color: context.elTheme.primary,
            ),
          ),
          child: ElAnimatedDefaultTextStyle(
            duration: context.elDuration(const Duration(milliseconds: 200)),
            style: TextStyle(
              color: context.hasHover
                  ? Colors.white
                  : context.elTheme.primary,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: $height / 2),
              child: Center(
                child: result,
              ),
            ),
          ),
        ),
      ),
    );

    return result;
  }
}
