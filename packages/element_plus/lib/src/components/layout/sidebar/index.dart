import 'package:element_plus/element_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Element UI 侧边栏
class ElSidebar extends StatefulWidget {
  const ElSidebar({
    super.key,
    this.child,
    this.width = 240,
    this.minWidth = 0,
    this.maxWidth,
    this.enabledDrag = false,
    this.expandedTop = false,
    this.expandedBottom = false,
    this.bgColor,
  })  : assert(width >= minWidth, 'ElSidebar width 必须大于等于 minWidth'),
        assert(maxWidth == null || maxWidth >= width,
            'ElSidebar maxWidth 要么等于 null，要么必须大于 width');

  /// 侧边栏子组件，侧边栏不包含任何影响你布局的内容
  final Widget? child;

  /// 侧边栏默认宽度
  final double width;

  /// 侧边栏最小宽度，当使用拖拽控件时，限制其最小宽度
  final double minWidth;

  /// 侧边栏最大宽度，当使用拖拽控件时，限制其最大宽度
  final double? maxWidth;

  /// 是否开启拖拽，默认 false
  final bool enabledDrag;

  /// 侧边栏是否强制延伸至顶部，默认 false，若为 true，它将挤占 navbar 的空间
  final bool expandedTop;

  /// 侧边栏是否强制延伸至底部，默认 false，若为 true，它将挤占 footer 的空间
  final bool expandedBottom;

  /// 侧边栏背景颜色
  final Color? bgColor;

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
          return widget.child ?? const SizedBox();
        }),
      ),
    );
  }
}
