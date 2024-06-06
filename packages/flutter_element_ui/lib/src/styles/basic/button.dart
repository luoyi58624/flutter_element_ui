import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import '../../components/basic/icon/icon.dart';
import '../theme.dart';

part '../../generates/styles/basic/button.g.dart';

@ElModel.copy()
class ElButtonStyle {
  /// 默认按钮样式
  static const ElButtonStyle style = ElButtonStyle(
    height: 36,
    type: null,
    text: false,
    plain: false,
    round: false,
    block: false,
    radius: null,
    padding: null,
    rightIcon: null,
    circle: false,
    disabled: false,
  );

  /// 按钮高度，默认36
  final double? height;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 按钮文字、图标颜色，如果为空，则根据[bgColor]自动计算为全局默认的文字颜色
  final Color? color;

  /// 主题类型，默认null
  final ElThemeType? type;

  /// 文字按钮，默认false
  final bool? text;

  /// 镂空按钮，默认false
  final bool? plain;

  /// 圆角按钮，默认false
  final bool? round;

  /// 块级按钮，宽度会充满容器，默认false
  final bool? block;

  /// 自定义按钮圆角，如果[round]为true，则渲染圆角按钮，否则按钮默认圆角为 4 像素
  final BorderRadiusGeometry? radius;

  /// 定义按钮 padding，默认水平 padding 为高度一半
  final EdgeInsetsGeometry? padding;

  /// 按钮右图标，默认null
  final ElIcon? rightIcon;

  /// 圆形图标按钮，当child为[ElIcon]时生效，默认false
  final bool? circle;

  /// 禁用按钮，默认false
  final bool? disabled;

  /// 自定义按钮样式，创建的样式会基于默认的[style]进行合并
  const ElButtonStyle({
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text,
    this.plain,
    this.round,
    this.block,
    this.radius,
    this.padding,
    this.rightIcon,
    this.circle,
    this.disabled,
  });
}
