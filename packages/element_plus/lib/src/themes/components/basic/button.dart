import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part '../../../generates/themes/components/basic/button.g.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '按钮全局样式')
class ElButtonThemeData {
  static const theme = ElButtonThemeData();
  static const darkTheme = ElButtonThemeData();

  const ElButtonThemeData({
    this.height,
    this.type,
    this.borderRadius,
    this.padding,
  });

  /// 按钮高度，默认全局 baseHeight
  final double? height;

  /// 主题类型
  final String? type;

  /// 按钮圆角，默认全局 radius
  final BorderRadius? borderRadius;

  /// 按钮内边距，默认为高度的一半
  final EdgeInsetsGeometry? padding;
}
