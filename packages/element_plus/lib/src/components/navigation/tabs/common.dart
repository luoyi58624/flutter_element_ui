import 'package:flutter/widgets.dart';

import 'index.dart';

class ElTabsInheritedWidget extends InheritedWidget {
  const ElTabsInheritedWidget({
    super.key,
    required super.child,
    required this.data,
  });

  final ElTabsData data;

  static ElTabsInheritedWidget of(BuildContext context) {
    final ElTabsInheritedWidget? result =
        context.dependOnInheritedWidgetOfExactType<ElTabsInheritedWidget>();
    assert(result != null, 'ElTabs.of 没有访问到注入的数据');
    return result!;
  }

  @override
  bool updateShouldNotify(ElTabsInheritedWidget oldWidget) => true;
}

/// [ElTabs] 提供的数据
class ElTabsData {
  /// 激活的标签索引
  final int activeIndex;
  final double size;
  final AxisDirection direction;
  final Axis axis;
  final Color bgColor;

  ElTabsData({
    required this.activeIndex,
    required this.size,
    required this.direction,
    required this.axis,
    required this.bgColor,
  });
}
