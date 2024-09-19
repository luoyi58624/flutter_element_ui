import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:url_launcher/link.dart';

import './web.dart' if (dart.library.io) './io.dart';

enum ElLinkDecoration {
  /// 不显示下划线
  none,

  /// 总是显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

class _ElLinkInheritedWidget extends InheritedWidget {
  const _ElLinkInheritedWidget(
    this.toLink,
    this.href, {
    required super.child,
  });

  final VoidCallback? toLink;
  final String href;

  static _ElLinkInheritedWidget of(BuildContext context) {
    final _ElLinkInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_ElLinkInheritedWidget>();
    assert(result != null,
        '当前上下文 context 无法获取 ElLink 实例，请尝试使用 Builder 小部件转发 context');
    return result!;
  }

  @override
  bool updateShouldNotify(_ElLinkInheritedWidget oldWidget) => true;
}

class ElLink extends StatefulWidget {
  /// Element UI 超链接小部件，它基于第三方库 [url_launcher] 进行的封装，在 web 平台上会渲染成原生 a 标签
  const ElLink({
    super.key,
    required this.href,
    required this.child,
    this.title,
    this.allowDrag,
    this.target = LinkTarget.self,
    this.cursor = SystemMouseCursors.click,
    this.color,
    this.activeColor,
    this.decoration,
    this.name,
  });

  /// 超链接地址，除了支持 http 链接外，还支持 flutter 声明的路由
  final String href;

  /// 超链接子组件，如果不是 Widget 类型，则默认渲染成 [ElText]
  final dynamic child;

  /// 超链接标题描述，在 web 平台上，超链接可以允许被拖拽，该属性是用于描述拖拽的链接名字，
  /// 如果 [child] 不是 [Widget] 类型，则标题默认应用 [child] 内容
  final String? title;

  /// 是否允许拖拽超链接（仅限 web 平台），此属性支持全局配置，默认true
  final bool? allowDrag;

  /// 打开链接的目标位置，默认 [LinkTarget.self]
  final LinkTarget target;

  /// 自定义光标样式，默认 [SystemMouseCursors.click]
  final MouseCursor cursor;

  /// 超链接文本颜色
  final Color? color;

  /// 激活的超链接文本颜色
  final Color? activeColor;

  /// 超链接下划线样式
  final ElLinkDecoration? decoration;

  /// 定义链接锚点，如果不为空，当初始化时会将它存放于 [anchorMap] 集合中。
  ///
  /// 提示：内部会自动添加 # 符号。
  final String? name;

  /// 超链接瞄点 Map 集合，如果设置了 [name]，初始化时会将当前 [ElLink] 对象存放到此集合中，
  /// 销毁时会自动移除。
  static final Map<String, GlobalKey> anchorMap = {};

  /// 滚动到锚点位置
  static void scrollAnchor(String url) {
    BuildContext? context;
    // 如果 url 存在 # 锚点符号，则尝试解析 url 地址获取 ElLink 的 context 对象
    if (url.contains('#')) {
      final key = Uri.decodeComponent(url).split('#').last;
      context = anchorMap['#$key']?.currentContext;
    }
    // 若是单纯的字符串，则当作 name 直接访问
    else {
      context = anchorMap['#$url']?.currentContext;
    }
    if (context != null) {
      Scrollable.ensureVisible(context);
    }
  }

  /// 跳转链接，如果子组件存在 [GestureDetector] 事件小部件，那么它将覆盖默认的点击事件，
  /// 所以提供此函数供用户手动跳转链接。
  static void toLink(BuildContext context) {
    final $toLink = _ElLinkInheritedWidget.of(context).toLink;
    if ($toLink != null) $toLink();
  }

  /// 获取链接地址
  static String getLink(BuildContext context) {
    return _ElLinkInheritedWidget.of(context).href;
  }

  @override
  State<ElLink> createState() => _ElLinkState();
}

class _ElLinkState extends State<ElLink> {
  final globalKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      ElLink.anchorMap['#${widget.name}'] = globalKey;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.name != null) {
      ElLink.anchorMap.remove('#${widget.name}');
    }
  }

  Widget buildTextTheme(BuildContext context, VoidCallback? toLink) {
    final $defaultStyle = context.elTheme.linkStyle;
    final $color = widget.color ?? $defaultStyle.color;
    final $activeColor = widget.activeColor ?? $defaultStyle.activeColor;
    final $decoration = widget.decoration ?? $defaultStyle.decoration;

    return _ElLinkInheritedWidget(
      toLink,
      widget.href,
      child: ElDefaultTextStyle.merge(
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
        child: widget.child is Widget ? widget.child : ElText(widget.child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LinkWidget(
      key: globalKey,
      href: widget.href,
      title: widget.title ??
          (widget.child is! Widget ? widget.child.toString() : ''),
      allowDrag: widget.allowDrag ?? context.elTheme.linkStyle.allowDrag,
      target: widget.target,
      cursor: widget.cursor,
      builder: (context, toLink) => buildTextTheme(context, toLink),
    );
  }
}
