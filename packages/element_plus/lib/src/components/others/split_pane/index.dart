import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/split_pane/index.g.dart';

/// Element UI 分割面板，划分的区域是以等比例进行的，同时分割面板支持无限嵌套
class ElSplitPane extends StatefulWidget {
  const ElSplitPane({
    super.key,
    required this.child,
    this.secondChild,
    this.axis = Axis.vertical,
    this.minSize = 100.0,
  });

  /// 分割面板第一个子组件，必填
  final Widget child;

  /// 分割面板另一个子组件，可选
  final Widget? secondChild;

  /// 切割方向，默认垂直方向 -> 左右切割
  final Axis axis;

  /// 被分割的两个面板最小尺寸，默认 100
  final double minSize;

  @override
  State<ElSplitPane> createState() => _ElSplitPaneState();
}

class _ElSplitPaneState extends State<ElSplitPane> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
