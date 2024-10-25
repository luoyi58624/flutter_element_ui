import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/basic/text.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '文本默认样式')
class ElTextThemeData {
  static const theme = ElTextThemeData();
  static const darkTheme = ElTextThemeData();

  const ElTextThemeData({
    this.data,
    this.duration,
    this.style,
    this.strutStyle,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaler,
    this.maxLines,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.selectionColor,
  });

  /// 渲染的文本内容，支持传递类型数据，它们会统一使用 toString 转成字符串，
  /// 如果是[List]集合，则会当做富文本进行渲染。
  final dynamic data;

  /// 设置文本动画持续时间，默认 [Duration.zero]
  final Duration? duration;

  /// 文本样式
  final TextStyle? style;

  /// 文本基线对齐样式
  final StrutStyle? strutStyle;

  /// 文本水平对齐方式，默认左对齐
  final TextAlign? textAlign;

  /// 控制文本方向：ltr、rtl
  final TextDirection? textDirection;

  /// 指定语言
  final Locale? locale;

  /// 是否自动换行
  final bool? softWrap;

  /// 文本超出样式
  final TextOverflow? overflow;

  /// 文本缩放倍数，如果要放大2倍，设置 TextScaler.linear(2) 即可
  final TextScaler? textScaler;

  /// 文本最大行数
  final int? maxLines;

  /// 测量一行或多行文本宽度的不同方法：
  /// * parent 多行文本将占据父级给出的整个宽度。对于单行文本，将仅使用包含文本所需的最小宽度。这方面的一个常见用例是一系列标准段落
  /// * longestLine 宽度刚好足以容纳最长的一行，而不会更长。一个常见的用例是聊天气泡
  final TextWidthBasis? textWidthBasis;
  final TextHeightBehavior? textHeightBehavior;

  /// 文本选中颜色
  final Color? selectionColor;
}
