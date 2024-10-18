import 'package:element_plus/src/global.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../../themes/components/basic/button.dart';
import '../../feedback/loading/loading.dart';

part 'state.dart';

part 'button_group.dart';

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
    this.text = false,
    this.bg = false,
    this.link = false,
    this.plain = false,
    this.round = false,
    this.block = false,
    this.borderRadius,
    this.padding,
    this.iconSize,
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
    this.onHover,
  });

  /// 支持任意类型子组件，如果是[Widget]，则直接渲染，否则自动渲染为文字
  final dynamic child;

  /// 指定按钮宽度，按钮的宽度受多种因素影响，具体表现有以下几种情况（按优先级排序）：
  /// * [block]，它会解除按钮约束，通常情况下按钮将充满整个空间，这取决于父级约束条件
  /// * [link]，按钮宽度、高度、内边距全部清空，和普通文字无异
  /// * [circle]，按钮宽度强制等于高度，因为此时按钮是圆形
  /// * [width]，这一步用户指定的宽度才会生效
  /// * 最后一步：如果 [child] 是 [ElIcon] 或 [Icon]，那么 width = height * 1.25，否则最小宽度为 64 像素
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
  final BorderRadius? borderRadius;

  /// 自定义内边距
  final EdgeInsetsGeometry? padding;

  /// 图标尺寸，默认根据按钮高度自动计算，当自定义各种尺寸按钮时自动计算出来的效果往往不是很好，
  /// 这时你可以自己手动微调图标大小。
  final double? iconSize;

  /// 按钮左图标，默认null
  final Widget? leftIcon;

  /// 按钮右图标，默认null
  final Widget? rightIcon;

  /// 圆形按钮，默认false
  final bool circle;

  /// 禁用按钮，默认false
  final bool disabled;

  /// 开启 loading
  final bool loading;

  /// loading 图标小部件
  final Widget loadingWidget;

  /// loading 构建器，这是另一种风格的加载器，它会隐藏按钮所有内容，例如封装 Material 加载器：
  /// ```dart
  /// var loadingBuilder = (ElButtonLoadingData state) => SizedBox(
  ///   width: state.size,
  ///   height: state.size,
  ///   child: CircularProgressIndicator(
  ///     strokeWidth: 2,
  ///     color: state.color,
  ///   ),
  /// );
  /// ```
  final Widget Function(ElButtonLoadingData state)? loadingBuilder;

  /// 点击事件，相对于 onTap
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
