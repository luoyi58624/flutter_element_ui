import 'package:flutter/widgets.dart';
import 'package:flutter_element_ui/src/global.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:url_launcher/link.dart';
import 'package:web/web.dart';

// ignore: depend_on_referenced_packages
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'common.dart';

final _hash = urlStrategy is HashUrlStrategy ? '/#' : '';

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

  /// 将 [LinkTarget] 转换成字符串
  String get targetString {
    switch (target) {
      case LinkTarget.defaultTarget:
      case LinkTarget.self:
        return '_self';
      case LinkTarget.blank:
        return '_blank';
    }
    return '_self';
  }

  @override
  State<LinkWidget> createState() => _LinkWidgetState();
}

class _LinkWidgetState extends ElLinkBaseState<LinkWidget> {
  late HTMLLinkElement _linkElement;

  @override
  void setHref(String v) {
    if (DartUtil.isHttp(v)) {
      href = v;
    } else if (v == '' || v == '/') {
      href = '/';
    } else {
      href = (_hash + v);
    }
  }

  @override
  void didUpdateWidget(covariant LinkWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.href != oldWidget.href) {
      setHref(widget.href);
      _linkElement.href = href;
    }
    if (widget.title != oldWidget.title) {
      _linkElement.innerText = widget.title;
    }
    if (widget.target != oldWidget.target) {
      _linkElement.target = widget.targetString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: toLink,
          child: ElHoverBuilder(
            cursor: widget.cursor,
            builder: (context) => widget.builder(context, toLink),
          ),
        ),
        Positioned.fill(
          child: HtmlElementView.fromTagName(
            tagName: 'a',
            onElementCreated: (element) async {
              _linkElement = (element as HTMLLinkElement);
              _linkElement.style
                ..opacity = '0'
                ..display = 'block'
                ..width = '100%'
                ..height = '100%';
              _linkElement.href = href;
              _linkElement.target = widget.targetString;
              _linkElement.innerText = widget.title;
              // _linkElement.onClick.listen((e) {
              //   e.preventDefault();
              // });
              if (!widget.allowDrag) {
                _linkElement.onDragStart.listen((e) {
                  e.preventDefault();
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
