import 'dart:async';

import 'package:flutter/material.dart';
import 'package:luoyi_flutter_base/luoyi_flutter_base.dart';

import '../../../components/basic/text.dart';
import './web.dart' if (dart.library.io) './io.dart';

/// 超链接地址显示、隐藏动画控制器
AnimationController? _controller;

/// 透明动画持续时间
const int _animationTime = 200;

/// 延迟显示、隐藏时间
const int _delayTime = 300;

/// 超链接地址预览浮层
OverlayEntry? _hrefOverlay;

/// 延迟显示控制器
Timer? _delayShowOverlay;

/// 延迟隐藏控制器
Timer? _delayHideOverlay;

/// 移除浮层前需要先执行隐藏动画，动画结束后再移除浮层
Timer? _delayRemoveOverlay;

/// 超链接浮层地址响应式变量
final Obs<String> _href = Obs('');

enum HrefDecoration {
  /// 不显示下划线
  none,

  /// 总是显示下划线
  underline,

  /// 当悬停时显示下划线
  hoverUnderline,
}

class _HrefInheritedWidget extends InheritedWidget {
  const _HrefInheritedWidget({
    this.href,
    required super.child,
  });

  final String? href;

  static String? of(BuildContext context) {
    final _HrefInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<_HrefInheritedWidget>();
    assert(result != null, '当前上下文 context 无法获取超链接地址，请使用 Builder 小部件转发 context');
    return result!.href;
  }

  @override
  bool updateShouldNotify(_HrefInheritedWidget oldWidget) => true;
}

class A extends StatelessWidget {
  /// 超链接小部件，当鼠标悬停时会在左下角显示链接地址，当点击时将进行跳转，如果子组件设置了点击事件，
  /// 则超链接点击事件将失效，你可以通过 A.of(context) 访问超链接地址。
  ///
  /// 提示：如果是客户端，链接地址不是 http 开头将不会显示链接地址，如果是浏览器，则会自动拼接当前网址基本路径。
  const A(
    this.child, {
    super.key,
    this.href,
    this.cursor,
    this.color = hrefColor,
    this.activeColor = hrefColor,
    this.decoration = HrefDecoration.none,
  });

  /// 超链接子组件，如果不是 Widget 类型，则渲染默认样式文本
  final dynamic child;

  /// 超链接地址
  final String? href;

  /// 自定义光标样式，默认点击
  final MouseCursor? cursor;

  /// 默认的超链接文本颜色
  final Color color;

  /// 激活的超链接文本颜色
  final Color activeColor;

  /// 超链接下划线显示逻辑
  final HrefDecoration decoration;

  static const Color hrefColor = Color.fromRGBO(9, 105, 218, 1);

  /// 通过上下文获取最近的超链接地址
  static String? of(BuildContext context) => _HrefInheritedWidget.of(context);

  void _show(String href) {
    _delayShowOverlay = null;
    _href.value = href;

    if (_hrefOverlay == null) {
      _hrefOverlay = OverlayEntry(
        builder: (_) => const _HrefOverlay(),
      );
      Overlay.of(GlobalConfig.context).insert(_hrefOverlay!);
    }
  }

  void _hide() {
    if (_hrefOverlay != null) {
      _delayHideOverlay = null;
      _controller!.reverse();
      _delayRemoveOverlay = () {
        _delayRemoveOverlay = null;
        _hrefOverlay!.remove();
        _hrefOverlay = null;
      }.delay(_animationTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final $href = getFullHref(href);

    return _HrefInheritedWidget(
      href: $href,
      child: Builder(builder: (context) {
        return HoverBuilder(
          cursor: cursor ?? SystemMouseCursors.click,
          onEnter: $href == null
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
                  if (_hrefOverlay == null) {
                    _delayShowOverlay = (() => _show($href)).delay(_delayTime);
                  } else {
                    _show($href);
                  }
                },
          onExit: $href == null
              ? null
              : (e) {
                  if (_delayShowOverlay != null) {
                    _delayShowOverlay!.cancel();
                    _delayShowOverlay = null;
                  }
                  if (_hrefOverlay != null) {
                    _delayHideOverlay = _hide.delay(_delayTime);
                  }
                },
          builder: (context) => TapBuilder(
            onTap: $href == null ? null : () => launchUrl(Uri.parse($href)),
            builder: (context) {
              if (child is Widget) {
                return child;
              } else {
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
                    decorationColor:
                        HoverBuilder.of(context) ? activeColor : color,
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

class _HrefOverlay extends StatefulWidget {
  const _HrefOverlay();

  @override
  State<_HrefOverlay> createState() => _HrefOverlayState();
}

class _HrefOverlayState extends State<_HrefOverlay>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    _controller ??=
        AnimationController(vsync: this, duration: _animationTime.ms);
    _controller!.forward();
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
                decoration: BoxDecoration(
                  color: context.isDark
                      ? Colors.grey.shade700
                      : Colors.grey.shade300,
                  borderRadius:
                      const BorderRadius.only(topRight: Radius.circular(4)),
                ),
                child: ObsBuilder(builder: (context) {
                  return ElText(
                    _href.value,
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  );
                }),
              ),
            );
          }),
    );
  }
}
