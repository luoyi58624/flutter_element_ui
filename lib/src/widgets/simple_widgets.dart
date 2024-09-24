import 'package:flutter/widgets.dart';

class ElNullWidget extends StatelessWidget {
  const ElNullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    throw FlutterError(
      'ElNullWidget 通常用于混入 build 方法，子类如果没有执行 super.build 函数将抛出此异常',
    );
  }
}

class ElChildIndexData extends InheritedWidget {
  /// 一个功能小部件，让迭代的列表子元素确认自身所在的位置
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

  /// 迭代元素起始索引，非必需，使用前请确认是否注入
  final int? start;

  /// 迭代元素结束索引，非必需，使用前请确认是否注入
  final int? end;

  /// 迭代元素总长度，非必需，使用前请确认是否注入
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
