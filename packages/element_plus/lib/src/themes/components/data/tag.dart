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
    this.leftIcon,
    this.width,
    this.height,
    this.bgColor,
    this.textColor,
    this.textSize,
    this.iconColor,
    this.iconSize,
    this.plain,
    this.round,
    this.closable,
    this.borderRadius,
    this.padding,
  });

  /// 主题类型，默认 [El.primary]
  final String? type;

  /// 左图标
  final Widget? leftIcon;

  /// 标签最小宽度
  final double? width;

  /// 标签高度，默认 28
  final double? height;

  /// 自定义标签背景颜色，此属性会替代 [type]
  final Color? bgColor;

  /// 文字颜色
  final Color? textColor;

  /// 文字大小，默认 12
  final double? textSize;

  /// 图标颜色
  final Color? iconColor;

  /// 图标大小，默认 18
  final double? iconSize;

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
