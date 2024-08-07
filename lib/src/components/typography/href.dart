import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/components/typography/text.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../services/service.dart';
import 'href/web.dart' if (dart.library.io) 'href/io.dart';

OverlayEntry? _hrefOverlay;

enum HrefDecoration {
  /// 不显示下划线
  none,

  /// 显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

class A extends StatelessWidget {
  /// 超链接小部件，当鼠标悬停时会在左下角显示链接地址，如果子组件是[Widget]，则不会触发点击事件，
  /// 其他数据类型则会调用 [builder] 构建默认风格的文本小部件。
  ///
  /// 提示：如果是客户端，链接地址不是 http 开头将不会显示链接地址，如果是浏览器，则会自动拼接当前网址基本路径
  const A({
    super.key,
    required this.child,
    required this.href,
    this.cursor,
    this.color = hrefColor,
    this.activeColor = hrefColor,
    this.decoration = HrefDecoration.hoverUnderline,
  });

  /// 超链接内容，如果不是 Widget 类型，则直接渲染成文本，并添加默认的点击跳转事件
  final dynamic child;

  /// 超链接地址
  final String href;

  /// 自定义光标样式，默认点击
  final MouseCursor? cursor;

  /// 默认的超链接文本颜色
  final Color color;

  /// 激活的超链接文本颜色
  final Color activeColor;

  /// 超链接下划线显示逻辑
  final HrefDecoration decoration;

  static const Color hrefColor = Color.fromRGBO(9, 105, 218, 1);

  @override
  Widget build(BuildContext context) {
    final $href = getFullHref(href);
    late Widget result;
    if (child is Widget) {
      result = child;
    } else {
      result = TapBuilder(
        onTap: $href == null
            ? null
            : () {
                launchUrl(Uri.parse($href));
              },
        builder: (context) {
          return DefaultTextStyle.merge(
            style: TextStyle(
              color: HoverBuilder.of(context) ? activeColor : color,
              decoration: decoration == HrefDecoration.underline
                  ? TextDecoration.underline
                  : decoration == HrefDecoration.hoverUnderline
                      ? (HoverBuilder.of(context)
                          ? TextDecoration.underline
                          : TextDecoration.none)
                      : TextDecoration.none,
              decorationColor: HoverBuilder.of(context) ? activeColor : color,
            ),
            child: ElText(child),
          );
        },
      );
    }
    return HoverBuilder(
      cursor: cursor ?? SystemMouseCursors.click,
      onHover: $href == null
          ? null
          : (e) {
              if (_hrefOverlay == null) {
                _hrefOverlay = OverlayEntry(
                  builder: (context) => Positioned(
                    left: 0,
                    bottom: 0,
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width - 50,
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: context.isDark
                            ? Colors.grey.shade700
                            : Colors.grey.shade300,
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(4)),
                      ),
                      child: ElText(
                        $href,
                        style: const TextStyle(fontSize: 12),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ).animate().fade(),
                  ),
                );
                Overlay.of(el.context).insert(_hrefOverlay!);
              }
            },
      onExit: (e) {
        if (_hrefOverlay != null) {
          _hrefOverlay!.remove();
          _hrefOverlay = null;
        }
      },
      builder: (context) => result,
    );
  }
}
