import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import 'button.dart';
import 'raw_button.dart';

class ElTextButton extends ElButton2 {
  /// Element UI 文字按钮，外观与 [ElButton] 一样，但按钮颜色会跟随当前背景色
  const ElTextButton({
    super.key,
    required super.child,
    this.color,
    this.bg = false,
    super.duration,
    super.curve,
    super.type,
    super.round,
    super.padding,
    super.textStyle,
    super.autofocus,
    super.loading,
    super.disabled,
    super.onPressed,
  });

  /// 自定义文字按钮颜色，它会覆盖 [type] 属性
  final Color? color;

  /// 文字按钮是否添加默认背景，默认 false
  final bool bg;

  @override
  State<ElButton2> createState() => ElTextButtonState();
}

class ElTextButtonState extends ElButton2State<ElTextButton> {
  @override
  ButtonStyle buildButtonStyle(BuildContext context) {
    var bgColor = context.currentBgColor;
    final textColor = widget.color ??
        (widget.type == null
            ? bgColor.elRegularTextColor(context)
            : context.elThemeColors[widget.type]!);

    if (widget.bg) {
      bgColor = context.hasTap
          ? bgColor.deepen(15)
          : context.hasHover
              ? bgColor.deepen(10)
              : bgColor.deepen(5);
    } else {
      bgColor = context.hasTap
          ? bgColor.deepen(10)
          : context.hasHover
              ? bgColor.deepen(5)
              : bgColor;
    }

    return ButtonStyle(
      textColor: textColor,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(sizePreset.radius!),
      ),
    );
  }
}
