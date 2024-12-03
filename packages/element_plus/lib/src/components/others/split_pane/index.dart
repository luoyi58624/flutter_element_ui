import 'package:element_plus/src/global.dart';
import 'package:flutter/material.dart';

part 'theme.dart';

part '../../../generates/components/others/split_pane/index.g.dart';

/// Element UI 分割面板
class ElSplitPane extends StatefulWidget {
  const ElSplitPane({
    super.key,
    required this.child,
    this.secondChild,
    this.axis = Axis.vertical,
  });

  /// 分割面板第一个子组件，必填
  final Widget child;

  /// 分割面板另一个子组件，可选
  final Widget? secondChild;

  /// 切割方向，默认垂直方向 -> 左右切割
  final Axis axis;

  @override
  State<ElSplitPane> createState() => _ElSplitPaneState();
}

class _ElSplitPaneState extends State<ElSplitPane> {
  @override
  Widget build(BuildContext context) {
    return SizedBox();
  }
}
