import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/data/tag.g.dart';

@ElModel.copy()
@ElThemeModel(desc: '标签默认样式')
class ElTagThemeData {
  static const theme = ElTagThemeData();
  static const darkTheme = ElTagThemeData();

  const ElTagThemeData({
    this.type,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.plain,
    this.round,
    this.closable,
    this.borderRadius,
    this.padding,
  });

  /// 主题类型，默认 [El.primary]
  final String? type;

  /// 标签最小宽度
  final double? width;

  /// 标签高度
  final double? height;

  /// 自定义标签背景颜色，此属性会替代 [type]
  final Color? bgColor;

  /// 文字、图标颜色，如果为空，则根据 [bgColor] 自动计算
  final Color? color;

  /// 镂空标签
  final bool? plain;

  /// 圆角标签
  final bool? round;

  /// 是否可关闭
  final bool? closable;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;
}
