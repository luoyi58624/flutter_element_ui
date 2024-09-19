import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_element_ui/src/global.dart';

import 'common.dart';

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

class LinkWidget extends ElLinkBase {
  const LinkWidget({
    super.key,
    required super.href,
    required super.builder,
    required super.title,
    required super.allowDrag,
    required super.target,
    required super.cursor,
  });

  @override
  State<LinkWidget> createState() => _LinkWidgetState();
}

class _LinkWidgetState extends ElLinkBaseState<LinkWidget> {
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
    return GestureDetector(
      onTap: () {
        toLink();
      },
      child: ElHoverBuilder(
        cursor: widget.cursor,
        onEnter: !isHttpLink
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
        onExit: !isHttpLink
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
        builder: (context) => widget.builder(context, toLink),
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
