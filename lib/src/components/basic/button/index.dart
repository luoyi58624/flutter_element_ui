import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/extensions/event.dart';
import 'package:flutter_element_ui/src/global.dart';

import '../../../styles/basic/button.dart';
import '../../../utils/icons.dart';
import '../../feedback/loading/loading.dart';
import '../icon.dart';

part 'state.dart';

class ElButton extends StatefulWidget {
  const ElButton({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.bgColor,
    this.color,
    this.type,
    this.text = false,
    this.bg = false,
    this.link = false,
    this.plain = false,
    this.round = false,
    this.block = false,
    this.borderRadius,
    this.padding,
    this.leftIcon,
    this.rightIcon,
    this.circle = false,
    this.disabled = false,
    this.loading = false,
    this.loadingWidget = const ElLoading(ElIcons.loading),
    this.loadingBuilder,
    this.onPressed,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
  });

  /// 支持任意类型子组件：
  /// * 如果是基础类型，则自动渲染为[Text]
  /// * 如果是[Widget]，则直接渲染
  final dynamic child;

  /// 指定按钮宽度，如果[block]或[circle]为true，那么将失效
  final double? width;

  /// 按钮高度，默认36
  final double? height;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 按钮文字、图标颜色，如果为空，则根据[bgColor]自动计算为全局默认的文字颜色
  final Color? color;

  /// 主题类型
  final String? type;

  /// 文字按钮，默认false
  final bool text;

  /// 文字按钮是否添加默认背景
  final bool bg;

  /// 链接按钮，默认false，相比文字按钮，它没有任何边距、以及宽高
  final bool link;

  /// 镂空按钮，默认false
  final bool plain;

  /// 圆角按钮，默认false
  final bool round;

  /// 块级按钮，宽度会充满容器，默认false
  final bool block;

  /// 自定义圆角
  final BorderRadiusGeometry? borderRadius;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 按钮左图标，默认null
  final ElIcon? leftIcon;

  /// 按钮右图标，默认null
  final ElIcon? rightIcon;

  /// 圆形按钮，默认false
  final bool circle;

  /// 禁用按钮，默认false
  final bool disabled;

  /// 开启 loading
  final bool loading;

  /// loading 图标，在左侧显示，如果 [leftIcon] 不为空，则 [leftIcon] 将被替换成 loading
  final Widget loadingWidget;

  /// loading 构建器，它会隐藏按钮原有内容
  final Widget Function(Color color)? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;

  @override
  State<ElButton> createState() => _ElButtonState();
}
