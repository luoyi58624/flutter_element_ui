import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';

import 'link.dart';

abstract class ElBaseLink extends StatelessWidget {
  /// 超链接小部件
  const ElBaseLink({
    super.key,
    required this.href,
    required this.builder,
    this.target = ElLinkTarget.self,
    this.cursor = SystemMouseCursors.click,
    this.color,
    this.activeColor,
    this.decoration,
  });

  /// 超链接地址
  final String href;

  /// 构建超链接子组件，它会传递跳转链接函数
  final Widget Function(VoidCallback to) builder;

  /// 打开链接的目标位置
  final ElLinkTarget target;

  /// 自定义光标样式，默认点击
  final MouseCursor cursor;

  /// 默认的超链接文本颜色
  final Color? color;

  /// 激活的超链接文本颜色
  final Color? activeColor;

  /// 超链接下划线显示逻辑
  final ElLinkDecoration? decoration;

  Widget buildTextTheme(BuildContext context, Widget child) {
    final $defaultStyle = context.elTheme.linkStyle;
    final $color = color ?? $defaultStyle.color;
    final $activeColor = activeColor ?? $defaultStyle.activeColor;
    final $decoration = decoration ?? $defaultStyle.decoration;

    return ElDefaultTextStyle.merge(
      style: TextStyle(
        color: ElHoverBuilder.of(context) ? $activeColor : $color,
        decoration: $decoration == ElLinkDecoration.underline
            ? TextDecoration.underline
            : $decoration == ElLinkDecoration.hoverUnderline
                ? (ElHoverBuilder.of(context)
                    ? TextDecoration.underline
                    : TextDecoration.none)
                : TextDecoration.none,
        decorationColor: ElHoverBuilder.of(context) ? $activeColor : $color,
      ),
      child: child,
    );
  }
}
