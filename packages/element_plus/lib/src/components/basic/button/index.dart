import 'dart:async';

import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../themes/components/basic/button.dart';
import '../../../themes/components/basic/icon.dart';
import '../../feedback/loading/loading.dart';

part 'state.dart';

part 'button_group.dart';

part 'commons.dart';

class ElButton extends StatefulWidget {
  /// Element UI 按钮小部件
  const ElButton({
    super.key,
    required this.child,
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
    this.borderRadius,
    this.padding,
    this.iconSize,
    this.leftIcon,
    this.rightIcon,
    this.circle,
    this.disabled,
    this.loading,
    this.loadingWidget,
    this.loadingBuilder,
    this.onPressed,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onHover,
  });

  /// 子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 按钮宽度，按钮的宽度受多种因素影响，具体表现有以下几种情况（按优先级排序）：
  /// * [block]，它会解除按钮约束，通常情况下按钮将充满整个空间，这取决于父级约束条件
  /// * [link]，按钮宽度、高度、内边距全部清空，和普通文字无异
  /// * [circle]，按钮宽度强制等于高度，因为此时按钮是圆形
  /// * [width]，这一步用户指定的宽度才会生效，注意：宽度约束为 minWidth
  /// * 最后：如果 [child] 是 [ElIcon] 或 [Icon]，那么 width = height * 1.25，否则最小宽度为 64 像素
  final double? width;

  /// 按钮高度
  final double? height;

  /// 按钮背景颜色
  final Color? bgColor;

  /// 按钮文字、图标颜色，如果为空，则根据 [bgColor] 自动计算为全局默认的文字颜色
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

  /// 自定义圆角
  final BorderRadius? borderRadius;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 图标尺寸，默认根据按钮高度自动计算: [height] / 2 - 2，如果图标尺寸不符合预期，
  /// 你可以自己手动指定图标大小
  final double? iconSize;

  /// 按钮左图标
  final Widget? leftIcon;

  /// 按钮右图标
  final Widget? rightIcon;

  /// 圆形按钮
  final bool? circle;

  /// 是否禁用按钮
  final bool? disabled;

  /// 开启 loading
  final bool? loading;

  /// loading 图标小部件
  final Widget? loadingWidget;

  /// loading 构建器，它会隐藏按钮所有内容，如果不为 null，则会替换 [loadingWidget]
  final Widget Function(ElButtonLoadingState state)? loadingBuilder;

  /// 点击事件
  final VoidCallback? onPressed;

  /// 按下事件
  final GestureTapDownCallback? onTapDown;

  /// 松开按下事件
  final GestureTapUpCallback? onTapUp;

  /// 取消点击事件
  final GestureTapCancelCallback? onTapCancel;

  /// 悬停事件
  final PointerHoverEventListener? onHover;

  @override
  State<ElButton> createState() => _ElButtonState();
}
