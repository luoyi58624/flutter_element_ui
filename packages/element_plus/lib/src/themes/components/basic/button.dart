import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

import '../../../components/basic/button/index.dart';

part '../../../generates/themes/components/basic/button.g.dart';

@$ElModel.copy()
@$ElThemeModel(desc: '按钮默认样式')
class ElButtonThemeData {
  static const theme = ElButtonThemeData();
  static const darkTheme = ElButtonThemeData();

  const ElButtonThemeData({
    this.child,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text,
    this.bg,
    this.link,
    this.plain,
    this.round,
    this.block,
    this.borderBuilder,
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.circle,
    this.loadingWidget,
    this.loadingBuilder,
  });

  /// 按钮默认内容
  final dynamic child;

  /// 按钮默认宽度，如果是按钮组，[ElButton] 的 block、link、circle 等属性将不会影响指定的宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 按钮文字、图标颜色
  final Color? color;

  /// 主题类型
  final String? type;

  /// 文字按钮
  final bool? text;

  /// 文字按钮是否添加默认背景
  final bool? bg;

  /// 链接按钮，相比文字按钮，它没有任何边距、以及宽高
  final bool? link;

  /// 镂空按钮
  final bool? plain;

  /// 圆角按钮
  final bool? round;

  /// 块级按钮，宽度会充满容器，其原理只是移除 [UnconstrainedBox] 小部件
  final bool? block;

  /// 构建自定义边框
  final ElBorderBuilder? borderBuilder;

  /// 边框圆角
  final BorderRadius? borderRadius;

  /// 按钮内边距，默认为高度的一半
  final EdgeInsetsGeometry? padding;

  /// 图标尺寸，默认根据按钮高度自动计算，当自定义各种尺寸按钮时自动计算出来的效果往往不是很好，
  /// 这时你可以自己手动微调图标大小。
  final double? iconSize;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆形按钮
  final bool? circle;

  /// loading 图标小部件
  final Widget? loadingWidget;

  /// loading 构建器，它会替代 [loadingWidget]，其特点是背景颜色固定为灰色、同时隐藏原有内容，只展示用户构建的 Widget
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;
}

/// 构建按钮自定义边框
typedef ElBorderBuilder = Border Function(ElButtonBorderState state);

class ElButtonLoadingState {
  /// 按钮 loading 颜色，它的颜色跟随图标的文字颜色
  final Color color;

  /// 按钮 loading 尺寸，它的大小和图标一致
  final double size;

  ElButtonLoadingState({
    required this.color,
    required this.size,
  });
}

class ElButtonBorderState {
  /// 按钮边框颜色
  final Color color;

  /// 按钮是否处于悬停状态
  final bool isHover;

  /// 按钮是否处于点击状态
  final bool isTap;

  /// 按钮是否处于选中状态，只有在按钮组中此属性才会生效
  final bool isSelected;

  const ElButtonBorderState({
    this.color = Colors.transparent,
    this.isHover = false,
    this.isTap = false,
    this.isSelected = false,
  });
}
