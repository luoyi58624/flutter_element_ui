import 'package:flutter/widgets.dart';

class ElNavbar extends StatefulWidget {
  const ElNavbar({
    super.key,
    this.child,
    this.height = 56,
    this.minHeight = 40,
    this.maxHeight,
    this.enabledDrag = false,
  });

  /// 导航栏子组件，导航栏不包含任何影响你布局的内容
  final Widget? child;

  /// 导航栏高度
  final double height;

  /// 导航头最小高度，当使用拖拽控件时，限制其最小宽度
  final double minHeight;

  /// 导航头最大高度，当使用拖拽控件时，限制其最大宽度
  final double? maxHeight;

  /// 是否开启拖拽，默认 false
  final bool enabledDrag;

  @override
  State<ElNavbar> createState() => _ElNavbarState();
}

class _ElNavbarState extends State<ElNavbar> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
