import 'package:flutter/widgets.dart';

/// 一个功能小部件，让一个被迭代的列表子元素访问自身所在的位置
class ElChildIndexData extends InheritedWidget {
  const ElChildIndexData({
    super.key,
    required super.child,
    required this.index,
    this.start,
    this.end,
    this.length,
  });

  /// 当前索引
  final int index;

  /// 迭代元素起始索引
  final int? start;

  /// 迭代元素结束索引
  final int? end;

  /// 迭代元素总长度
  final int? length;

  static ElChildIndexData of(BuildContext context) {
    final ElChildIndexData? result =
        context.dependOnInheritedWidgetOfExactType<ElChildIndexData>();
    assert(result != null, 'No ElChildIndexData found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElChildIndexData oldWidget) => true;
}