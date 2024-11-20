import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ElLayout extends StatefulWidget {
  const ElLayout({
    super.key,
    this.header,
    this.body,
    this.sidebar,
    this.cacheKey,
  });

  final Widget? header;
  final Widget? body;
  final Widget? sidebar;

  /// 缓存布局信息 key
  final String? cacheKey;

  @override
  State<ElLayout> createState() => _ElLayoutState();
}

class _ElLayoutState extends State<ElLayout> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (widget.body != null)
          Positioned(
            child: widget.body!,
          ),
      ],
    );
  }
}
