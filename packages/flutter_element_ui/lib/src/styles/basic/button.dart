import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_element_annotation/flutter_element_annotation.dart';

import '../../components/basic/icon.dart';
import '../theme.dart';

part '../../generates/styles/basic/button.g.dart';

@ElModel.copy()
class ElButtonStyle {
  /// 默认按钮样式
  static const ElButtonStyle style = ElButtonStyle(
    height: 36,
    text: false,
    plain: false,
    round: false,
    block: false,
    borderRadius: BorderRadius.all(Radius.circular(4)),
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

  /// 自定义按钮圆角，默认 4 像素，如果[round]为true，则强制渲染为圆角按钮
  final BorderRadiusGeometry? borderRadius;

  /// 自定义按钮 padding，默认情况下，水平 padding 为高度一半
  final EdgeInsetsGeometry? padding;

  /// 按钮左图标，默认null
  final ElIcon? leftIcon;

  /// 按钮右图标，默认null
  final ElIcon? rightIcon;

  /// 圆形按钮，默认false
  final bool? circle;

  /// 禁用按钮，默认false
  final bool? disabled;

  /// 开启 loading
  final bool? loading;

  const ElButtonStyle({
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text,
    this.plain,
    this.round,
    this.block,
    this.borderRadius,
    this.padding,
    this.leftIcon,
    this.rightIcon,
    this.circle,
    this.disabled,
    this.loading,
  });
}
