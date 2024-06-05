import 'package:flutter/painting.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

part '../generates/styles/text.g.dart';

@ElModel.copy()
class ElTextStyle {
  /// 默认文本样式
  static const ElTextStyle style = ElTextStyle(
    textStyle: TextStyle(),
    strutStyle: StrutStyle(),
  );

  /// 文本样式
  final TextStyle? textStyle;

  /// 文字排版样式
  final StrutStyle? strutStyle;

  const ElTextStyle({
    this.textStyle,
    this.strutStyle,
  });

  ElTextStyle copyWith({
    TextStyle? textStyle,
    StrutStyle? strutStyle,
  }) {
    return ElTextStyle(
      textStyle: this.textStyle?.merge(textStyle),
      strutStyle: strutStyle ?? this.strutStyle,
    );
  }

  /// 合并新的主题配置
  ElTextStyle merge([ElTextStyle? style]) {
    if (style == null) return this;
    return copyWith(
      textStyle: textStyle?.merge(style.textStyle),
      strutStyle: style.strutStyle,
    );
  }
}
