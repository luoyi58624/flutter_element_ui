import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

class ElNullWidget extends StatelessWidget {
  const ElNullWidget({super.key});

  @override
  Widget build(BuildContext context) {
    throw FlutterError('ElNullWidget Error');
  }
}

class ElCurrentColor extends InheritedWidget {
  /// 一个功能小部件，传递当前文字颜色、背景颜色
  const ElCurrentColor({
    super.key,
    this.color,
    this.bgColor,
    required super.child,
  });

  /// 当前文本颜色
  final Color? color;

  /// 当前背景颜色
  final Color? bgColor;

  static ElCurrentColor? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElCurrentColor>();

  static ElCurrentColor? of(BuildContext context) {
    final ElCurrentColor? result = maybeOf(context);
    assert(result != null, 'No ElCurrentColor found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElCurrentColor oldWidget) => true;
}

class ElChildIndex extends InheritedWidget {
  /// 一个功能小部件，让迭代的列表子元素确认自身所在的位置
  const ElChildIndex({
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

  static ElChildIndex? maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<ElChildIndex>();

  static ElChildIndex of(BuildContext context) {
    final ElChildIndex? result = maybeOf(context);
    assert(result != null, 'No ElChildIndex found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(ElChildIndex oldWidget) => true;
}
