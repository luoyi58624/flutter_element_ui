import 'package:flutter/material.dart' show Badge;
import 'package:element_plus/src/global.dart';
import 'package:flutter/widgets.dart';

import '../../../utils/font.dart';

part 'state.dart';

part 'style.dart';

class ElBadge extends StatelessWidget {
  const ElBadge({
    super.key,
    required this.child,
    required this.badge,
    this.color,
    this.max = 99,
    this.hideZero = true,
    this.offset,
  });

  final Widget child;
  final dynamic badge; // 徽章内容，支持字符串和数字
  final Color? color; // 徽章颜色，默认为红色
  final int max; // 限制显示的最大值，超出此数后面追加+
  final bool hideZero; // 当值小于等于0时，是否将其隐藏
  final Offset? offset;

  @override
  Widget build(BuildContext context) {
    if (FlutterUtil.isEmpty(badge)) return child;
    if (badge is num) {
      return Badge(
        label: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 16),
          child: Center(
            child: Text(badge > max ? '$max+' : badge.toString()),
          ),
        ),
        isLabelVisible: hideZero ? badge > 0 : true,
        padding: badgePadding,
        backgroundColor: color ?? context.elTheme.error,
        textColor: context.darkTheme.textTheme.textStyle.color,
        textStyle: textStyle,
        offset: offset,
        child: child,
      );
    } else {
      return Badge(
        label: Text(badge),
        padding: const EdgeInsets.symmetric(horizontal: 4),
        backgroundColor: color ?? context.elTheme.error,
        textColor: context.darkTheme.textTheme.textStyle.color,
        textStyle: textStyle,
        offset: offset,
        child: child,
      );
    }
  }

  TextStyle get textStyle => TextStyle(fontSize: 12, fontWeight: ElFont.medium);

  /// 让徽章填充样式更加好看，默认情况下徽章给人的感官没有对齐
  EdgeInsetsGeometry get badgePadding {
    if (badge < 10) {
      return const EdgeInsets.symmetric(horizontal: 1);
    } else {
      return const EdgeInsets.symmetric(horizontal: 4);
    }
  }
}
