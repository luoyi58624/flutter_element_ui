import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Element UI 侧边栏
class ElSidebar extends StatefulWidget {
  const ElSidebar({
    super.key,
    required this.child,
    this.width = 240,
    this.minWidth,
    this.maxWidth,
    this.expandedTop = false,
    this.enabledDrag = false,
  }) : assert(width >= 0);
  final Widget child;

  /// 侧边栏默认宽度
  final double width;

  /// 侧边栏最小宽度，当使用拖拽控件时，限制其最小宽度
  final double? minWidth;

  /// 侧边栏最大宽度，当使用拖拽控件时，限制其最大宽度
  final double? maxWidth;

  /// 侧边栏位置是否强制延伸至顶部，默认 false，若为 true，它将挤占 navbar 的空间
  final bool expandedTop;

  /// 是否开启拖拽，默认 false
  final bool enabledDrag;

  @override
  State<ElSidebar> createState() => _ElSidebarState();
}

class _ElSidebarState extends State<ElSidebar> {
  @override
  Widget build(BuildContext context) {
    late BuildContext $context;
    late FocusScopeNode focusScopeNode;
    return ElEvent(
      behavior: HitTestBehavior.opaque,
      canRequestFocus: false,
      onTap: () {
        if (focusScopeNode.hasFocus == false) {
          ElFocusScope.requestFocus($context);
        }
      },
      child: ElFocusScope(
        child: Builder(builder: (context) {
          $context = context;
          focusScopeNode = FocusScope.of(context);
          return widget.child;
        }),
      ),
    );
  }
}
