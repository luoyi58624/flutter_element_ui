import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

import './web.dart' if (dart.library.io) './io.dart';

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

enum ElLinkDecoration {
  /// 不显示下划线
  none,

  /// 总是显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

enum ElLinkTarget {
  /// 在当前页面打开
  self,

  /// 在新标签页打开 (默认)
  blank,

  /// 在父框架中打开链接文档，对于非 Web 端，效果等同于 [blank]
  parent,

  /// 在窗口的整个主体中打开链接的文档，对于非 Web 端，效果等同于 [blank]
  top,
}

class _LinkInheritedWidget extends InheritedWidget {
  const _LinkInheritedWidget({
    this.href,
    this.to,
    required super.child,
  });

  final String? href;
  final VoidCallback? to;

  static _LinkInheritedWidget of(BuildContext context) {
    final _LinkInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_LinkInheritedWidget>();
    assert(result != null,
        '当前上下文 context 无法获取 ElLink 实例，请尝试使用 Builder 小部件转发 context');
    return result!;
  }

  @override
  bool updateShouldNotify(_LinkInheritedWidget oldWidget) => true;
}

typedef _LinkStyleProp = ({
  MouseCursor cursor,
  Color color,
  Color activeColor,
  ElLinkDecoration decoration,
  ElLinkTarget target,
  bool? enabledPreview,
  bool enableFeedback,
});

class ElLink extends StatelessWidget {
  /// 超链接小部件，当鼠标悬停时会在左下角显示链接地址，如果子组件设置了点击事件，
  /// 那么你需要手动执行跳转，可以通过 ElLink.to(context) 执行跳转方法，也可以通过
  /// ElLink.getHref(context) 获取注入的地址，实现自定义跳转逻辑。
  const ElLink({
    super.key,
    required this.child,
    this.href,
    this.cursor,
    this.color,
    this.activeColor,
    this.decoration,
    this.target,
    this.enabledPreview,
    this.enableFeedback,
  });

  /// 超链接子组件，如果不是 Widget 类型，则渲染默认样式文本
  final dynamic child;

  /// 超链接地址
  final String? href;

  /// 自定义光标样式，默认点击
  final MouseCursor? cursor;

  /// 默认的超链接文本颜色
  final Color? color;

  /// 激活的超链接文本颜色
  final Color? activeColor;

  /// 超链接下划线显示逻辑
  final ElLinkDecoration? decoration;

  /// 打开链接的目标位置，默认 blank 新窗口打开
  final ElLinkTarget? target;

  /// 是否开启超链接地址预览
  final bool? enabledPreview;

  /// 是否开启触觉回馈
  final bool? enableFeedback;

  /// 从当前上下文获取最近的超链接地址
  static String? getHref(BuildContext context) =>
      _LinkInheritedWidget.of(context).href;

  /// 从当前上下文获取最近的超链接实例并触发跳转
  static void to(BuildContext context) {
    final $to = _LinkInheritedWidget.of(context).to;
    if ($to != null) $to();
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

  @override
  Widget build(BuildContext context) {
    final defaultStyle = context.elTheme.linkStyle;
    _LinkStyleProp styleProp = (
      cursor: cursor ?? defaultStyle.cursor,
      color: color ?? defaultStyle.color,
      activeColor: activeColor ?? defaultStyle.activeColor,
      decoration: decoration ?? defaultStyle.decoration,
      target: target ?? defaultStyle.target,
      enabledPreview: enabledPreview ?? defaultStyle.enableFeedback,
      enableFeedback: enableFeedback ??
          defaultStyle.enableFeedback ??
          context.elConfig.enableFeedback,
    );
    final $href = getFullHref(href);
    final $to = $href == null ? null : () => toHref($href, styleProp.target);
    bool $enabledPreview = false;

    if ($href != null) {
      if (DartUtil.isHttp($href)) {
        $enabledPreview = true;
      } else {
        if (styleProp.enabledPreview == null) {
          if (kIsWeb) {
            $enabledPreview = true;
          }
        } else {
          $enabledPreview = styleProp.enabledPreview!;
        }
      }
    }
    return _LinkInheritedWidget(
      href: href,
      to: $to,
      child: Builder(builder: (context) {
        return ElHoverBuilder(
          cursor: styleProp.cursor,
          onEnter: $enabledPreview == false
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
                    _delayShowOverlay = (() => _show($href!)).delay(_delayTime);
                  } else {
                    _show($href!);
                  }
                },
          onExit: $enabledPreview == false
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
          builder: (context) => ElTapBuilder(
            onTap: $to,
            builder: (context) {
              if (child is Widget) {
                return child;
              } else {
                return ElDefaultTextStyle.merge(
                  style: TextStyle(
                    color: ElHoverBuilder.of(context)
                        ? styleProp.activeColor
                        : styleProp.color,
                    decoration:
                        styleProp.decoration == ElLinkDecoration.underline
                            ? TextDecoration.underline
                            : styleProp.decoration ==
                                    ElLinkDecoration.hoverUnderline
                                ? (ElHoverBuilder.of(context)
                                    ? TextDecoration.underline
                                    : TextDecoration.none)
                                : TextDecoration.none,
                    decorationColor: ElHoverBuilder.of(context)
                        ? styleProp.activeColor
                        : styleProp.color,
                  ),
                  child: ElText(child),
                );
              }
            },
          ),
        );
      }),
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
  // width: 0.5,
  color: Color.fromRGBO(174, 174, 174, 0.4),
);
