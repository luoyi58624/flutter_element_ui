import 'package:element_plus/element_plus.dart';
import 'package:flutter/widgets.dart';

class ElNullWidget extends StatelessWidget {
  /// 永远都不应该触发的小部件，如果构建它将抛出异常，应用场景：
  /// * mixin build 覆写，如果子类没有执行 super.build，那么将抛出此异常
  /// * 当做无效 widget，例如 [ElDefaultTextStyle.of] 方法返回的默认构造
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

class ElStopPropagation extends InheritedWidget {
  /// 阻止 Element UI 部分小部件事件冒泡
  const ElStopPropagation({
    super.key,
    required super.child,
  });

  /// 从当前上下文获取 [ElStopPropagation] 实例，并以 [ElStopPropagation] 实例所在 Element Tree 的位置执行阻止冒泡函数，
  /// 通常情况下此函数由支持事件冒泡的小部件调用，并不需要用户执行它
  static void of(
    BuildContext context,
    void Function(BuildContext context) stopPropagation,
  ) {
    final result =
        context.getElementForInheritedWidgetOfExactType<ElStopPropagation>();
    if (result != null) stopPropagation(result);
  }

  @override
  bool updateShouldNotify(ElStopPropagation oldWidget) => false;
}
