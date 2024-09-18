import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:url_launcher/link.dart';

enum ElLinkDecoration {
  /// 不显示下划线
  none,

  /// 总是显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

/// 超链接地址显示、隐藏动画控制器
AnimationController? _controller;

/// 透明动画持续时间
const int _animationTime = 200;

/// 延迟显示、隐藏时间
const int _delayTime = 300;

/// 超链接地址预览浮层
OverlayEntry? _linkOverlay;

/// 延迟显示控制器
Timer? _delayShowOverlay;

/// 延迟隐藏控制器
Timer? _delayHideOverlay;

/// 移除浮层前需要先执行隐藏动画，动画结束后再移除浮层
Timer? _delayRemoveOverlay;

/// 响应式变量 - 超链接预览地址
final Obs<String> _href = Obs('');

class _ElLinkInheritedWidget extends InheritedWidget {
  const _ElLinkInheritedWidget(
    this.toLink,
    this.href, {
    required super.child,
  });

  final FollowLink? toLink;
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

  /// 获取超链接地址
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

  void _show(String href) {
    _delayShowOverlay = null;
    _href.value = href;

    if (_linkOverlay == null) {
      _linkOverlay = OverlayEntry(
        builder: (_) => const _LinkOverlay(),
      );
      try {
        Overlay.of(el.context).insert(_linkOverlay!);
      } catch (e) {
        _linkOverlay = null;
        rethrow;
      }
    }
  }

  void _hide() {
    if (_linkOverlay != null) {
      _delayHideOverlay = null;
      _controller!.reverse();
      _delayRemoveOverlay = () {
        _delayRemoveOverlay = null;
        _linkOverlay!.remove();
        _linkOverlay = null;
      }.delay(_animationTime);
    }
  }

  Widget buildTextTheme(BuildContext context, FollowLink? toLink) {
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
    final flag = kIsWeb || !DartUtil.isHttp(widget.href);
    return Link(
      key: globalKey,
      uri: Uri.parse(widget.href),
      target: widget.target,
      builder: (context, toLink) {
        return GestureDetector(
          onTap: () {
            if (toLink != null) toLink();
          },
          child: ElHoverBuilder(
            cursor: widget.cursor,
            onEnter: flag
                ? null
                : (e) {
                    if (_delayHideOverlay != null) {
                      _delayHideOverlay!.cancel();
                      _delayHideOverlay = null;
                    } else {
                      if (_delayRemoveOverlay != null) {
                        _controller!.forward();
                        _delayRemoveOverlay!.cancel();
                        _delayRemoveOverlay = null;
                      }
                    }
                    if (_linkOverlay == null) {
                      _delayShowOverlay =
                          (() => _show(widget.href)).delay(_delayTime);
                    } else {
                      _show(widget.href);
                    }
                  },
            onExit: flag
                ? null
                : (e) {
                    if (_delayShowOverlay != null) {
                      _delayShowOverlay!.cancel();
                      _delayShowOverlay = null;
                    }
                    if (_linkOverlay != null) {
                      _delayHideOverlay = _hide.delay(_delayTime);
                    }
                  },
            builder: (context) {
              return buildTextTheme(context, toLink);
            },
          ),
        );
      },
    );
  }
}

class _LinkOverlay extends StatefulWidget {
  const _LinkOverlay();

  @override
  State<_LinkOverlay> createState() => _LinkOverlayState();
}

class _LinkOverlayState extends State<_LinkOverlay>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: _animationTime.ms);
    _controller!.forward();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      bottom: 0,
      child: AnimatedBuilder(
          animation: _controller!,
          builder: (context, child) {
            return Opacity(
              opacity: _controller!.value,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width - 50,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: const BoxDecoration(
                  color: Color.fromRGBO(227, 227, 227, 1),
                  borderRadius: BorderRadius.only(topRight: Radius.circular(4)),
                  border: Border(
                    top: _linkBorderSide,
                    right: _linkBorderSide,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(0, 0),
                      blurRadius: 12,
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: ObsBuilder(builder: (context) {
                  return ElText(
                    _href.value,
                    style: const TextStyle(
                        fontSize: 12, color: Color.fromRGBO(71, 71, 71, 1)),
                    overflow: TextOverflow.ellipsis,
                  );
                }),
              ),
            );
          }),
    );
  }
}

const BorderSide _linkBorderSide = BorderSide(
  color: Color.fromRGBO(174, 174, 174, 0.4),
);
