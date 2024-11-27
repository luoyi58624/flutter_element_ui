import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Element UI 侧边栏组件
class ElSidebar extends StatefulWidget {
  const ElSidebar({
    super.key,
    required this.child,
    this.width = 240,
    this.minWidth,
    this.maxWidth,
  }) : assert(width >= 0);
  final Widget child;

  /// 侧边栏默认宽度
  final double width;

  /// 侧边栏最小宽度，当使用拖拽控件时，限制其最小宽度
  final double? minWidth;

  /// 侧边栏最大宽度，当使用拖拽控件时，限制其最大宽度
  final double? maxWidth;

  @override
  State<ElSidebar> createState() => _ElSidebarState();
}

class _ElSidebarState extends State<ElSidebar> {
  @override
  Widget build(BuildContext context) {
    return ElFocusScope(
      child: Builder(builder: (context) {
        return ElEvent(
          behavior: HitTestBehavior.opaque,
          canRequestFocus: false,
          onTap: () {
            if (FocusScope.of(context).hasFocus == false) {
              ElFocusScope.requestFocus(context);
            }
          },
          child: widget.child,
        );
      }),
    );
  }
}
