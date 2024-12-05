import 'dart:async';

import 'package:flutter/material.dart';
import 'package:element_plus/src/global.dart';
import 'package:url_launcher/link.dart';

import './web.dart' if (dart.library.io) './io.dart';

part 'theme.dart';

part '../../../generates/components/basic/link/index.g.dart';

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

class _LinkInheritedWidget extends InheritedWidget {
  const _LinkInheritedWidget(
    this.to, {
    required super.child,
  });

  final VoidCallback? to;

  static _LinkInheritedWidget? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_LinkInheritedWidget>();

  @override
  bool updateShouldNotify(_LinkInheritedWidget oldWidget) => true;
}

class ElLink extends StatelessWidget {
  /// 超链接小部件，链接跳转基于 [url_launcher] 第三方库，当鼠标悬停时会在左下角显示链接地址。
  const ElLink({
    super.key,
    required this.child,
    required this.href,
    this.manualTrigger = false,
    this.color,
    this.activeColor,
    this.decoration,
    this.cursor = SystemMouseCursors.click,
    this.target = LinkTarget.blank,
  });

  /// 超链接子组件，如果不是 Widget 类型，则渲染默认样式文本
  final dynamic child;

  /// 超链接地址
  final String href;

  /// 是否手动触发跳转，若为 true 不会触发点击事件，默认 false
  final bool manualTrigger;

  /// 默认的超链接文本颜色
  final Color? color;

  /// 激活的超链接文本颜色
  final Color? activeColor;

  /// 超链接下划线显示逻辑
  final ElLinkDecoration? decoration;

  /// 自定义光标样式，默认点击
  final MouseCursor cursor;

  /// 打开链接的目标位置，默认 blank 新窗口打开
  final LinkTarget target;

  /// 从当前上下文获取最近的超链接实例并触发跳转
  static void to(BuildContext context) {
    _LinkInheritedWidget.maybeOf(context)?.to?.call();
  }

  void _show(String href) {
    _delayShowOverlay = null;
    _href.value = href;

    if (_linkOverlay == null) {
      _linkOverlay = OverlayEntry(
        builder: (_) => const _LinkOverlay(),
      );
      try {
        el.overlay.insert(_linkOverlay!);
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
      _delayRemoveOverlay = setTimeout(() {
        _delayRemoveOverlay = null;
        _linkOverlay!.remove();
        _linkOverlay!.dispose();
        _linkOverlay = null;
      }, _animationTime);
    }
  }

  void _toLink() {
    toLink(href, target);
  }

  void activateOnIntent(Intent? intent) {
    _toLink();
  }

  Widget buildTextTheme(BuildContext context, VoidCallback toLink) {
    final $defaultStyle = context.elTheme.linkTheme;
    final $color = color ?? $defaultStyle.color;
    final $activeColor = activeColor ?? $defaultStyle.activeColor;
    final $decoration = decoration ?? $defaultStyle.decoration;

    return _LinkInheritedWidget(
      toLink,
      child: ElDefaultTextStyle(
        style: TextStyle(
          color: context.hasHover ? $activeColor : $color,
          decoration: $decoration == ElLinkDecoration.underline
              ? TextDecoration.underline
              : $decoration == ElLinkDecoration.hoverUnderline
                  ? (context.hasHover
                      ? TextDecoration.underline
                      : TextDecoration.none)
                  : TextDecoration.none,
          decorationColor: context.hasHover ? $activeColor : $color,
        ),
        child: child is Widget ? child : ElText(child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final previewLink = getPreviewLink(href);
    return DefaultSelectionStyle(
      mouseCursor: cursor,
      child: Actions(
        actions: {
          ActivateIntent:
              CallbackAction<ActivateIntent>(onInvoke: activateOnIntent),
          ButtonActivateIntent:
              CallbackAction<ButtonActivateIntent>(onInvoke: activateOnIntent),
        },
        child: ElEvent(
          cursor: cursor,
          onTap: manualTrigger == true
              ? null
              : () {
                  _toLink();
                },
          onEnter: previewLink == null
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
                    _delayShowOverlay = setTimeout(() {
                      _show(previewLink);
                    }, _delayTime);
                  } else {
                    _show(previewLink);
                  }
                },
          onExit: previewLink == null
              ? null
              : (e) {
                  if (_delayShowOverlay != null) {
                    _delayShowOverlay!.cancel();
                    _delayShowOverlay = null;
                  }
                  if (_linkOverlay != null) {
                    _delayHideOverlay = setTimeout(_hide, _delayTime);
                  }
                },
          builder: (context) {
            // if (previewLink != null) {
            //   if (Focus.maybeOf(context)?.hasFocus == true) {
            //     nextTick(() {
            //       _show(previewLink);
            //     });
            //   } else {
            //     if (_delayShowOverlay != null) {
            //       _delayShowOverlay!.cancel();
            //       _delayShowOverlay = null;
            //     }
            //     if (_linkOverlay != null) {
            //       _delayHideOverlay = setTimeout(_hide, _delayTime);
            //     }
            //   }
            // }

            return buildTextTheme(context, _toLink);
          },
        ),
      ),
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
      child: IgnorePointer(
        child: AnimatedBuilder(
            animation: _controller!,
            builder: (context, child) {
              return Opacity(
                opacity: _controller!.value,
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width - 50,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(227, 227, 227, 1),
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(4)),
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
      ),
    );
  }
}

const BorderSide _linkBorderSide = BorderSide(
  // width: 0.5,
  color: Color.fromRGBO(174, 174, 174, 0.4),
);
