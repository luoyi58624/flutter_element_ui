import 'package:flutter/widgets.dart';

/// 字体排版配置
class ElTypographyData {
  /// 默认的字体排版配置
  static final data = ElTypographyData(
    h1: 28,
    h2: 24,
    h3: 20,
    h4: 18,
    h5: 16,
    h6: 14,
    text: 15,
  );

  /// 一级标题
  final double h1;

  /// 二级标题
  final double h2;

  /// 三级标题
  final double h3;

  /// 四级标题
  final double h4;

  /// 五级标题
  final double h5;

  /// 六级标题
  final double h6;

  /// 普通文本
  final double text;

  final Widget Function(BuildContext context, String)? builder;

  ElTypographyData({
    required this.h1,
    required this.h2,
    required this.h3,
    required this.h4,
    required this.h5,
    required this.h6,
    required this.text,
    this.builder,
  });

  ElTypographyData copyWith({
    double? h1,
    double? h2,
    double? h3,
    double? h4,
    double? h5,
    double? h6,
    double? text,
    Color? hrefColor,
    bool? underline,
    bool? hoverUnderline,
  }) {
    return ElTypographyData(
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      h5: h5 ?? this.h5,
      h6: h6 ?? this.h6,
      text: text ?? this.text,
    );
  }
}
