import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Element UI 底部区域栏
class ElFooter extends StatefulWidget {
  const ElFooter({
    super.key,
    this.child,
    this.height = 200,
    this.minHeight = 0,
    this.maxHeight,
    this.enabledDrag = false,
    this.bgColor,
  });

  /// 底部区域栏子组件，底部区域栏不包含任何影响你布局的内容
  final Widget? child;

  /// 底部区域栏高度
  final double height;

  /// 底部区域栏最小高度，当使用拖拽控件时，限制其最小宽度
  final double minHeight;

  /// 底部区域栏最大高度，当使用拖拽控件时，限制其最大宽度
  final double? maxHeight;

  /// 是否开启拖拽，默认 false
  final bool enabledDrag;

  /// 底部区域栏背景颜色
  final Color? bgColor;

  @override
  State<ElFooter> createState() => _ElFooterState();
}

class _ElFooterState extends State<ElFooter> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
