import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import '../../components/basic/icon.dart';
import '../theme.dart';

part '../../generates/styles/basic/button.g.dart';

@ElModel.copy()
class ElButtonStyle {
  /// 默认按钮全局样式
  static const ElButtonStyle style = ElButtonStyle(
    height: 36,
    borderRadius: BorderRadius.all(Radius.circular(4)),
  );

  /// 按钮高度，默认36
  final double? height;

  /// 自定义按钮圆角，默认 4 像素，如果[round]为true，则强制渲染为圆角按钮
  final BorderRadiusGeometry? borderRadius;

  /// 自定义按钮 padding，默认情况下，水平 padding 为高度一半
  final EdgeInsetsGeometry? padding;

  const ElButtonStyle({
    this.height,
    this.borderRadius,
    this.padding,
  });
}
