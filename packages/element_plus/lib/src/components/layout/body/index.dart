import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Element UI 主窗口
class ElBody extends StatefulWidget {
  const ElBody({
    super.key,
    this.child,
    this.minWidth,
    this.minHeight = 0.0,
  })  : assert(minWidth == null || minWidth >= 0.0),
        assert(minHeight >= 0.0);

  final Widget? child;

  /// 主窗口最小宽度，如果为 null 则以 xs 响应式断点作为最小宽度
  final double? minWidth;

  /// 主窗口最小高度
  final double minHeight;

  @override
  State<ElBody> createState() => _ElBodyState();
}

class _ElBodyState extends State<ElBody> {
  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
